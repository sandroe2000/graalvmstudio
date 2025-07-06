package br.com.sdvs.base.model;

public class StTables {
    
    private Long id;
    private String tables_name;
    private Long created_by;
    private Long updated_by;
    private localDateTime created_at;
    private localDateTime updated_at;
    
    public StTables() {}

    public Long getId() {return id;}
    public void setId(Long id) {this.id = id;}

    public String getTables_name() {return tables_name;}
    public void setTables_name(String tables_name) {this.tables_name = tables_name;}

    public Long getCreated_by() {return created_by;}
    public void setCreated_by(Long created_by) {this.created_by = created_by;}

    public Long getUpdated_by() {return updated_by;}
    public void setUpdated_by(Long updated_by) {this.updated_by = updated_by;}

    public localDateTime getCreated_at() {return created_at;}
    public void setCreated_at(localDateTime created_at) {this.created_at = created_at;}
    
    public localDateTime getUpdated_at() {return updated_at;}
    public void setUpdated_at(localDateTime updated_at) {this.updated_at = updated_at;}
}
