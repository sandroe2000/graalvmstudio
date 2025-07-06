package br.com.sdvs.base.component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.*;

public class PureJDBC {

    static final String JDBC_DRIVER = "org.postgresql.Driver";
    static final String DB_URL = "jdbc:postgresql://localhost:5432/crm";
    static final String USER = "postgres";
    static final String PASS = "postgres!";

    public PureJDBC(){}

    public List<Map<String, Object>> select(String sql, Map<String, String> rsGet){

        Connection conn = null;
        Statement stmt = null;        
        List<Map<String, Object>> list = new ArrayList<>();

        try{
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                Map<String, Object> item = new HashMap<>();
                for (Map.Entry<String, String> entry : rsGet.entrySet()) {
                    String key = entry.getKey();
                    String value = entry.getValue();
                    switch (value) {
                        case "Date":
                            item.put(key, rs.getDate(key));
                            break;
                        case "Long":
                            item.put(key, rs.getLong(key));
                            break;
                        default:
                            item.put(key, rs.getString(key));
                            break;
                    }                                        
                }
                list.add(item);
            }
            rs.close();
            stmt.close();
            conn.close();
        }catch(SQLException sqle){
            sqle.printStackTrace();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try{
                if(stmt!=null) stmt.close();
                if(conn!=null) conn.close();
            }catch(SQLException sqle){
                sqle.printStackTrace();
            }
        }        
        return list;
    }
}
