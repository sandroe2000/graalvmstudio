package br.com.sdvs.base.infra;

import io.micrometer.core.instrument.Clock;
import io.micrometer.core.instrument.binder.jvm.JvmMemoryMetrics;
import io.micrometer.prometheus.PrometheusConfig;
import io.micrometer.prometheus.PrometheusMeterRegistry;
import io.prometheus.client.CollectorRegistry;

public class MetricsRegistry {

    private static final PrometheusMeterRegistry registry;

    static {
        CollectorRegistry collectorRegistry = new CollectorRegistry();
        registry = new PrometheusMeterRegistry(PrometheusConfig.DEFAULT, collectorRegistry, Clock.SYSTEM);
        registry.config().commonTags("application", "base-app");

        new JvmMemoryMetrics().bindTo(registry);
    }

    private MetricsRegistry() {}

    public static PrometheusMeterRegistry getRegistry() {
        return registry;
    }
}
