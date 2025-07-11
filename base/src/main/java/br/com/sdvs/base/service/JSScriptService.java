package br.com.sdvs.base.service;

import br.com.sdvs.base.dao.JSScriptDAO;
import br.com.sdvs.base.dto.TableWithQueryDTO;
import br.com.sdvs.base.dto.JSScriptDTO;
import br.com.sdvs.base.model.DBTreeNode;
import br.com.sdvs.base.model.JSScript;
import br.com.sdvs.base.model.JSScriptSummary;
import br.com.sdvs.base.model.StTables;
import br.com.sdvs.base.model.TreeNode;
//import jakarta.ws.rs.NotFoundException; // Exceção padrão do JAX-RS para 404

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class JSScriptService {

    private final JSScriptDAO dao;

    public JSScriptService() {
        this.dao = new JSScriptDAO();
    }

    /**
     * Constrói e retorna a lista de nós raiz da árvore de tabelas e queries.
     *
     * @return A lista de nós que representam as tabelas (o primeiro nível da árvore).
     */
    public List<DBTreeNode> buildDBTree() {
        // 1. Busca a lista plana de resultados do banco de dados.
        List<TableWithQueryDTO> results = dao.findAllTablesWithQueries();

        // 2. Usa um Map para agrupar as queries sob o nó da tabela correta.
        Map<Long, DBTreeNode> tableNodes = new LinkedHashMap<>();

        // 3. Itera sobre cada linha do resultado da consulta.
        for (TableWithQueryDTO row : results) {
            // 4. Procura pelo nó da tabela no Map. Se não existir, cria um novo.
            DBTreeNode tableNode = tableNodes.computeIfAbsent(
                row.tableId(),
                id -> new DBTreeNode(id, row.tableName(), "folder", "table")
            );

            // 5. Se a linha atual contém uma query, cria um nó para ela.
            if (row.queryId() != null && row.queryId() > 0) {
                // <<< LÓGICA ATUALIZADA >>>
                // Usa o novo campo 'title' para o nome do nó.
                // Se o título for nulo ou vazio, usa o nome antigo como fallback.
                String queryNodeName = (row.queryTitle() != null && !row.queryTitle().isBlank())
                                       ? row.queryTitle()
                                       : "Query " + row.queryId();

                DBTreeNode queryNode = new DBTreeNode(row.queryId(), queryNodeName, "file", "sql");
                tableNode.addChild(queryNode);
            }
        }

        // 6. Retorna os nós da tabela.
        return new ArrayList<>(tableNodes.values());
    }

    public List<TreeNode> buildFileTree() {
        // 1. Busca todos os resumos (que contêm os paths)
        List<JSScriptSummary> summaries = dao.findAllSummaries();

        // 2. Cria um nó "raiz" virtual para facilitar a construção
        TreeNode root = new TreeNode("root", "folder", "", "folder");
        
        // 3. Itera sobre cada script para construir a árvore
        for (JSScriptSummary summary : summaries) {
            String fullPath = summary.path();
            // Remove a barra inicial, se houver, e divide o caminho em partes
            String[] parts = fullPath.startsWith("/") ? fullPath.substring(1).split("/") : fullPath.split("/");
            
            TreeNode currentNode = root;
            StringBuilder currentPath = new StringBuilder();

            for (int i = 0; i < parts.length; i++) {
                String part = parts[i];
                boolean isLastPart = (i == parts.length - 1);
                
                currentPath.append("/").append(part);
                
                // Verifica se o nó já existe na árvore
                TreeNode childNode = currentNode.findChild(part);
                
                if (childNode == null) {
                    // Se não existe, cria um novo nó
                    String type = isLastPart ? "file" : "folder";
                    childNode = new TreeNode(part, type, currentPath.toString(), summary.language());
                    currentNode.addChild(childNode);
                }
                
                // Desce para o próximo nível da árvore
                currentNode = childNode;
            }
        }
        
        // Retorna os filhos da raiz, que é a primeira camada da sua árvore
        return root.getChildren();
    }

    public List<JSScriptSummary> getAllScripts() {
        return dao.findAllSummaries();
    }

    public JSScript findByPath(String path) {
        // Exemplo de lógica de negócio: tratar o caso de não encontrar o script
        return dao.findByPath(path);
    }

    public List<JSScript> findByPathContains(String path) {
        // Exemplo de lógica de negócio: tratar o caso de não encontrar o script
        return dao.findByPathContains(path);
    }

    public JSScript createScript(JSScriptDTO dto) {
        // Exemplo de lógica de negócio: validação simples antes de salvar
        if (dto.name() == null || dto.name().isBlank()) {
            throw new IllegalArgumentException("O nome do script não pode ser vazio.");
        }

        JSScript scriptToSave = new JSScript(
            null, // ID é nulo na criação
            dto.location(),
            dto.name(),
            dto.path(),
            dto.typeFile(),
            dto.language(),
            dto.initFunctionName(),
            dto.code()
        );
        return dao.save(scriptToSave);
    }

    public JSScript updateScript(JSScript script, Long id) {
        // Exemplo de lógica de negócio: validação simples antes de salvar
        if (id == null || script.name() == null || script.name().isBlank()) {
            throw new IllegalArgumentException("O id do script não pode ser vazio.");
        }
        return dao.update(script);
    }

    /********************** DATABASE METHODS **********************/

    public Map<String, Object> addTable(Map<String, Object> params) {

        String name = (String) params.get("name");
        if (name == null || name.isBlank()) {
            throw new IllegalArgumentException("O nome da tabela não pode ser vazio.");
        }

        StTables stTables = new StTables();
        stTables.setTables_name(name);
        stTables.setCreated_by(1L); // Definindo um usuário padrão, pode ser alterado conforme necessário
        stTables.setUpdated_by(1L); // Definindo um usuário padrão, pode ser alterado conforme necessário
        
        dao.saveTable(stTables);
        
        return Map.of("status", "success", "tableName", stTables.getTables_name());
    }


    public Map<String, Object> getTableColumns(Long id){
        if (id == null) {
            throw new IllegalArgumentException("O ID da tabela não pode ser nulo.");
        }

        List<Map<String, Object>> columns = dao.getTableColumns(id);
        if (columns == null || columns.isEmpty()) {
            throw new RuntimeException("Tabela não encontrada ou sem colunas.");
        }

        return Map.of("status", "success", "result", columns);
    }

    public List<Map<String, Object>> getTables() {
        List<Map<String, Object>> tables = dao.getTables();
        if (tables == null || tables.isEmpty()) {
            throw new RuntimeException("Nenhuma tabela encontrada.");
        }
        return tables;
    }

    public void updateColumn(Map<String, Object> params) {
        dao.updateColumn(params);
    }


    public Map<String, Object> addColumn(Map<String, Object> params) {
        return dao.addColumn(params);
    }
}
