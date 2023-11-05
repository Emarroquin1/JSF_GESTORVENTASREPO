
<%@page import="model.Categoria"%>
<%@page import="java.util.List"%>
<%@page import="service.CategoriaService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CRUD CATEGORIAS</title>
</head>
<jsp:include page="menu.jsp" />


<body>


	<div class="container mt-5">
		<div class="text-center">
			<h1>Administración de categorias</h1>
		</div>
		<div class="container mt-5">
			
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#exampleModal">Agregar Categoria</button>

	

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
		<table class="table table-bordered" id="miTabla">
			<thead>
				<tr>
					<th>Nombre de Categoría</th>
					<th>Descripción</th>
					<th>Activo</th>
					<th colspan="2" style="text-align: center;">Opciones</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>

<jsp:include page="scripts.jsp" />

	<!-- Agrega esto a tu archivo HTML para incluir la biblioteca jQuery -->
	<script>
		function cargarTabla() {
			$.ajax({
						type : "POST",
						url : "procesarData.jsp",
						data : {
							key : "getCategorias"
						// Otras variables de solicitud si es necesario
						},
						success : function(data) {
							console.log(data['categorias']);
							// Comprueba si la respuesta es un arreglo
							// Comprueba si la respuesta es un arreglo
							if (Array.isArray(data['categorias'])) {
								console.log('entro');
								var table = document.getElementById("miTabla");
								var tbody = table.getElementsByTagName("tbody")[0];

								for (var i = 0; i < data['categorias'].length; i++) {
									var row = tbody.insertRow(i);
									var cell1 = row.insertCell(0);
									var cell2 = row.insertCell(1);
									var cell3 = row.insertCell(2);
									var cell4 = row.insertCell(3);
									cell1.innerHTML = data['categorias'][i].nombreCategoria;
									cell2.innerHTML = data['categorias'][i].descripcion;

									// Agregar botón de modificar con estilo Bootstrap
									var modificarButton = document
											.createElement("button");
									modificarButton.className = "btn btn-primary";
									modificarButton.innerHTML = "Modificar";
									// Asigna un evento onclick para manejar la acción de modificar
									modificarButton.onclick = function() {
										// Agrega tu lógica para modificar aquí
										var rowIndex = this.parentElement.parentElement.rowIndex - 1;
										var categoriaSeleccionada = data['categorias'][i].categoriaId;
										// Realiza la operación de modificación con la categoría seleccionada
									};

									// Agregar botón de eliminar con estilo Bootstrap
									var eliminarButton = document
											.createElement("button");
									eliminarButton.className = "btn btn-danger";
									eliminarButton.innerHTML = "Eliminar";
									// Asigna un evento onclick para manejar la acción de eliminar
									eliminarButton.onclick = function() {
										// Agrega tu lógica para eliminar aquí
										var rowIndex = this.parentElement.parentElement.rowIndex - 1;
										var categoriaSeleccionada = data['categorias'][i].categoriaId;
										// Realiza la operación de eliminación con la categoría seleccionada
									};

									cell3.appendChild(modificarButton);
									cell4.appendChild(eliminarButton);
								}
							}

						},
						error : function(error) {
							console.log("Error en la solicitud AJAX: " + error);
						}
					});
		}
		document.addEventListener("DOMContentLoaded", function() {
			cargarTabla();

		});
		function guardarCategoria() {
			// Obtener los valores de los campos del modal
			var nombreCategoria = $("#nombreCategoria").val();
			var descripcion = $("#descripcion").val();

			// Crear un objeto con los datos
			var data = {
				nombreCategoria : nombreCategoria,
				descripcion : descripcion,
				key : 'guardarCategoria'

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



</body>
</html>
