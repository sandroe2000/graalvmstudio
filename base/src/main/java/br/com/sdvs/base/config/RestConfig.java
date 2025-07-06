package br.com.sdvs.base.config;

import org.glassfish.jersey.jsonb.JsonBindingFeature;
import org.glassfish.jersey.server.ResourceConfig;

// Esta classe configura o Jersey para escanear os pacotes em busca de recursos JAX-RS (@Path)
public class RestConfig extends ResourceConfig {
    public RestConfig() {
        // Escaneia o pacote onde estão os recursos REST
        packages("br.com.sdvs.base.rest", "br.com.sdvs.base.actuator");
        // 2. REGISTRE EXPLICITAMENTE O RECURSO DE CONVERSÃO JSON-B
        // Esta linha diz ao Jersey: "Por favor, ative e use o módulo que
        // sabe como converter objetos para JSON e vice-versa".
        register(JsonBindingFeature.class);
    }
}
