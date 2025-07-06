package br.com.sdvs.base.config;

import jakarta.servlet.*;
import java.io.IOException;

public class CharacterEncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        // Força a codificação UTF-8 para todas as requisições e respostas
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Continua o processamento da cadeia de filtros e servlets
        chain.doFilter(request, response);
    }

    // Métodos init e destroy podem ficar vazios para este filtro simples
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}