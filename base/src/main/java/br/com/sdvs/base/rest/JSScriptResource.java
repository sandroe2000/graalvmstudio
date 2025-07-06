package br.com.sdvs.base.rest;

import br.com.sdvs.base.component.DatabaseModuleService;
import br.com.sdvs.base.component.JSEngine;
import br.com.sdvs.base.dto.JSScriptDTO;
import br.com.sdvs.base.model.DBTreeNode;
import br.com.sdvs.base.model.JSParms;
import br.com.sdvs.base.model.JSScript;
import br.com.sdvs.base.model.JSScriptSummary;
import br.com.sdvs.base.model.TreeNode;
import br.com.sdvs.base.service.JSScriptService;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Map;

@Path("/jsscripts")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class JSScriptResource {

    private static final Logger logger = LoggerFactory.getLogger(JSScriptResource.class);
    private final JSScriptService service;
    private final DatabaseModuleService dbService;
    private final JSEngine jsEngine;

    public JSScriptResource() {
        this.service = new JSScriptService();
        this.dbService = new DatabaseModuleService(this.service);
        this.jsEngine = new JSEngine(this.dbService);
    }

    @GET
    @Path("/dBTree")
    public Response buildDBTree() {
        logger.info("Construindo a árvore de arquivos.");
        List<DBTreeNode> tree = service.buildDBTree(); 
        return Response.ok(tree).build();
    }

    @GET
    @Path("/tree")
    public Response getFileTree() {
        logger.info("Construindo a árvore de arquivos.");
        List<TreeNode> tree = service.buildFileTree();
        return Response.ok(tree).build();
    }

    @GET
    public Response getAllScripts() {
        logger.info("Buscando lista de todos os scripts.");
        List<JSScriptSummary> scripts = service.getAllScripts();
        return Response.ok(scripts).build();
    }

    @GET
    @Path("/findByPath")
    public Response findByPath(@QueryParam("path") String path) {
        logger.info("Buscando script com path: {}", path);
        // A exceção NotFoundException lançada pelo serviço será automaticamente
        // convertida pelo Jersey para uma resposta HTTP 404 Not Found.
        JSScript script = service.findByPath(path);
        return Response.ok(script).build();
    }

    @GET
    @Path("/findByPathContains")
    public Response findByPathContains(@QueryParam("path") String path) {
        logger.info("Buscando script com path: {}", path);
        // A exceção NotFoundException lançada pelo serviço será automaticamente
        // convertida pelo Jersey para uma resposta HTTP 404 Not Found.
        List<JSScript> scripts = service.findByPathContains(path);
        return Response.ok(scripts).build();
    }

    @POST
    @Path("/execute")
    @Consumes(MediaType.APPLICATION_JSON)
    public Map<String, Object> executeByPath(JSParms params) {
        return jsEngine.executeByPath(params);
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response createScript(JSScriptDTO dto) {
        try {
            logger.info("Recebida requisição para criar um novo script: {}", dto.name());
            JSScript createdScript = service.createScript(dto);
            // Retorna status 201 Created e o objeto criado
            return Response.status(Response.Status.CREATED).entity(createdScript).build();
        } catch (IllegalArgumentException e) {
            // Se a validação do serviço falhar, retorna um 400 Bad Request
            return Response.status(Response.Status.BAD_REQUEST).entity(e.getMessage()).build();
        }
    }

    @PUT
    @Path("/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateScript(JSScript script, @PathParam("id") Long id) {
        try {
            logger.info("Recebida requisição para atualizar um script: {}", script.name());
            JSScript updatedScript = service.updateScript(script, id);
            // Retorna status 200 e o objeto atualizado
            return Response.status(Response.Status.OK).entity(updatedScript).build();
        } catch (IllegalArgumentException e) {
            // Se a validação do serviço falhar, retorna um 400 Bad Request
            return Response.status(Response.Status.BAD_REQUEST).entity(e.getMessage()).build();
        }
    }

    /********************** DATABASE METHODS **********************/

    @POST
    @Path("/tables")
    @Consumes(MediaType.APPLICATION_JSON)
    public Map<String, Object> addTable(Map<String, Object> params) {
        return service.addTable(params);
    }

    @GET
    @Path("/tables/{id}/columns")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response getTableColumns(@PathParam("id") Long id) {
        logger.info("Buscando colunas da tabela com ID: {}", id);
        Map<String, Object> columns = service.getTableColumns(id); 
        if (columns == null || columns.isEmpty()) {
            return Response.status(Response.Status.NOT_FOUND).entity("Tabela não encontrada ou sem colunas.").build();
        }
        return Response.ok(columns).build();
    }

    @GET
    @Path("/tables")
    public Response getTables() {
        logger.info("Buscando todas as tabelas.");
        List<Map<String, Object>> tables = service.getTables();
        if (tables == null || tables.isEmpty()) {
            return Response.status(Response.Status.NOT_FOUND).entity("Nenhuma tabela encontrada.").build();
        }
        return Response.ok(tables).build();
    }

    @PUT
    @Path("/tables/columns/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response updateColumn(Map<String, Object> params, @PathParam("id") Long id) {
        logger.info("Atualizando tabela com ID: {}", id);
       
        String columns_name = (String) params.get("columns_name");
        String data_type = (String) params.get("data_type");
        
        if (columns_name == null || columns_name.isBlank()) {
            throw new IllegalArgumentException("O nome da coluna não pode ser vazio.");
        }
        if (data_type == null || data_type.isBlank()) {
            throw new IllegalArgumentException("O tipo da coluna não pode ser vazio.");
        }

        service.updateColumn(params);

        return Response.ok(Map.of("status", "success")).build();
    }

    @POST
    @Path("/tables/columns")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response addColumn(Map<String, Object> params) {
        logger.info("Adicionando coluna à tabela.");

        String columns_name = (String) params.get("columns_name");
        String data_type = (String) params.get("data_type");

        if (columns_name == null || columns_name.isBlank()) {
            throw new IllegalArgumentException("O nome da coluna não pode ser vazio.");
        }
        if (data_type == null || data_type.isBlank()) {
            throw new IllegalArgumentException("O tipo da coluna não pode ser vazio.");
        }
        
        Map<String, Object> column = service.addColumn(params);
        return Response.status(Response.Status.CREATED).entity(column).build();
    }
}