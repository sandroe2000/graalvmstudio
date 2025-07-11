package br.com.sdvs.base.dao;

import org.graalvm.polyglot.Value;

import br.com.sdvs.base.dto.TableWithQueryDTO;
import br.com.sdvs.base.infra.HikariPool;
import br.com.sdvs.base.model.JSScript;
import br.com.sdvs.base.model.JSScriptSummary;
import br.com.sdvs.base.model.StTables;

import java.sql.Date;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class JSScriptDAO {

    private final SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    
    /**
     * 
     * @param sql           -> Consulta SELECT
     * @param wrGet         -> Map<String, Object> para iterar WHERE do SELECT
     * @param rsGet         -> Map<String, Object> para iterar os Parametros de retorno do SELECT
     * @param isAppConn     -> boolean decide qual banco será consultado, false = STUDIO, true = APP
     * @return              -> Sempre será um List<Map<String, Object>> pois é como o Policlot do GraalVM esta programado para retorno.
     * @throws ParseException
     */
    public List<Map<String, Object>> select(String sql, Map<String, Object> wrGet, Map<String, Object> rsGet, boolean isAppConn) throws ParseException {
       
        List<Map<String, Object>> list = new ArrayList<>();

        Object valuesArr = null;
        Value valuesVal = null;

        Object typesArr = null;
        Value typesVal = null; 
        try (Connection conn = isAppConn ? HikariPool.getConnection() : HikariPool.getConnectionStudio();
            PreparedStatement stmt = conn.prepareStatement(sql)) {

            if(!wrGet.isEmpty()){

                valuesArr = wrGet.get("values");
                valuesVal = Value.asValue(valuesArr);
                
                typesArr = wrGet.get("types");
                typesVal = Value.asValue(typesArr);

                for (int i=0; i < valuesVal.getArraySize(); i++) {
    
                    Value values = valuesVal.getArrayElement(i);
                    Value types = typesVal.getArrayElement(i);
                    switch (types.asString()) {
                        case "Date":
                            java.util.Date date = formatter.parse(values.asString());
                            stmt.setDate(i+1, new Date(date.getTime()));
                            break;
                        case "Integer":
                            stmt.setInt(i+1, Integer.parseInt(values.asString()));
                            break;
                        case "Long":
                            stmt.setLong(i+1, Long.parseLong(values.asString()));
                            break;
                        default:
                            stmt.setString(i+1, values.asString());
                            break;
                    }
                }
            }

            ResultSet rs = stmt.executeQuery();

            valuesArr = rsGet.get("values");
            valuesVal = Value.asValue(valuesArr);
            
            typesArr = rsGet.get("types");
            typesVal = Value.asValue(typesArr);

            while(rs.next()){
                Map<String, Object> item = new HashMap<>();
                for (int i=0; i < valuesVal.getArraySize(); i++) {
                    Value values = valuesVal.getArrayElement(i);
                    Value types = typesVal.getArrayElement(i);
                    switch (types.asString()) {
                        case "Date":
                            item.put(values.asString(), rs.getDate(values.asString()));
                            break;
                        case "Integer":
                            item.put(values.asString(), rs.getInt(values.asString()));
                            break;
                        case "Long":
                            item.put(values.asString(), rs.getLong(values.asString()));
                            break;
                        default:
                            item.put(values.asString(), rs.getString(values.asString()));
                            break;
                    }                                        
                }
                list.add(item);
            }

         } catch (SQLException e) {
            // Em uma aplicação real, o logger seria usado aqui.
            throw new RuntimeException("Falha ao executar select.", e);
        }

        return list;
    }

    public List<Map<String, Object>> insertOrUpdate(String sql, Map<String, Object> rsSet, boolean isAppConn) throws ParseException{
       
        List<Map<String, Object>> result = new ArrayList<>();
        Long generatedId = null;

        try (Connection conn = isAppConn ? HikariPool.getConnection() : HikariPool.getConnectionStudio();
            PreparedStatement stmt = conn.prepareStatement(sql)) {

            Object valuesArr = rsSet.get("values");
            Value valuesVal = Value.asValue(valuesArr);
            
            Object typesArr = rsSet.get("types");
            Value typesVal = Value.asValue(typesArr);

            for (int i=0; i < valuesVal.getArraySize(); i++) {
  
                Value values = valuesVal.getArrayElement(i);
                Value types = typesVal.getArrayElement(i);
                switch (types.asString()) {
                    case "Date":
                        java.util.Date date = formatter.parse(values.asString());
                        stmt.setDate(i+1, new Date(date.getTime()));
                        break;
                    case "Integer":
                        stmt.setInt(i+1, Integer.parseInt(values.asString()));
                        break;
                    case "Long":
                        stmt.setLong(i+1, Long.parseLong(values.asString()));
                        break;
                    default:
                        stmt.setString(i+1, values.asString());
                        break;
                }
            }

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    generatedId = rs.getLong(1);
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", generatedId);
                    result.add( map );
                    return result;        
                } else {
                    throw new SQLException("Falha ao executar insert or update.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Falha ao executar insert or update.", e);
        }
    }

    public List<Map<String, Object>> delete(String sql, Map<String, Object> wrSet, boolean isAppConn) throws ParseException{
       
        List<Map<String, Object>> result = new ArrayList<>();

        try (Connection conn = isAppConn ? HikariPool.getConnection() : HikariPool.getConnectionStudio();
            PreparedStatement stmt = conn.prepareStatement(sql)) {

            Object valuesArr = wrSet.get("values");
            Value valuesVal = Value.asValue(valuesArr);
            
            Object typesArr = wrSet.get("types");
            Value typesVal = Value.asValue(typesArr);

            for (int i=0; i < valuesVal.getArraySize(); i++) {
  
                Value values = valuesVal.getArrayElement(i);
                Value types = typesVal.getArrayElement(i);
                switch (types.asString()) {
                    case "Date":
                        java.util.Date date = formatter.parse(values.asString());
                        stmt.setDate(i+1, new Date(date.getTime()));
                        break;
                    case "Integer":
                        stmt.setInt(i+1, Integer.parseInt(values.asString()));
                        break;
                    case "Long":
                        stmt.setLong(i+1, Long.parseLong(values.asString()));
                        break;
                    default:
                        stmt.setString(i+1, values.asString());
                        break;
                }
            }

            stmt.executeUpdate();

            Map<String, Object> map = new HashMap<>();
            map.put("status", "'success");
            result.add( map );
            return result;

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Falha ao executar delete.", e);
        }
    }

    /**
     * Busca um resumo de todos os scripts, sem o campo "code".
     */
    public List<JSScriptSummary> findAllSummaries() {
        List<JSScriptSummary> summaries = new ArrayList<>();
        // Note que não selecionamos a coluna "code" para performance
        String sql = "SELECT id, location, name, path, type_file, language, init_function_name FROM js_scripts ORDER BY name";

        try (Connection conn = HikariPool.getConnectionStudio();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                JSScriptSummary summary = new JSScriptSummary(
                    rs.getLong("id"),
                    rs.getString("location"),
                    rs.getString("name"),
                    rs.getString("path"),
                    rs.getString("type_file"),
                    rs.getString("language"),
                    rs.getString("init_function_name")
                );
                summaries.add(summary);
            }
        } catch (SQLException e) {
            // Em uma aplicação real, o logger seria usado aqui.
            // Lançar uma exceção de runtime é uma opção para sinalizar falha grave.
            throw new RuntimeException("Erro ao buscar resumos de scripts.", e);
        }
        return summaries;
    }

    public List<TableWithQueryDTO> findAllTablesWithQueries(){

        List<TableWithQueryDTO> result = new ArrayList<>();
        // Note que não selecionamos a coluna "code" para performance
        String sql  = "SELECT t.id AS table_id, t.tables_name AS table_name, q.id AS query_id, q.query_name AS query_name, ";
               sql += "q.query AS query_text FROM st_tables t LEFT JOIN st_tables_queries q ON t.id = q.tables_id ORDER BY t.tables_name, q.id";

        try (Connection conn = HikariPool.getConnectionStudio();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                TableWithQueryDTO dto = new TableWithQueryDTO(
                    rs.getLong("table_id"),
                    rs.getString("table_name"),
                    rs.getLong("query_id"),
                    rs.getString("query_name")
                );
                result.add(dto);
            }
        } catch (SQLException e) {
            // Em uma aplicação real, o logger seria usado aqui.
            // Lançar uma exceção de runtime é uma opção para sinalizar falha grave.
            throw new RuntimeException("Erro ao buscar tables e quearies.", e);
        }
        return result;
    }














    public JSScript findByPath(String path) {
        JSScript script = null;
        String sql = "SELECT * FROM js_scripts WHERE path = ?";

        try (Connection conn = HikariPool.getConnectionStudio();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, path);    

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    script = new JSScript(
                        rs.getLong("id"),
                        rs.getString("location"),
                        rs.getString("name"),
                        rs.getString("path"),
                        rs.getString("type_file"),
                        rs.getString("language"),
                        rs.getString("init_function_name"),
                        rs.getString("code")
                    );
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar script por path: " + path, e);
        }
        return script;
    }

    /**
     * Busca scripts pelo path, permitindo variações com LIKE.
     * Retorna uma lista de JSScript que correspondem ao path fornecido.
     */
    public List<JSScript> findByPathContains(String path) {
        List<JSScript> scripts = new ArrayList<>();
        String sql = "SELECT * FROM js_scripts WHERE lower(path) LIKE ?";

        try (Connection conn = HikariPool.getConnectionStudio();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            String likePath = path.substring(0, path.indexOf(".")).concat(".%");// Usando LIKE para permitir variações 
            stmt.setString(1, likePath.toLowerCase());    

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    JSScript script = new JSScript(
                        rs.getLong("id"),
                        rs.getString("location"),
                        rs.getString("name"),
                        rs.getString("path"),
                        rs.getString("type_file"),
                        rs.getString("language"),
                        rs.getString("init_function_name"),
                        rs.getString("code")
                    );
                    scripts.add(script);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar script por path: " + path, e);
        }
        return scripts;
    }

    /**
     * Salva um novo script no banco de dados.
     * Retorna o script salvo com o ID gerado pelo banco.
     */
    public JSScript save(JSScript script) {
        // "RETURNING id" é um recurso do PostgreSQL para obter o ID gerado eficientemente
        String sql = "INSERT INTO js_scripts (location, name, path, type_file, language, init_function_name, code) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?) RETURNING id";

        try (Connection conn = HikariPool.getConnectionStudio();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, script.location());
            stmt.setString(2, script.name());
            stmt.setString(3, script.path());
            stmt.setString(4, script.typeFile());
            stmt.setString(5, script.language());
            stmt.setString(6, script.initFunctionName());
            stmt.setString(7, script.code());

            // Executa o insert e obtém o resultado com o ID gerado
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Long generatedId = rs.getLong(1);
                    // Retorna um novo objeto record com o ID preenchido
                    return new JSScript(generatedId, script.location(), script.name(), script.path(), script.typeFile(), script.language(), script.initFunctionName(), script.code());
                } else {
                    throw new SQLException("Falha ao criar script, nenhum ID foi retornado.");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao salvar novo script.", e);
        }
    }

    public JSScript update(JSScript script) {
        // "RETURNING id" é um recurso do PostgreSQL para obter o ID gerado eficientemente
        String sql = "UPDATE js_scripts set location = ?, name = ?, path = ?, type_file = ?, language = ?, init_function_name = ?, code = ? " +
                     "WHERE id = ? RETURNING id";

        try (Connection conn = HikariPool.getConnectionStudio();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, script.location());
            stmt.setString(2, script.name());
            stmt.setString(3, script.path());
            stmt.setString(4, script.typeFile());
            stmt.setString(5, script.language());
            stmt.setString(6, script.initFunctionName());
            stmt.setString(7, script.code());
            stmt.setLong(8, script.id());

            // Executa o insert e obtém o resultado com o ID gerado
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new JSScript(rs.getLong("id"), script.location(), script.name(), script.path(), script.typeFile(), script.language(), script.initFunctionName(), script.code());
                } else {
                    throw new SQLException("Falha ao criar script, nenhum ID foi retornado.");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao salvar novo script.", e);
        }
    }

    /********************** DATABASE METHODS **********************/

    public void saveTable(StTables stTables) {
        String sql = "INSERT INTO st_tables (tables_name, created_by, updated_by) VALUES (?, ?, ?) RETURNING id";
        try (Connection conn = HikariPool.getConnectionStudio();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, stTables.getTables_name());
            stmt.setLong(2, stTables.getCreated_by());
            stmt.setLong(3, stTables.getUpdated_by());
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao salvar tabela.", e);
        }
    }

    public List<Map<String, Object>> getTableColumns(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("O ID da tabela não pode ser nulo.");
        }

        String sql = "SELECT * FROM st_table_columns WHERE tables_id = ?";
        List<Map<String, Object>> columns = new ArrayList<>();

        try (Connection conn = HikariPool.getConnectionStudio();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> column = new HashMap<>();
                    column.put("id", rs.getLong("id"));
                    column.put("columns_name", rs.getString("columns_name"));
                    column.put("data_type", rs.getString("data_type"));
                    column.put("length", rs.getInt("length"));
                    column.put("default_value", rs.getString("default_value"));
                    column.put("index_search", rs.getBoolean("index_search"));
                    column.put("is_required", rs.getBoolean("is_required"));
                    column.put("fk_table", rs.getString("fk_table"));
                    columns.add(column);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar colunas da tabela com ID: " + id, e);
        }
        return columns;
    }

    public List<Map<String, Object>> getTables() {
        String sql = "SELECT * FROM st_tables";
        List<Map<String, Object>> tables = new ArrayList<>();

        try (Connection conn = HikariPool.getConnectionStudio();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> table = new HashMap<>();
                table.put("id", rs.getLong("id"));
                table.put("tables_name", rs.getString("tables_name"));
                table.put("created_by", rs.getLong("created_by"));
                table.put("updated_by", rs.getLong("updated_by"));
                tables.add(table);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar tabelas.", e);
        }
        return tables;
    }

    public void updateColumn(Map<String, Object> params) {

        String sql  = "UPDATE st_table_columns SET columns_name = ?, data_type = ?, length = ?, default_value = ?, index_search = ?, ";
               sql += "is_required = ?, fk_table = ?, updated_by = ? WHERE id = ? AND tables_id = ?";

        try (Connection conn = HikariPool.getConnectionStudio();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, (String) params.get("columns_name"));
            stmt.setString(2, (String) params.get("data_type"));
            stmt.setInt(3, (Integer.parseInt(params.getOrDefault("length", 0).toString())));
            stmt.setString(4, (String) params.getOrDefault("default_value", ""));
            stmt.setString(5, (String) params.getOrDefault("index_search", false));
            stmt.setString(6, (String) params.getOrDefault("is_required", false));
            stmt.setString(7, (String) params.getOrDefault("fk_table", ""));
            stmt.setLong(8, (Long.parseLong(params.get("tables_id").toString())));
            stmt.setLong(9, 1L);
            stmt.setLong(10, (Long.parseLong(params.get("tables_id").toString())));            
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar coluna.", e);
        }
    }

    public Map<String, Object> addColumn(Map<String, Object> params) {

        Map<String, Object> columns = new HashMap<>();
        String sql  = "INSERT INTO st_table_columns (tables_id, columns_name, data_type, length, default_value, index_search, is_required, ";
               sql += "fk_table, created_by, updated_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id";

        try (Connection conn = HikariPool.getConnectionStudio();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, (Long.parseLong(params.get("tables_id").toString())));
            stmt.setString(2, (String) params.get("columns_name"));
            stmt.setString(3, (String) params.get("data_type"));
            stmt.setInt(4, (Integer.parseInt(params.getOrDefault("length", 0).toString())));
            stmt.setString(5, (String) params.getOrDefault("default_value", ""));
            stmt.setString(6, (String) params.getOrDefault("index_search", false));
            stmt.setString(7, (String) params.getOrDefault("is_required", false));
            stmt.setString(8, (String) params.getOrDefault("fk_table", ""));
            stmt.setLong(9, 1L);
            stmt.setLong(10, 1L);
            
            // Executa o insert e obtém o resultado com o ID gerado
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    columns.put("id", rs.getLong("id"));
                    columns.put("columns_name", params.get("columns_name"));
                    columns.put("data_type", params.get("data_type"));   
                    columns.put("length", params.getOrDefault("length", 0));
                    columns.put("default_value", params.getOrDefault("default_value", ""));
                    columns.put("index_search", params.getOrDefault("index_search", false));
                    columns.put("is_required", params.getOrDefault("is_required", false));   
                    columns.put("fk_table", params.getOrDefault("fk_table", ""));
                } else {
                    throw new SQLException("Falha ao criar script, nenhum ID foi retornado.");
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao adicionar coluna.", e);
        }
        return columns;
    }
}
