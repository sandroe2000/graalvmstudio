package br.com.sdvs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.sdvs.model.JSScript;
import br.com.sdvs.repository.JSScriptRepository;

import java.util.List;

import org.graalvm.polyglot.*;

@Service
public class JSScriptService {
    
    @Autowired
    private JSScriptRepository scriptRepository;
    
    public String executeScript(Long scriptId) {

        JSScript script = scriptRepository.findById(scriptId)
            .orElseThrow(() -> new RuntimeException("Script not found"));
        
        return executeJS(script.getCode());
    }
    
    public String executeJS(String code) {

        try (Context context = Context.create("js")) {
            return context.eval("js", code).toString();
        } catch (PolyglotException e) {
            throw new RuntimeException("Erro na execução do JS: " + e.getMessage());
        }
    }
    
    public JSScript save(JSScript script){
        
        return scriptRepository.save(script);
    }

    public List<JSScript> findAll(){
        return scriptRepository.findAll();
    }

    public JSScript findByLocationAndName(String location, String name){
        return scriptRepository.findByLocationAndName(location, name)
            .orElseThrow(() -> new RuntimeException("Script not found"));
    }

    public JSScript findById(Long id){
        return scriptRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Script not found"));
    }

    public void deleteById(Long scriptId){
        scriptRepository.deleteById(scriptId);
    }

    public JSScript update(JSScript entity){
        return scriptRepository.save(entity);
    }
}