package model;

public class Categoria {
    private int categoriasID;
    private String nombreCategoria;
    private String descripcion;
    private Boolean activo;

    // Constructores
    public Categoria() {
    }

    public Categoria(String nombreCategoria, String descripcion, boolean activo) {
        this.nombreCategoria = nombreCategoria;
        this.descripcion = descripcion;
        this.activo = activo;
    }

    // Getters y Setters
    public int getCategoriasID() {
        return categoriasID;
    }

    public void setCategoriasID(int categoriasID) {
        this.categoriasID = categoriasID;
    }

    public String getNombreCategoria() {
        return nombreCategoria;
    }

    public void setNombreCategoria(String nombreCategoria) {
        this.nombreCategoria = nombreCategoria;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public boolean getActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    // Otros métodos si es necesario
}
