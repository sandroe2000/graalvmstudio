package br.com.sdvs.base.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Representa um nó em uma estrutura de árvore (TreeView).
 * Pode ser um 'folder' (representando uma tabela) ou um 'file' (representando uma query).
 */
public class DBTreeNode {

    private final Long id;          // ID do banco de dados (st_tables.id ou st_tables_queries.id)
    private final String name;        // Nome para exibição (nome da tabela ou da query)
    private final String type;        // Tipo do nó: "folder" ou "file"
    private final String dataType;    // Tipo de dado: "table" ou "sql" para ícones/lógica do frontend
    private final List<DBTreeNode> children;

    public DBTreeNode(Long id, String name, String type, String dataType) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.dataType = dataType;
        this.children = new ArrayList<>();
    }

    // --- Métodos Públicos ---

    public void addChild(DBTreeNode child) {
        this.children.add(child);
    }

    // --- Getters ---

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getType() {
        return type;
    }
    
    public String getDataType() {
        return dataType;
    }

    public List<DBTreeNode> getChildren() {
        return children;
    }

    // --- Sobrescrita de Métodos Padrão ---

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        DBTreeNode dBTtreeNode = (DBTreeNode) o;
        return Objects.equals(id, dBTtreeNode.id) && Objects.equals(name, dBTtreeNode.name) && Objects.equals(type, dBTtreeNode.type);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, type);
    }

    @Override
    public String toString() {
        return "DBTreeNode{" +
               "id=" + id +
               ", name='" + name + '\'' +
               ", type='" + type + '\'' +
               ", children=" + children.size() +
               '}';
    }
}

