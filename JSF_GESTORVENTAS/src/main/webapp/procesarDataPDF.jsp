<%@page import="service.PdfTicket"%>
<%@page import="service.VentaService"%>
<%@page import="org.json.JSONArray"%>
<%@page import="model.DetalleVenta"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.Arrays"%>
<%@page import="service.ProductoService"%>
<%@page import="model.Producto"%>
<%@page import="service.ProveedorService"%>
<%@page import="model.Proveedor"%>
<%@page import="java.util.List"%>
<%@page import="service.CategoriaService"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="model.Categoria"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*"%>
<%
// Recibe los datos del POST

String key = request.getParameter("key");



PdfTicket pdf = new PdfTicket();


if (key != null) {
	switch (key) {
	case "pdfTicket":	
        try {
            // Configura la respuesta para ser un PDF
        
			int id = Integer.parseInt(request.getParameter("txtVentaId"));
            // Llama al método generatePdf desde el contexto adecuado
            pdf.generatePdf(response,id);
      	       
        } catch (Exception e) {
            e.printStackTrace();
        
        }
		break;

	}

} else {
	
}

%>
