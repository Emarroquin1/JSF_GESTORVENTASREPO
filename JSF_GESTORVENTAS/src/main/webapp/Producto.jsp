<%@page import="model.Producto"%>
<%@page import="java.util.List"%>
<%@page import="service.ProductoService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CRUD Productos</title>
</head>
<jsp:include page="menu.jsp" />
<body>
	<div class="container mt-5">
		<div class="text-center">
			<h1>Administración de Productos</h1>
		</div>
		<div class="container mt-5">
			<!-- Botón para abrir el modal de agregar producto -->
			<button type="button" class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#exampleModal">Agregar Producto</button>
			<!-- Modal para agregar o modificar productos -->
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">Nuevo
								Producto</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="mb-3">
								<label for="nombreProducto" class="form-label">Nombre
									del Producto</label> <input type="text" class="form-control"
									id="nombreProducto"
									placeholder="Ingrese el nombre del producto">
							</div>
							<div class="mb-3">
								<label for="codigo" class="form-label">Código</label> <input
									type="text" class="form-control" id="codigo"
									placeholder="Ingrese el código del producto">
							</div>
							<div class="mb-3">
								<label for="precioCompra" class="form-label">Precio de
									Compra</label> <input type="text" class="form-control"
									id="precioCompra" placeholder="Ingrese el precio de compra">
							</div>
							<div class="mb-3">
								<label for="precioVenta" class="form-label">Precio de
									Venta</label> <input type="text" class="form-control" id="precioVenta"
									placeholder="Ingrese el precio de venta">
							</div>
							<div class="mb-3">
								<label for="stock" class="form-label">Stock</label> <input
									type="text" class="form-control" id="stock"
									placeholder="Ingrese el stock">
							</div>
							<div class="mb-3">
								<label for="stockMin" class="form-label">Stock Mínimo</label> <input
									type="text" class="form-control" id="stockMin"
									placeholder="Ingrese el stock mínimo">
							</div>
							<div class="mb-3">
								<label for="proveedoresID" class="form-label">ID de
									Proveedor</label> <select class="form-select" id="proveedoresID">
									<option value="" selected>Selecciona un proveedor</option>
								</select>
							</div>
							<div class="mb-3">
								<label for="categoriasID" class="form-label">ID de
									Categoría</label> <select class="form-select" id="categoriasID">
									<option value="" selected>Selecciona una categoría</option>
								</select>
							</div>

						</div>
						<input Type="hidden" id="productoId" value="0">
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Cerrar</button>
							<button type="button" class="btn btn-primary"
								onclick="guardarProducto()">Guardar</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Tabla de productos -->
		<h2>Listado de Productos</h2>
		<table class="table table-bordered" id="miTabla">
			<thead>
				<tr>
					<th>Nombre del Producto</th>
					<th>Código</th>
					<th>Precio de Compra</th>
					<th>Precio de Venta</th>
					<th>Stock</th>
					<th>Stock Mínimo</th>
					<th>Proveedor</th>
					<th>Categoría</th>
					<th colspan="2" style="text-align: center;">Opciones</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>

	<!-- Incluye los scripts necesarios, como jQuery, Bootstrap y SweetAlert -->
	<jsp:include page="scripts.jsp" />

	<!-- Agrega tu script JavaScript para gestionar la lógica de productos -->
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			cargarTablaProductos();
			cargarSelectProveedores(0);
			cargarSelectCategorias(0);
		});

		function limpiarCampos() {
			// Obtiene los elementos de entrada por su ID y establece su valor en cadena vacía
			$("#nombreProducto").val("");
			$("#codigo").val("");
			$("#precioCompra").val("");
			$("#precioVenta").val("");
			$("#stock").val("");
			$("#stockMin").val("");
			$("#proveedoresID").val("");
			$("#categoriasID").val("");
			$("#productoId").val("0");
		}

		function eliminarProducto(productoId) {
			$.ajax({
				type : "POST",
				url : "procesarData.jsp",
				data : {
					key : "eliminarProducto",
					productoId : productoId
				},
				success : function(data) {
					if (data.tipo === "éxito") {
						Swal.fire({
							icon : 'success',
							title : 'Producto eliminado exitosamente',
							showConfirmButton : true,
							timer : 1500
						});

						cargarTablaProductos();
						// Realiza cualquier otra acción necesaria después de eliminar el producto
					} else {
						Swal.fire({
							icon : 'error',
							title : 'Error',
							text : 'Error al eliminar el producto: '
									+ data.mensaje
						});
					}
				},
				error : function(error) {
					console.log("Error en la solicitud AJAX: " + error);
				}
			});
		}

		function guardarProducto() {
			// Obtener los valores de los campos del modal
			var nombreProducto = $("#nombreProducto").val();
			var codigo = $("#codigo").val();
			var precioCompra = $("#precioCompra").val();
			var precioVenta = $("#precioVenta").val();
			var stock = $("#stock").val();
			var stockMin = $("#stockMin").val();
			var proveedoresID = $("#proveedoresID").val();
			var categoriasID = $("#categoriasID").val();
			var productoId = $("#productoId").val();

			limpiarCampos();

			var data = {};
			if (productoId > 0) {
				// Si productoId es mayor que 0, se trata de una actualización
				data = {
					productoId : productoId,
					nombreProducto : nombreProducto,
					codigo : codigo,
					precioCompra : precioCompra,
					precioVenta : precioVenta,
					stock : stock,
					stockMin : stockMin,
					proveedoresID : proveedoresID,
					categoriasID : categoriasID,
					key : "modificarProducto" // Asegúrate de que esta sea la clave correcta en tu backend
				};
			} else {
				// Si productoId es igual a 0, se trata de una creación
				data = {
					nombreProducto : nombreProducto,
					codigo : codigo,
					precioCompra : precioCompra,
					precioVenta : precioVenta,
					stock : stock,
					stockMin : stockMin,
					proveedoresID : proveedoresID,
					categoriasID : categoriasID,
					key : "guardarProducto" // Asegúrate de que esta sea la clave correcta en tu backend
				};
			}

			// Realizar una solicitud AJAX para enviar los datos al backend
			$.ajax({
				type : "POST", // Método de la solicitud
				url : "procesarData.jsp", // URL del archivo que manejará los datos (ajusta esto)
				data : data, // Los datos que deseas enviar
				success : function(response) {
					if (productoId > 0) {
						Swal.fire({
							icon : 'success',
							title : 'Producto Actualizado exitosamente',
							showConfirmButton : true,
							timer : 1500
						});
					} else {
						Swal.fire({
							icon : 'success',
							title : 'Producto Almacenado exitosamente',
							showConfirmButton : true,
							timer : 1500
						});
					}

					// Carga la tabla actualizada
					cargarTablaProductos();
				},
				error : function(xhr, status, error) {
					// Maneja errores en caso de que la solicitud AJAX falle
					console.log("Error en la solicitud:", status, error);
				}
			});
		}
		function cargarSelectProveedores(id) {
			var select = document.getElementById("proveedoresID");
			console.log(id)
			$.ajax({
				type : "POST",
				url : "procesarData.jsp",
				data : {
					key : "getProveedores"
				},
				success : function(data) {
					if (Array.isArray(data['proveedores'])) {
						data['proveedores'].forEach(function(proveedor) {
							var option = document.createElement("option");
							option.value = proveedor.proveedorId;
							option.text = proveedor.nombreProveedor;
							select.appendChild(option);
							// Comprueba si el valor de id coincide con el categoriaID de la opción actual
							if (id > 0 && proveedor.proveedorId === id) {
								option.selected = true;
							}
						});
					}
				},
				error : function(error) {
					console.log("Error en la solicitud AJAX: " + error);
				}
			});
		}

		function cargarSelectCategorias(id) {
			var select = document.getElementById("categoriasID");
			console.log(id)
			$.ajax({
				type : "POST",
				url : "procesarData.jsp",
				data : {
					key : "getCategorias"
				},
				success : function(data) {
					if (Array.isArray(data['categorias'])) {
						data['categorias'].forEach(function(categoria) {
							var option = document.createElement("option");
							option.value = categoria.categoriaId;
							option.text = categoria.nombreCategoria;
							select.appendChild(option);
						
							// Comprueba si el valor de id coincide con el categoriaID de la opción actual
							if (id > 0 && categoria.categoriaId === id) {
									console.log('entro')
								option.selected = true;
							}
						});
					}
				},
				error : function(error) {
					console.log("Error en la solicitud AJAX: " + error);
				}
			});
		}

		function cargarTablaProductos() {
			var table = document.getElementById("miTabla");
			var tbody = table.getElementsByTagName("tbody")[0];

			// Elimina todas las filas existentes
			while (tbody.hasChildNodes()) {
				tbody.removeChild(tbody.firstChild);
			}

			// Realiza una solicitud AJAX para obtener la lista de productos
			$
					.ajax({
						type : "POST",
						url : "procesarData.jsp", // Asegúrate de que esta sea la URL correcta
						data : {
							key : "getProductos" // Ajusta la clave para obtener productos
						// Puedes agregar otras variables de solicitud si es necesario
						},
						success : function(data) {
							console.log(data['productos']);

							if (Array.isArray(data['productos'])) {
								for (var i = 0; i < data['productos'].length; i++) {
									var row = tbody.insertRow(i);
									var cell1 = row.insertCell(0);
									var cell2 = row.insertCell(1);
									var cell3 = row.insertCell(2);
									var cell4 = row.insertCell(3);
									var cell5 = row.insertCell(4);
									var cell6 = row.insertCell(5);
									var cell7 = row.insertCell(6);
									var cell8 = row.insertCell(7);
									var cell9 = row.insertCell(8);						

									// Llena las celdas de la fila con datos de productos
									cell1.innerHTML = data['productos'][i].nombre;
									cell2.innerHTML = data['productos'][i].codigo;
									cell3.innerHTML = data['productos'][i].precioCompra;
									cell4.innerHTML = data['productos'][i].precioVenta;
									cell5.innerHTML = data['productos'][i].stock;
									cell6.innerHTML = data['productos'][i].stockMin;							
									cell7.innerHTML = data['productos'][i].categoria;
									cell8.innerHTML = data['productos'][i].proveedor;
									// Agrega botón de modificar con estilo Bootstrap
									var modificarButton = document
											.createElement("button");
									modificarButton.className = "btn btn-primary";
									modificarButton.innerHTML = "Modificar";

									// Asigna un evento onclick para manejar la acción de modificar
									modificarButton.onclick = function() {
										var rowIndex = this.parentElement.parentElement.rowIndex - 1;
										var productoSeleccionado = data['productos'][rowIndex];

										// Rellena los campos del modal con los datos del producto
										document
												.getElementById("nombreProducto").value = productoSeleccionado.nombre;
										document.getElementById("codigo").value = productoSeleccionado.codigo;
										document.getElementById("precioCompra").value = productoSeleccionado.precioCompra;
										document.getElementById("precioVenta").value = productoSeleccionado.precioVenta;
										document.getElementById("stock").value = productoSeleccionado.stock;
										document.getElementById("stockMin").value = productoSeleccionado.stockMin;
									
										cargarSelectProveedores(productoSeleccionado.proveedoresID);
										cargarSelectCategorias(productoSeleccionado.categoriasID);
									
										document.getElementById("productoId").value = productoSeleccionado.productoId;

										// Abre el modal
										var myModal = new bootstrap.Modal(
												document
														.getElementById('exampleModal'));
										myModal.show();
									};

									// Agrega botón de eliminar con estilo Bootstrap
									var eliminarButton = document
											.createElement("button");
									eliminarButton.className = "btn btn-danger";
									eliminarButton.innerHTML = "Eliminar";
									eliminarButton.dataset.productoId = data['productos'][i].productoId; // Guarda el ID

									// Asigna un evento onclick para manejar la acción de eliminar
									eliminarButton.onclick = function() {
										var productoSeleccionado = this.dataset.productoId;
										eliminarProducto(productoSeleccionado);
									};

									cell9.appendChild(modificarButton);
									cell9.appendChild(eliminarButton);
								}
							}
						},
						error : function(error) {
							console.log("Error en la solicitud AJAX: " + error);
						}
					});
		}

		// Agrega aquí tu lógica JavaScript para manejar las operaciones CRUD de productos.
	</script>
</body>
</html>
