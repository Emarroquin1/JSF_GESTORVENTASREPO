
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
<body>

	<%
	CategoriaService categoriaService = new CategoriaService();
	

	List<Categoria> listaCategorias = categoriaService.obtenerTodasLasCategorias();
	%>
	<div class="container mt-5">
		<div class="text-center">
			<img src="pngwing.com.png" alt="Logo Mapfre" width="150">
			<h1>Bienvenido</h1>
			<h4>Administración de categorias</h4>
			<p></p>
		</div>
		<div class="container mt-5">
			<h3>
				Cantidad de Categorías: <b style="color: red"> <%=listaCategorias.size()%></b>
			</h3>

			<h2>Listado de Categorías</h2>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>Nombre de Categoría</th>
						<th>Descripción</th>
						<th>Activo</th>
						<th colspan="2" style="text-align: center;">Opciones</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Categoria categoria : listaCategorias) {
					%>
					<tr>
						<td><%=categoria.getNombreCategoria()%></td>
						<td><%=categoria.getDescripcion()%></td>
						<td><%=categoria.getActivo()%></td>
						<td>
							<!-- Botón para eliminar con SweetAlert -->
							<button class="btn btn-danger"
								onclick="eliminarCategoria('<%=categoria.getNombreCategoria()%>')">Eliminar</button>
						</td>
						<td>
							<!-- Botón para modificar con SweetAlert -->
							<button class="btn btn-primary"
								onclick="modificarCategoria('<%=categoria.getNombreCategoria()%>')">Modificar</button>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>



	</div>
	<script>
		function eliminarCategoria(id) {

		}

		function modificarCategoria(nombre) {

		}
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
</body>
</html>
