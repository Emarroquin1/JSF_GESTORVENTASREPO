package model;

public class Proveedor {
    private int proveedorID;
    private String nombreProveedor;
    private String contacto;
    private String direccion;
    private boolean activo;

    public Proveedor() {
      
    }

    public Proveedor(int proveedorID, String nombreProveedor, String contacto, String direccion, boolean activo) {
        this.proveedorID = proveedorID;
        this.nombreProveedor = nombreProveedor;
        this.contacto = contacto;
        this.direccion = direccion;
        this.activo = activo;
    }

    public int getProveedorID() {
        return proveedorID;
    }

    public void setProveedorID(int proveedorID) {
        this.proveedorID = proveedorID;
    }

    public String getNombreProveedor() {
        return nombreProveedor;
    }

    public void setNombreProveedor(String nombreProveedor) {
        this.nombreProveedor = nombreProveedor;
    }

    public String getContacto() {
        return contacto;
    }

    public void setContacto(String contacto) {
        this.contacto = contacto;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

  
}
