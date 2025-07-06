package br.com.sdvs.base.actuator;

import br.com.sdvs.base.infra.MetricsRegistry;
import io.micrometer.prometheus.PrometheusMeterRegistry;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/metrics")
public class MetricsResource {

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public Response getMetrics() {
        PrometheusMeterRegistry registry = MetricsRegistry.getRegistry();
        // O método scrape() gera o texto no formato que o Prometheus entende
        return Response.ok(registry.scrape()).build();
    }
}