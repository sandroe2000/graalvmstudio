package br.com.sdvs.base.service;

import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.GenericType;

import java.util.Map;
import org.glassfish.jersey.client.ClientProperties;

/**
 * Uma classe de cliente REST genérica e moderna usando a API de Cliente do Jakarta REST (JAX-RS).
 * Ela é AutoCloseable para garantir que os recursos sejam liberados corretamente.
 */
public class GenericRestClient implements AutoCloseable {

    private final Client client;

    public GenericRestClient() {
        // Cria uma instância do cliente JAX-RS.
        // A configuração de timeouts é feita aqui.
        this.client = ClientBuilder.newClient();
        this.client.property(ClientProperties.CONNECT_TIMEOUT, 5000); // 5 segundos
        this.client.property(ClientProperties.READ_TIMEOUT, 10000);    // 10 segundos
    }

    /**
     * Realiza uma requisição HTTP GET e mapeia a resposta para o tipo de classe especificado.
     * @param urlString A URL do endpoint.
     * @param headers Cabeçalhos da requisição (pode ser nulo).
     * @param responseType A classe do objeto esperado na resposta.
     * @return O objeto de resposta deserializado.
     */
    public <T> T get(String urlString, Map<String, String> headers, Class<T> responseType) {
        // Constrói o "alvo" da requisição e adiciona os headers
        Invocation.Builder requestBuilder = buildRequest(urlString, headers);
        
        // Executa a requisição e processa a resposta
        try (Response response = requestBuilder.get()) {
            handleError(response, "GET");
            return response.readEntity(responseType);
        }
    }

    public String getString(String urlString, Map<String, String> headers) {
        // Constrói o "alvo" da requisição e adiciona os headers
        Invocation.Builder requestBuilder = buildRequest(urlString, headers);
        
        // Executa a requisição e processa a resposta
        try (Response response = requestBuilder.get()) {
            handleError(response, "GET");
            return response.readEntity( new GenericType<String>() {} );
        }
    }

    /**
     * Realiza uma requisição HTTP POST, enviando um objeto e esperando uma resposta.
     * @param urlString A URL do endpoint.
     * @param requestBody O objeto a ser enviado no corpo da requisição (será serializado para JSON).
     * @param headers Cabeçalhos da requisição (pode ser nulo).
     * @param responseType A classe do objeto esperado na resposta.
     * @return O objeto de resposta deserializado.
     */
    public <T> T post(String urlString, Object requestBody, Map<String, String> headers, Class<T> responseType) {
        Invocation.Builder requestBuilder = buildRequest(urlString, headers);
        Entity<?> entity = Entity.entity(requestBody, MediaType.APPLICATION_JSON);
        
        try (Response response = requestBuilder.post(entity)) {
            handleError(response, "POST");
            return response.readEntity(responseType);
        }
    }

    /**
     * Realiza uma requisição HTTP PUT.
     */
    public <T> T put(String urlString, Object requestBody, Map<String, String> headers, Class<T> responseType) {
        Invocation.Builder requestBuilder = buildRequest(urlString, headers);
        Entity<?> entity = Entity.entity(requestBody, MediaType.APPLICATION_JSON);
        
        try (Response response = requestBuilder.put(entity)) {
            handleError(response, "PUT");
            return response.readEntity(responseType);
        }
    }

    /**
     * Realiza uma requisição HTTP DELETE.
     */
    public void delete(String urlString, Map<String, String> headers) {
        Invocation.Builder requestBuilder = buildRequest(urlString, headers);
        
        try (Response response = requestBuilder.delete()) {
            handleError(response, "DELETE");
            // Geralmente não há corpo na resposta de um DELETE bem-sucedido
        }
    }

    /**
     * Método auxiliar para construir o objeto de requisição com URL e headers.
     */
    private Invocation.Builder buildRequest(String urlString, Map<String, String> headers) {
        WebTarget target = client.target(urlString);
        Invocation.Builder requestBuilder = target.request(MediaType.APPLICATION_JSON);
        if (headers != null) {
            headers.forEach(requestBuilder::header);
        }
        return requestBuilder;
    }
    
    /**
     * Método auxiliar para verificar se a resposta foi bem-sucedida.
     */
    private void handleError(Response response, String method) {
        if (response.getStatusInfo().getFamily() != Response.Status.Family.SUCCESSFUL) {
            String errorEntity = "";
            if (response.hasEntity()) {
                errorEntity = response.readEntity(String.class);
            }
            throw new RuntimeException(
                "Falha na requisição " + method + ": Código HTTP " + response.getStatus() + ". Resposta: " + errorEntity
            );
        }
    }

    @Override
    public void close() {
        // Garante que os recursos do cliente (como pool de conexões) sejam liberados.
        this.client.close();
    }
    
    // --- Exemplo de Uso ---
    
    // DTO para o exemplo
    public record PostDTO(Integer id, Integer userId, String title, String body) {}
    
    public static void main(String[] args) {
        // Use try-with-resources para garantir que o cliente seja fechado
        try (GenericRestClient client = new GenericRestClient()) {
            
            System.out.println("--- Exemplo de Requisição GET ---");
            try {
                @SuppressWarnings("unchecked")
                Map<String, Object> getResponse = (Map<String, Object>) client.get("https://jsonplaceholder.typicode.com/posts/1", null, Map.class);
                System.out.println("Resposta GET:\n" + getResponse);
            } catch (Exception e) {
                System.err.println("Erro na requisição GET: " + e.getMessage());
            }

            System.out.println("\n--- Exemplo de Requisição POST ---");
            try {
                Map<String, Object> newPost = Map.of(
                    "userId", 1,
                    "title", "foo",
                    "body", "bar"
                );
                @SuppressWarnings("unchecked")
                Map<String, Object> postResponse = (Map<String, Object>) client.post("https://jsonplaceholder.typicode.com/posts", newPost, null, Map.class);
                System.out.println("Resposta POST:\n" + postResponse);
            } catch (Exception e) {
                System.err.println("Erro na requisição POST: " + e.getMessage());
            }

             System.out.println("\n--- Exemplo de Requisição PUT ---");
            try {
                PostDTO updatedPost = new PostDTO(1, 1, "titulo atualizado", "corpo atualizado");
                PostDTO putResponse = client.put("https://jsonplaceholder.typicode.com/posts/1", updatedPost, null, PostDTO.class);
                System.out.println("Resposta PUT:\n" + putResponse);
            } catch (Exception e) {
                System.err.println("Erro na requisição PUT: " + e.getMessage());
            }

            System.out.println("\n--- Exemplo de Requisição DELETE ---");
            try {
                client.delete("https://jsonplaceholder.typicode.com/posts/1", null);
                System.out.println("Resposta DELETE: Sucesso!");
            } catch (Exception e) {
                System.err.println("Erro na requisição DELETE: " + e.getMessage());
            }
        }
    }
}
