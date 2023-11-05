
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
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#exampleModal">Agregar Categoria</button>

			<!-- Modal -->

			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">Nueva
								Categoría</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<!-- Campos de entrada -->
							<div class="mb-3">
								<label for="nombreCategoria" class="form-label">Nombre
									de Categoría</label> <input type="text" class="form-control"
									id="nombreCategoria"
									placeholder="Ingrese el nombre de la categoría">
							</div>
							<div class="mb-3">
								<label for="descripcion" class="form-label">Descripción</label>
								<textarea class="form-control" id="descripcion" rows="3"
									placeholder="Ingrese la descripción de la categoría"></textarea>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Cerrar</button>
							<button type="button" class="btn btn-primary"
								onclick="guardarCategoria()">Guardar</button>
						</div>
					</div>
				</div>
			</div>
		</div>

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




	<script>
		function guardarCategoria() {
			// Obtener los valores de los campos del modal
			var nombreCategoria = $("#nombreCategoria").val();
			var descripcion = $("#descripcion").val();

			// Crear un objeto con los datos
			var data = {
				nombreCategoria : nombreCategoria,
				descripcion : descripcion,
				key:'guardarCategoria'
				
			};
			console.log(data)
			// Realizar una solicitud AJAX para enviar los datos a "procesarData.jsp"
			$.ajax({
				type : "POST", // Método de la solicitud
				url : "procesarData.jsp", // URL del archivo que manejará los datos
				data : data, // Los datos que deseas enviar
				success : function(response) {
					// Aquí puedes manejar la respuesta del servidor
					console.log("Respuesta:", response);
					// Puedes agregar más acciones aquí, como cerrar el modal, mostrar un mensaje, etc.
				},
				error : function(xhr, status, error) {
					// Manejar errores en caso de que la solicitud AJAX falle
					console.log("Error en la solicitud:", status, error);
				}
			});
		}

		function eliminarCategoria(id) {

		}

		function modificarCategoria(nombre) {

		}
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>

	<!-- Agrega esto a tu archivo HTML para incluir la biblioteca jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>
