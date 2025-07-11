package br.com.sdvs.base.model;

import java.time.LocalDateTime;

public class StTables {
    
    private Long id;
    private String tables_name;
    private Long created_by;
    private Long updated_by;
    private LocalDateTime created_at;
    private LocalDateTime updated_at;
    
    public StTables() {}

    public Long getId() {return id;}
    public void setId(Long id) {this.id = id;}

    public String getTables_name() {return tables_name;}
    public void setTables_name(String tables_name) {this.tables_name = tables_name;}

    public Long getCreated_by() {return created_by;}
    public void setCreated_by(Long created_by) {this.created_by = created_by;}

    public Long getUpdated_by() {return updated_by;}
    public void setUpdated_by(Long updated_by) {this.updated_by = updated_by;}

    public LocalDateTime getCreated_at() {return created_at;}
    public void setCreated_at(LocalDateTime created_at) {this.created_at = created_at;}
    
    public LocalDateTime getUpdated_at() {return updated_at;}
    public void setUpdated_at(LocalDateTime updated_at) {this.updated_at = updated_at;}
}
