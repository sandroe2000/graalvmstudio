package br.com.sdvs.base.actuator;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.io.InputStream;
import java.util.Map;
import java.util.Properties;
import java.util.TreeMap;

@Path("/info")
@Produces(MediaType.APPLICATION_JSON)
public class InfoResource {

    private static final Properties appProperties = new Properties();

    static {
        // Carrega as propriedades uma vez quando a classe é iniciada
        try (InputStream is = InfoResource.class.getResourceAsStream("/application.properties")) {
            if (is != null) {
                appProperties.load(is);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Logar em um sistema real
        }
    }

    @SuppressWarnings({ "unchecked", "unused" })
    @GET
    public Response getInfo() {
        Map<String, Object> info = new TreeMap<>();
        appProperties.forEach((key, value) -> {
            String[] keys = key.toString().split("\\.");
            Map<String, Object> currentMap = info;
            for (int i = 0; i < keys.length - 1; i++) {
                currentMap = (Map<String, Object>) currentMap.computeIfAbsent(keys[i], k -> new TreeMap<>());
            }
            currentMap.put(keys[keys.length - 1], value);
        });

        return Response.ok(info).build();
    }
}
