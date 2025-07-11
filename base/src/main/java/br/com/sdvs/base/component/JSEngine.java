package br.com.sdvs.base.component;

import org.graalvm.polyglot.io.FileSystem;
import org.graalvm.polyglot.io.IOAccess;
import org.graalvm.polyglot.Context;
import org.graalvm.polyglot.Source;
import org.graalvm.polyglot.Value;
import org.graalvm.polyglot.HostAccess;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.function.Consumer;

import br.com.sdvs.base.model.JSParms;

public class JSEngine {

    private final DatabaseModuleService dbService;

    public JSEngine(DatabaseModuleService dbService) {
        this.dbService = dbService;
    }

    @SuppressWarnings("unchecked")
    public Map<String, Object> executeByPath(JSParms params) {

        
        Map<String, Object> finalResultMap = new HashMap<>();
        
        if(params.getPath() == null) return finalResultMap;

        try (Context context = buildContext(params)) {
            
            Source source = Source
                .newBuilder("js", params.getCode(), params.getPath())
                .mimeType("application/javascript+module")
                .build();
            
            Value exports = context.eval(source);
            Value clazz = exports.getMember(params.getName());
            Value instance = clazz.newInstance();            
            Value resultFromExecute = instance.getMember(params.getExecFunction()).execute(params.getParams());
            Value resolvedValue;

            if (isThenable(resultFromExecute)) {               
                final CompletableFuture<Value> javaFuture = new CompletableFuture<>();
                Consumer<Object> onSuccess = (resolved) -> {
                    if (resolved instanceof Value) {
                        javaFuture.complete((Value) resolved);
                    } else {
                        javaFuture.complete(context.asValue(resolved));
                    }
                };
                Consumer<Object> onFailure = (rejected) -> {
                    RuntimeException exception = new RuntimeException("Promise foi rejeitada no JavaScript: " + rejected.toString());
                    javaFuture.completeExceptionally(exception);
                };
                resultFromExecute.invokeMember("then", onSuccess, onFailure);
                resolvedValue = javaFuture.get();
            } else {
                resolvedValue = resultFromExecute;
            }
            
            if (resolvedValue != null) {
                if (resolvedValue.hasArrayElements()) {
                    List<Object> polyglotList = resolvedValue.as(List.class);
                    finalResultMap.put("resultList", new ArrayList<>(polyglotList));
                } else if (resolvedValue.hasMembers()) {
                    Map<String, Object> polyglotMap = resolvedValue.as(Map.class);
                    finalResultMap = new HashMap<>(polyglotMap);
                } else {
                    finalResultMap.put("result", resolvedValue.as(Object.class));
                }
            }
        } catch (Exception e) {
            System.err.println("Erro ao executar script ou aguardar Promise: " + e.getMessage());
            e.printStackTrace();
        }
        return finalResultMap;
    }

    private Context buildContext(JSParms params) {

        FileSystem dbFileSystem = new DatabaseFileSystem(dbService);
        String mainScriptContent = dbService.findModuleContentByPath(params.getPath()).get();

        params.setCode(mainScriptContent);

        IOAccess ioAccess = IOAccess.newBuilder()
            .fileSystem(dbFileSystem) // Nosso FileSystem virtual é passado aqui
            .allowHostFileAccess(false) // MUITO IMPORTANTE: Impede "escapes" para o HD real
            .build();

        @SuppressWarnings("unused")
        Context.Builder builder = Context.newBuilder("js")
            .allowHostAccess(HostAccess.ALL)
            .allowHostClassLookup(className -> true)
            .allowAllAccess(true)
            .allowIO(ioAccess)
            .allowExperimentalOptions(true)
            .option("js.esm-eval-returns-exports", "true");

        if (params.getCode().contains("debugger;")) {
            builder.option("inspect", "9229")
                   .option("inspect.Path", params.getSessionId().toString());
        }
        return builder.build();
    }

    private boolean isThenable(Value value) {
        if (value == null || !value.hasMembers()) {
            return false;
        }
        // A condição é: ele tem um membro chamado "then" E esse membro é uma função?
        Value thenFunction = value.getMember("then");
        return thenFunction != null && thenFunction.canExecute();
    }
}
