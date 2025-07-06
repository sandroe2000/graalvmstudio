package br.com.sdvs.base.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

// Usaremos uma classe normal aqui em vez de um record,
// pois precisamos modificar a lista de filhos durante a construção da árvore.
public class TreeNode {
    private String name;       // Nome do arquivo ou pasta (ex: "frontend", "Layout.js")
    private String type;       // "folder" ou "file"
    private String path;       // Caminho completo do nó
    private String extension;  // "js", "html", "css", etc. (opcional, pode ser usado para arquivos)
    private List<TreeNode> children;

    public TreeNode(String name, String type, String path, String extension) {
        this.name = name;
        this.type = type;
        this.path = path;
        this.extension = extension;
        this.children = new ArrayList<>();
    }
    
    // Getters e Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getPath() { return path; }
    public void setPath(String path) { this.path = path; }
    public String getExtension() { return extension; }
    public void setExtension(String extension) { this.extension = extension; }
    public List<TreeNode> getChildren() { return children; }
    public void setChildren(List<TreeNode> children) { this.children = children; }

    public void addChild(TreeNode child) {
        this.children.add(child);
    }
    
    // Opcional, mas útil: um método para encontrar um filho pelo nome
    public TreeNode findChild(String name) {
        for (TreeNode child : children) {
            if (child.getName().equals(name)) {
                return child;
            }
        }
        return null;
    }
    
    // Opcional, mas importante: equals e hashCode para evitar duplicações
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TreeNode treeNode = (TreeNode) o;
        return Objects.equals(path, treeNode.path);
    }

    @Override
    public int hashCode() {
        return Objects.hash(path);
    }
}
