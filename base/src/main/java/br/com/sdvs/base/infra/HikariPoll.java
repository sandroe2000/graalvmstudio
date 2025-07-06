package br.com.sdvs.base.infra;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import io.micrometer.core.instrument.MeterRegistry;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class HikariPoll {

    private static final HikariDataSource dataSource;
    private static final HikariDataSource dataSourceStudio;

    static {
        HikariConfig config = new HikariConfig();

        config.setMinimumIdle(5);
        config.setMaximumPoolSize(5);
        config.setMaxLifetime(1800000);
        config.setConnectionTimeout(30000);
        config.setValidationTimeout(5000);
        config.setKeepaliveTime(600000);

        config.setJdbcUrl("jdbc:postgresql://localhost:5432/crm");
        config.setUsername("postgres");
        config.setPassword("postgres!");
        config.setDriverClassName("org.postgresql.Driver");
        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("prepStmtCacheSize", "250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");


        HikariConfig configStusio = new HikariConfig();

        configStusio.setMinimumIdle(5);
        configStusio.setMaximumPoolSize(5);
        configStusio.setMaxLifetime(1800000);
        configStusio.setConnectionTimeout(30000);
        configStusio.setValidationTimeout(5000);
        configStusio.setKeepaliveTime(600000);

        configStusio.setJdbcUrl("jdbc:postgresql://localhost:5432/studio");
        configStusio.setUsername("postgres");
        configStusio.setPassword("postgres!");
        configStusio.setDriverClassName("org.postgresql.Driver");
        configStusio.addDataSourceProperty("cachePrepStmts", "true");
        configStusio.addDataSourceProperty("prepStmtCacheSize", "250");
        configStusio.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
        configStusio.setMinimumIdle(5);
        configStusio.setMaximumPoolSize(5);

        MeterRegistry meterRegistry = MetricsRegistry.getRegistry();

        config.setMetricRegistry(meterRegistry);
        configStusio.setMetricRegistry(meterRegistry);

        dataSource = new HikariDataSource(config);
        dataSourceStudio = new HikariDataSource(configStusio);

    }

    private HikariPoll() {}

    public static DataSource getDataSource() {
        return dataSource;
    }

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    public static DataSource getDataSourceStudio() {
        return dataSourceStudio;
    }

    public static Connection getConnectionStudio() throws SQLException {
        return dataSourceStudio.getConnection();
    }
}