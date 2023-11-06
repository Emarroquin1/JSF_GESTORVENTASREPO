<%@page import="model.Proveedor"%>
<%@page import="java.util.List"%>
<%@page import="service.ProveedorService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CRUD Proveedores</title>
</head>
<jsp:include page="menu.jsp" />
<body>
	<div class="container mt-5">
		<div class="text-center">
			<h1>Administración de Proveedores</h1>
		</div>
		<div class="container mt-5">
			<!-- Botón para abrir el modal de agregar proveedor -->
			<button type="button" class="btn btn-primary" data-bs-toggle="modal"
				data-bs-target="#exampleModal">Agregar Proveedor</button>
			<!-- Modal para agregar o modificar proveedores -->
			<div class="modal fade" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">Nuevo
								Proveedor</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="mb-3">
								<label for="nombreProveedor" class="form-label">Nombre
									del Proveedor</label> <input type="text" class="form-control"
									id="nombreProveedor"
									placeholder="Ingrese el nombre del proveedor">
							</div>
							<div class="mb-3">
								<label for="contacto" class="form-label">Contacto</label> <input
									type="text" class="form-control" id="contacto"
									placeholder="Ingrese el contacto del proveedor">
							</div>
							<div class="mb-3">
								<label for="direccion" class="form-label">Dirección</label>
								<textarea class="form-control" id="direccion" rows="3"
									placeholder="Ingrese la dirección del proveedor"></textarea>
							</div>
						</div>
						<input Type="hidden" id="proveedorId" value="0">
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Cerrar</button>
							<button type="button" class="btn btn-primary"
								onclick="guardarProveedor()">Guardar</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Tabla de proveedores -->
		<h2>Listado de Proveedores</h2>
		<table class="table table-bordered" id="miTabla">
			<thead>
				<tr>
					<th>Nombre del Proveedor</th>
					<th>Contacto</th>
					<th>Dirección</th>				
					<th colspan="2" style="text-align: center;">Opciones</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>

	<!-- Incluye los scripts necesarios, como jQuery, Bootstrap y SweetAlert -->
	<jsp:include page="scripts.jsp" />

	<!-- Agrega tu script JavaScript para gestionar la lógica -->
	<script>
	document.addEventListener("DOMContentLoaded", function() {
		cargarTablaProveedores();

	});

function limpiarCampos() {
    // Obtiene los elementos de entrada por su ID y establece su valor en cadena vacía
    $("#nombreProveedor").val("");
    $("#contacto").val("");
    $("#direccion").val("");
    $("#proveedorId").val("0");
}

function eliminarProveedor(proveedorId) {
    $.ajax({
        type: "POST",
        url: "procesarData.jsp",
        data: {
            key: "eliminarProveedor",
            proveedorId: proveedorId
        },
        success: function(data) {
            if (data.tipo === "éxito") {
                Swal.fire({
                    icon: 'success',
                    title: 'Proveedor eliminado exitosamente',
                    showConfirmButton: true,
                    timer: 1500
                });

                cargarTablaProveedores();
                // Realiza cualquier otra acción necesaria después de eliminar el proveedor
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Error al eliminar el proveedor: ' + data.mensaje
                });
            }
        },
        error: function(error) {
            console.log("Error en la solicitud AJAX: " + error);
        }
    });
}


