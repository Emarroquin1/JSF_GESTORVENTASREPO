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
	case "modificarCategoria":
		Categoria categoria = new Categoria();
		String nombreCategoriaUpdate = request.getParameter("nombreCategoria");
		String descripcionUpdate = request.getParameter("descripcion");
		int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));

		
		categoria.setCategoriasID(categoriaId);
		categoria.setActivo(true);
		categoria.setNombreCategoria(nombreCategoriaUpdate);
		categoria.setDescripcion(descripcionUpdate);
		jsonResponse = categoriaService.actualizarCategoria(categoria);
		break;
		
	case "guardarCategoria":
		Categoria categoriaSave = new Categoria();
		String nombreCategoria = request.getParameter("nombreCategoria");
		String descripcion = request.getParameter("descripcion");


		categoriaSave.setActivo(true);
		categoriaSave.setNombreCategoria(nombreCategoria);
		categoriaSave.setDescripcion(descripcion);
		jsonResponse = categoriaService.crearCategoria(categoriaSave);
		break;

	case "getCategorias":
		jsonResponse = categoriaService.obtenerTodasLasCategorias();
		break;
	case "eliminarCategoria":
		int id = Integer.parseInt(request.getParameter("categoriaId"));

		jsonResponse = categoriaService.eliminarCategoria(id);
		break;
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
