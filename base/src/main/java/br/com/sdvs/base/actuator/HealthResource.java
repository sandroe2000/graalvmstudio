package br.com.sdvs.base.actuator;

import br.com.sdvs.base.infra.HikariPoll;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.sql.Connection;
import java.util.LinkedHashMap;
import java.util.Map;

@Path("/health")
@Produces(MediaType.APPLICATION_JSON)
public class HealthResource {

    @GET
    public Response checkHealth() {
        Map<String, Object> health = new LinkedHashMap<>();
        
        try {
            // Verifica a saúde do banco de dados
            checkDatabase(health);
            
            // Se todas as checagens passaram, o status geral é UP
            health.put("status", "UP");
            return Response.ok(health).build();
            
        } catch (Exception e) {
            // Se qualquer checagem falhar, o status geral é DOWN
            health.put("status", "DOWN");
            // Retorna status HTTP 503 - Service Unavailable
            return Response.status(Response.Status.SERVICE_UNAVAILABLE).entity(health).build();
        }
    }

    private void checkDatabase(Map<String, Object> health) {
        Map<String, String> dbHealth = new LinkedHashMap<>();
        try (Connection conn = HikariPoll.getConnection()) {
            // O timeout de 1 segundo é para a conexão não ficar presa
            if (conn.isValid(1)) {
                dbHealth.put("status", "UP");
            } else {
                dbHealth.put("status", "DOWN");
                throw new RuntimeException("Database connection is not valid.");
            }
        } catch (Exception e) {
            dbHealth.put("status", "DOWN");
            dbHealth.put("error", e.getClass().getName() + ": " + e.getMessage());
            health.put("components", Map.of("database", dbHealth));
            throw new RuntimeException("Failed to connect to database", e);
        }
        health.put("components", Map.of("database", dbHealth));
    }
}
