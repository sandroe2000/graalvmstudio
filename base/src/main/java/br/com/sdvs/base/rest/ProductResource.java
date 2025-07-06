package br.com.sdvs.base.rest;

import br.com.sdvs.base.infra.HikariPool;
import br.com.sdvs.base.model.Product;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import org.slf4j.Logger; 
import org.slf4j.LoggerFactory; 

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@Path("/products")
public class ProductResource {

    private static final Logger logger = LoggerFactory.getLogger(ProductResource.class);

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllProducts() {
        logger.info("Recebida requisição para buscar todos os produtos.");
        List<Product> products = new ArrayList<>();
        String sql = "SELECT id, name, price FROM products";
        try (Connection conn = HikariPool.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                products.add(new Product(
                    rs.getLong("id"),
                    rs.getString("name"),
                    rs.getDouble("price")
                ));
            }
        } catch (Exception e) {
            // Em uma aplicação real, logar o erro
            logger.error("Erro ao buscar produtos no banco de dados.", e);
            return Response.serverError().entity("Error fetching products").build();
        }
        return Response.ok(products).build();
    }
}