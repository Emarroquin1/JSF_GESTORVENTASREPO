package model;

public class DetalleVenta {
    private int detalleID;
    private int ventasID;
    private int productosID;
    private int cantidad;
    private String codigo;
    private String producto;
    private double precioVenta;
    public double getPrecioVenta() {
		return precioVenta;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getProducto() {
		return producto;
	}

	public void setProducto(String producto) {
		this.producto = producto;
	}

	public void setPrecioVenta(double precioVenta) {
		this.precioVenta = precioVenta;
	}

	private int stock;
    private boolean activo;

    // Constructor
    public DetalleVenta() {
    }

    // Getters y Setters
    public int getDetalleID() {
        return detalleID;
    }

    public void setDetalleID(int detalleID) {
        this.detalleID = detalleID;
    }

    public int getVentasID() {
        return ventasID;
    }

    public void setVentasID(int ventasID) {
        this.ventasID = ventasID;
    }

    public int getProductosID() {
        return productosID;
    }

    public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public void setProductosID(int productosID) {
        this.productosID = productosID;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
}
