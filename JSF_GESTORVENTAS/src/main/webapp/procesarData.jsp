<%@page import="org.json.simple.JSONObject"%>
<%@page import="model.Categoria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*"%>
<%
// Recibe los datos del POST

String key = request.getParameter("key");
JSONObject jsonResponse = new JSONObject();

if (key != null) {
    switch (key) {
        case "guardarCategoria":
            String nombreCategoria = request.getParameter("nombreCategoria");
            String descripcion = request.getParameter("descripcion");
            // Realiza la operación de guardar la categoría
            // ...

            // Establece el tipo de respuesta como "éxito" y proporciona un mensaje
            jsonResponse.put("tipo", "éxito");
            jsonResponse.put("mensaje", "Categoría guardada exitosamente");
            break;
        // Otras operaciones
    }
} else {
    // Si no se proporciona un "key", establece una respuesta de error
    jsonResponse.put("tipo", "error");
    jsonResponse.put("mensaje", "Operación no válida");
}

// Establece el tipo de contenido de la respuesta
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

// Escribe la respuesta JSON en el flujo de respuesta
response.getWriter().write(jsonResponse.toString());

%>
