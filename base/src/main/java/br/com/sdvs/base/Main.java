package br.com.sdvs.base;

import br.com.sdvs.base.config.CharacterEncodingFilter;
import br.com.sdvs.base.config.RestConfig;
import jakarta.servlet.DispatcherType;

import java.util.EnumSet;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.servlet.FilterHolder;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;
import org.glassfish.jersey.servlet.ServletContainer;
import org.eclipse.jetty.servlets.CrossOriginFilter;

public class Main {
    
    public static void main(String[] args) throws Exception {
        int port = 8080;
        Server server = new Server(port);

        ServletContextHandler context = new ServletContextHandler(ServletContextHandler.SESSIONS);
        context.setContextPath("/");

        // Filtro de Encoding (já tínhamos)
        context.addFilter(new FilterHolder(CharacterEncodingFilter.class), "/*", EnumSet.of(DispatcherType.REQUEST));

        // ===== 2. REGISTRE E CONFIGURE O FILTRO DE CORS AQUI =====
        FilterHolder corsFilter = new FilterHolder(CrossOriginFilter.class);
        corsFilter.setInitParameter(CrossOriginFilter.ALLOWED_ORIGINS_PARAM, "*"); // Para desenvolvimento. Em produção, use um domínio específico!
        corsFilter.setInitParameter(CrossOriginFilter.ALLOWED_METHODS_PARAM, "GET,POST,PUT,DELETE,HEAD,OPTIONS");
        corsFilter.setInitParameter(CrossOriginFilter.ALLOWED_HEADERS_PARAM, "X-Requested-With,Content-Type,Accept,Origin,Authorization");
        corsFilter.setInitParameter(CrossOriginFilter.ALLOW_CREDENTIALS_PARAM, "true");

        context.addFilter(corsFilter, "/*", EnumSet.of(DispatcherType.REQUEST));

        // Configura o servlet do Jersey
        ServletHolder jerseyServlet = new ServletHolder(new ServletContainer(new RestConfig()));
        context.addServlet(jerseyServlet, "/api/*");

        server.setHandler(context);

        try {
            System.out.println(">>> Iniciando servidor na porta " + port);
            server.start();
            System.out.println(">>> Servidor iniciado com sucesso!");
            server.join();
        } finally {
            server.destroy();
        }
    }
}