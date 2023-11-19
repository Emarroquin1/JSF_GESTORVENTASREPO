
<%@page import="model.Categoria"%>
<%@page import="java.util.List"%>
<%@page import="service.CategoriaService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Inicio</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
</head>
<jsp:include page="menu.jsp" />
<body>


	<div class="container mt-5">
		<h1>Bienvenido</h1>
		<h4>Administración de Ventas</h4>
		<p>Descripcion del sistema.</p>
		      <!-- Contenido de la descripción -->
        <p>
            El sistema "Ventura" es una solución integral diseñada para optimizar y simplificar las operaciones de ventas de empresas minoristas. Con un enfoque centrado en la usabilidad, Ventura ofrece herramientas avanzadas para administrar catálogos de productos, categorías, proveedores y el registro de ventas. Además, proporciona funcionalidades robustas para generar informes detallados sobre cada catálogo y reportes analíticos de ventas.
        </p>

        <!-- Módulos Principales -->
        <h5>Módulos Principales:</h5>
        <ol>
            <li><strong>Catálogo de Categorías:</strong> Permite la creación, edición y eliminación de categorías para organizar productos de manera eficiente.</li>
            <li><strong>Catálogo de Proveedores:</strong> Gestión de proveedores con detalles clave como nombre, información de contacto y productos suministrados.</li>
            <li><strong>Catálogo de Productos:</strong> Manejo completo de productos, incluida la creación, actualización y eliminación...</li>
            <li><strong>Registro de Ventas:</strong> Proceso intuitivo para registrar ventas, incluidos la informacion de quien realizo la venta y el registro productos vendidos.</li>
            <li><strong>Reportes Analíticos:</strong> Informes detallados sobre el rendimiento de ventas, productos más vendidos y tendencias...</li>
            <li><strong>Interfaz de Usuario Intuitiva:</strong> Diseño fácil de usar que permite a los usuarios navegar de manera eficiente por todas las funcionalidades.</li>
            <li><strong>Impresión de Tickets:</strong> Capacidad para imprimir tickets de venta con detalles claros y profesionales.</li>
            <li><strong>Generación de Reportes por Catálogo:</strong> Informes específicos para cada catálogo que detallan inventarios, proveedores y categorías.</li>
            <li><strong>Reporte de Ventas:</strong> Informes exhaustivos que detallan el rendimiento de las ventas.</li>
        </ol>
        
          <!-- Imagen elegante -->
    <div class="text-center">
        <img src="ticketLogo.png" alt="Imagen Elegante" class="img-fluid">
    </div>
	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
</body>
</html>