function guardarProveedor() {
    // Obtener los valores de los campos del modal
    var nombreProveedor = $("#nombreProveedor").val();
    var contacto = $("#contacto").val();
    var direccion = $("#direccion").val();
    var proveedorId = $("#proveedorId").val();

    limpiarCampos();

    var data = {};
    if (proveedorId > 0) {
        // Si proveedorId es mayor que 0, se trata de una actualización
        data = {
            proveedorId: proveedorId,
            nombreProveedor: nombreProveedor,
            contacto: contacto,
            direccion: direccion,
            key: "modificarProveedor" // Asegúrate de que esta sea la clave correcta en tu backend
        };
    } else {
        // Si proveedorId es igual a 0, se trata de una creación
        data = {
            nombreProveedor: nombreProveedor,
            contacto: contacto,
            direccion: direccion,
            key: "guardarProveedor" // Asegúrate de que esta sea la clave correcta en tu backend
        };
    }

    // Realizar una solicitud AJAX para enviar los datos al backend
    $.ajax({
        type: "POST", // Método de la solicitud
        url: "procesarData.jsp", // URL del archivo que manejará los datos (ajusta esto)
        data: data, // Los datos que deseas enviar
        success: function (response) {
            if (proveedorId > 0) {
                Swal.fire({
                    icon: 'success',
                    title: 'Proveedor Actualizado exitosamente',
                    showConfirmButton: true,
                    timer: 1500
                });
            } else {
                Swal.fire({
                    icon: 'success',
                    title: 'Proveedor Almacenado exitosamente',
                    showConfirmButton: true,
                    timer: 1500
                });
            }

            // Carga la tabla actualizada
            cargarTablaProveedores();
        },
        error: function (xhr, status, error) {
            // Maneja errores en caso de que la solicitud AJAX falle
            console.log("Error en la solicitud:", status, error);
        }
    });
}


		function cargarTablaProveedores() {
			var table = document.getElementById("miTabla");
			var tbody = table.getElementsByTagName("tbody")[0];

			// Elimina todas las filas existentes
			while (tbody.hasChildNodes()) {
				tbody.removeChild(tbody.firstChild);
			}

			// Realiza una solicitud AJAX para obtener la lista de proveedores
			$.ajax({
						type : "POST",
						url : "procesarData.jsp", // Asegúrate de que esta sea la URL correcta
						data : {
							key : "getProveedores" // Ajusta la clave para obtener proveedores
						// Puedes agregar otras variables de solicitud si es necesario
						},
						success : function(data) {
							console.log(data['proveedores']);

							if (Array.isArray(data['proveedores'])) {
								for (var i = 0; i < data['proveedores'].length; i++) {
									var row = tbody.insertRow(i);
									var cell1 = row.insertCell(0);
									var cell2 = row.insertCell(1);
									var cell3 = row.insertCell(2);
									var cell4 = row.insertCell(3);

									// Llena las celdas de la fila con datos de proveedores
									cell1.innerHTML = data['proveedores'][i].nombreProveedor;
									cell2.innerHTML = data['proveedores'][i].contacto;
									cell3.innerHTML = data['proveedores'][i].direccion;

									// Agrega botón de modificar con estilo Bootstrap
									var modificarButton = document
											.createElement("button");
									modificarButton.className = "btn btn-primary";
									modificarButton.innerHTML = "Modificar";

									// Asigna un evento onclick para manejar la acción de modificar
									modificarButton.onclick = function() {
										var rowIndex = this.parentElement.parentElement.rowIndex - 1;
										var proveedorSeleccionado = data['proveedores'][rowIndex];

										// Rellena los campos del modal con los datos del proveedor
										document
												.getElementById("nombreProveedor").value = proveedorSeleccionado.nombreProveedor;
										document.getElementById("contacto").value = proveedorSeleccionado.contacto;
										document.getElementById("direccion").value = proveedorSeleccionado.direccion;
										document.getElementById("proveedorId").value = proveedorSeleccionado.proveedorId;

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
									eliminarButton.dataset.proveedorId = data['proveedores'][i].proveedorId; // Guarda el ID

									// Asigna un evento onclick para manejar la acción de eliminar
									eliminarButton.onclick = function() {
										var proveedorSeleccionado = this.dataset.proveedorId;
										eliminarProveedor(proveedorSeleccionado);
									};

									cell4.appendChild(modificarButton);
									cell4.appendChild(eliminarButton);
								}
							}
						},
						error : function(error) {
							console.log("Error en la solicitud AJAX: " + error);
						}
					});
		}

		// Agrega aquí tu lógica JavaScript para manejar las operaciones CRUD de proveedores.
		// Puedes reutilizar y personalizar el código que usaste para las categorías.
	</script>
</body>
</html>
