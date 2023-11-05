<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="service.CategoriaService"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="model.Categoria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*"%>
<%
// Recibe los datos del POST

String key = request.getParameter("key");

CategoriaService categoriaService = new CategoriaService();
JSONObject jsonResponse = new JSONObject();
if (key != null) {
	switch (key) {
	case "guardarCategoria":
		
		String nombreCategoria = request.getParameter("nombreCategoria");
		String descripcion = request.getParameter("descripcion");

		Categoria categoria = new Categoria();
		categoria.setActivo(true);
		categoria.setNombreCategoria(nombreCategoria);
		categoria.setDescripcion(descripcion);
		jsonResponse =categoriaService.crearCategoria(categoria);
		break;
	// Otras operaciones
	}

	switch (key) {
	case "getCategorias":

	
		jsonResponse = categoriaService.obtenerTodasLasCategorias();

	
		break;

	// Otras operaciones
	}
} else {
	// Si no se proporciona un "key", establece una respuesta de error
	jsonResponse.put("tipo", "error");
	jsonResponse.put("mensaje", "Operación no válida");
}
String jsonString = jsonResponse.toString();
// Configurar la respuesta HTTP
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

// Enviar la respuesta
response.getWriter().write(jsonString);
%>
