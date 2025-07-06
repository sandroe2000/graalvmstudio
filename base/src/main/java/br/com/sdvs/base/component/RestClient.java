package br.com.sdvs.base.component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.Map;

/**
 * Uma classe de cliente REST simples que usa as bibliotecas java.net.HttpURLConnection
 * para fazer requisições GET, POST, PUT e DELETE.
 */
public class RestClient {

    private static final int CONNECT_TIMEOUT = 5000; // 5 segundos
    private static final int READ_TIMEOUT = 10000;   // 10 segundos

    /**
     * Realiza uma requisição HTTP GET para a URL especificada.
     *
     * @param urlString A URL para a qual a requisição será feita.
     * @param headers   Um Map contendo os cabeçalhos da requisição (pode ser nulo).
     * @return A resposta da requisição como uma String.
     * @throws Exception Se ocorrer um erro durante a requisição.
     */
    public String get(String urlString, Map<String, String> headers) throws Exception {
        HttpURLConnection conn = null;
        try {
            URI uri = new URI(urlString);
            conn = (HttpURLConnection) uri.toURL().openConnection();

            // --- Configurações da Conexão ---
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(CONNECT_TIMEOUT);
            conn.setReadTimeout(READ_TIMEOUT);
            conn.setRequestProperty("Accept", "application/json"); // Define que aceitamos JSON como resposta

            // --- Adiciona os Cabeçalhos (Headers) ---
            if (headers != null) {
                for (Map.Entry<String, String> entry : headers.entrySet()) {
                    conn.setRequestProperty(entry.getKey(), entry.getValue());
                }
            }

            // --- Verifica o Código de Resposta ---
            int responseCode = conn.getResponseCode();
            if (responseCode < HttpURLConnection.HTTP_OK || responseCode >= HttpURLConnection.HTTP_MULT_CHOICE) {
                // Se o código não for de sucesso (2xx), lança uma exceção
                String errorResponse = readResponse(new BufferedReader(new InputStreamReader(conn.getErrorStream())));
                throw new RuntimeException("Falha na requisição GET: Código HTTP " + responseCode + ". Resposta: " + errorResponse);
            }

            // --- Lê a Resposta ---
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            return readResponse(in);

        } finally {
            if (conn != null) {
                conn.disconnect(); // Garante que a conexão seja sempre fechada
            }
        }
    }

    /**
     * Realiza uma requisição HTTP POST para a URL especificada com um corpo JSON.
     *
     * @param urlString  A URL para a qual a requisição será feita.
     * @param jsonBody   A String contendo o corpo da requisição em formato JSON.
     * @param headers    Um Map contendo os cabeçalhos da requisição (pode ser nulo).
     * @return A resposta da requisição como uma String.
     * @throws Exception Se ocorrer um erro durante a requisição.
     */
    public String post(String urlString, String jsonBody, Map<String, String> headers) throws Exception {
        return sendRequestWithBody("POST", urlString, jsonBody, headers);
    }

    /**
     * Realiza uma requisição HTTP PUT para a URL especificada com um corpo JSON.
     *
     * @param urlString  A URL para a qual a requisição será feita.
     * @param jsonBody   A String contendo o corpo da requisição em formato JSON.
     * @param headers    Um Map contendo os cabeçalhos da requisição (pode ser nulo).
     * @return A resposta da requisição como uma String.
     * @throws Exception Se ocorrer um erro durante a requisição.
     */
    public String put(String urlString, String jsonBody, Map<String, String> headers) throws Exception {
        return sendRequestWithBody("PUT", urlString, jsonBody, headers);
    }

