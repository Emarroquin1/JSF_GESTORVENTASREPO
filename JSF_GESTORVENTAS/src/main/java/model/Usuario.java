package model;

public class Usuario {
	private int usuarioID;
	private String dui;
	private String correo;
	private String nombre;
	private String rol;
	private String contrasena;
	private boolean activo;

	// Constructor vacío
	public Usuario() {
	}

	// Constructor con parámetros
	public Usuario(int usuarioID, String dui, String correo, String nombre, String rol, String contrasena,
			boolean activo) {
		this.usuarioID = usuarioID;
		this.dui = dui;
		this.correo = correo;
		this.nombre = nombre;
		this.rol = rol;
		this.contrasena = contrasena;
		this.activo = activo;
	}

	// Getters y Setters

	public int getUsuarioID() {
		return usuarioID;
	}

	public void setUsuarioID(int usuarioID) {
		this.usuarioID = usuarioID;
	}

	public String getDui() {
		return dui;
	}

	public void setDui(String dui) {
		this.dui = dui;
	}

	public String getCorreo() {
		return correo;
	}

	public void setCorreo(String correo) {
		this.correo = correo;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getRol() {
		return rol;
	}

	public void setRol(String rol) {
		this.rol = rol;
	}

	public String getContrasena() {
		return contrasena;
	}

	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}

	public boolean isActivo() {
		return activo;
	}

	public void setActivo(boolean activo) {
		this.activo = activo;
	}
}
