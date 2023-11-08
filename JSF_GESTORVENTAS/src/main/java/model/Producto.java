package model;

public class Producto {
    private int productosID;
    private String nombre;
    private String codigo;
    private double precioCompra;
    private double precioVenta;
    private int stock;
    private int stockMin;
    private int proveedoresID;
    private String proveedor;
    private String categoria;
	private int categoriasID;
    private boolean activo;

  
    public Producto() {
    	
    }
    
    public String getProveedor() {
 		return proveedor;
 	}

 	public void setProveedor(String proveedor) {
 		this.proveedor = proveedor;
 	}

 	public String getCategoria() {
 		return categoria;
 	}

 	public void setCategoria(String categoria) {
 		this.categoria = categoria;
 	}
 
	public int getProductosID() {
        return productosID;
    }

    public void setProductosID(int productosID) {
        this.productosID = productosID;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public double getPrecioCompra() {
        return precioCompra;
    }

    public void setPrecioCompra(double precioCompra) {
        this.precioCompra = precioCompra;
    }

    public double getPrecioVenta() {
        return precioVenta;
    }

    public void setPrecioVenta(double precioVenta) {
        this.precioVenta = precioVenta;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getStockMin() {
        return stockMin;
    }

    public void setStockMin(int stockMin) {
        this.stockMin = stockMin;
    }

    public int getProveedoresID() {
        return proveedoresID;
    }

    public void setProveedoresID(int proveedoresID) {
        this.proveedoresID = proveedoresID;
    }

    public int getCategoriasID() {
        return categoriasID;
    }

    public void setCategoriasID(int categoriasID) {
        this.categoriasID = categoriasID;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