    /**
     * Realiza uma requisição HTTP DELETE para a URL especificada.
     *
     * @param urlString A URL para a qual a requisição será feita.
     * @param headers   Um Map contendo os cabeçalhos da requisição (pode ser nulo).
     * @return A resposta da requisição como uma String.
     * @throws Exception Se ocorrer um erro durante a requisição.
     */
    public String delete(String urlString, Map<String, String> headers) throws Exception {
        HttpURLConnection conn = null;
        try {
            URI uri = new URI(urlString);
            conn = (HttpURLConnection) uri.toURL().openConnection();

            // --- Configurações da Conexão ---
            conn.setRequestMethod("DELETE");
            conn.setConnectTimeout(CONNECT_TIMEOUT);
            conn.setReadTimeout(READ_TIMEOUT);
            conn.setRequestProperty("Accept", "application/json");

            // --- Adiciona os Cabeçalhos (Headers) ---
            if (headers != null) {
                for (Map.Entry<String, String> entry : headers.entrySet()) {
                    conn.setRequestProperty(entry.getKey(), entry.getValue());
                }
            }

            // --- Verifica o Código de Resposta ---
            int responseCode = conn.getResponseCode();
            if (responseCode < HttpURLConnection.HTTP_OK || responseCode >= HttpURLConnection.HTTP_MULT_CHOICE) {
                String errorResponse = readResponse(new BufferedReader(new InputStreamReader(conn.getErrorStream())));
                throw new RuntimeException("Falha na requisição DELETE: Código HTTP " + responseCode + ". Resposta: " + errorResponse);
            }

            // --- Lê a Resposta (geralmente vazia para DELETE bem-sucedido) ---
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            return readResponse(in);

        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }

    /**
     * Método auxiliar genérico para requisições que enviam um corpo (POST, PUT).
     */
    private String sendRequestWithBody(String method, String urlString, String jsonBody, Map<String, String> headers) throws Exception {
        HttpURLConnection conn = null;
        try {
            URI uri = new URI(urlString);
            conn = (HttpURLConnection) uri.toURL().openConnection();

            conn.setRequestMethod(method);
            conn.setConnectTimeout(CONNECT_TIMEOUT);
            conn.setReadTimeout(READ_TIMEOUT);
            conn.setDoOutput(true);

            conn.setRequestProperty("Content-Type", "application/json; utf-8");
            conn.setRequestProperty("Accept", "application/json");
            if (headers != null) {
                for (Map.Entry<String, String> entry : headers.entrySet()) {
                    conn.setRequestProperty(entry.getKey(), entry.getValue());
                }
            }

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonBody.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            if (responseCode < HttpURLConnection.HTTP_OK || responseCode >= HttpURLConnection.HTTP_MULT_CHOICE) {
                String errorResponse = readResponse(new BufferedReader(new InputStreamReader(conn.getErrorStream())));
                throw new RuntimeException("Falha na requisição " + method + ": Código HTTP " + responseCode + ". Resposta: " + errorResponse);
            }

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            return readResponse(in);

        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }
    
    /**
     * Método auxiliar para ler o conteúdo de um BufferedReader e transformá-lo em String.
     */
    private String readResponse(BufferedReader reader) throws Exception {
        if (reader == null) return "";
        StringBuilder response = new StringBuilder();
        String inputLine;
        while ((inputLine = reader.readLine()) != null) {
            response.append(inputLine);
        }
        reader.close();
        return response.toString();
    }


    /**
     * Exemplo de como utilizar a classe.
     */
    public static void main(String[] args) {
        RestClient client = new RestClient();
        
        System.out.println("--- Exemplo de Requisição GET ---");
        try {
            String getResponse = client.get("https://jsonplaceholder.typicode.com/posts/1", null);
            System.out.println("Resposta GET:\n" + getResponse);
        } catch (Exception e) {
            System.err.println("Erro na requisição GET: " + e.getMessage());
        }

        System.out.println("\n--- Exemplo de Requisição POST ---");
        try {
            String postJson = "{\"title\":\"foo\",\"body\":\"bar\",\"userId\":1}";
            String postResponse = client.post("https://jsonplaceholder.typicode.com/posts", postJson, null);
            System.out.println("Resposta POST:\n" + postResponse);
        } catch (Exception e) {
            System.err.println("Erro na requisição POST: " + e.getMessage());
        }

        System.out.println("\n--- Exemplo de Requisição PUT ---");
        try {
            String putJson = "{\"id\":1,\"title\":\"titulo atualizado\",\"body\":\"corpo atualizado\",\"userId\":1}";
            String putResponse = client.put("https://jsonplaceholder.typicode.com/posts/1", putJson, null);
            System.out.println("Resposta PUT:\n" + putResponse);
        } catch (Exception e) {
            System.err.println("Erro na requisição PUT: " + e.getMessage());
        }

        System.out.println("\n--- Exemplo de Requisição DELETE ---");
        try {
            String deleteResponse = client.delete("https://jsonplaceholder.typicode.com/posts/1", null);
            System.out.println("Resposta DELETE:\n" + deleteResponse); // Geralmente retorna um JSON vazio {}
        } catch (Exception e) {
            System.err.println("Erro na requisição DELETE: " + e.getMessage());
        }
    }
}
