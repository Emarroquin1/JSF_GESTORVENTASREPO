package model;

import java.math.BigDecimal;
import java.util.Date;

public class Venta {
	private int ventasID;
	private String fecha;
	private Double total;
	private int usuarioID;

	public String getUsuarioCorreo() {
		return usuarioCorreo;
	}

	public void setUsuarioCorreo(String usuarioCorreo) {
		this.usuarioCorreo = usuarioCorreo;
	}

	private String usuarioCorreo;
	private boolean activo;

	// Constructor
	public Venta() {
	}

	// Getters y Setters
	public int getVentasID() {
		return ventasID;
	}

	public void setVentasID(int ventasID) {
		this.ventasID = ventasID;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}

	public int getUsuarioID() {
		return usuarioID;
	}

	public void setUsuarioID(int usuarioID) {
		this.usuarioID = usuarioID;
	}

	public boolean isActivo() {
		return activo;
	}

	public void setActivo(boolean activo) {
		this.activo = activo;
	}
}
