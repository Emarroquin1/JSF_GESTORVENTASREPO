<%@page import="model.Proveedor"%>
<%@page import="java.util.List"%>
<%@page import="service.ProveedorService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MANTENIMIENTO DE PROVEEDORES</title>
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
		<table class="table table-bordered" id="miTablaProveedores">
			<thead>
				<tr>
					<th>Nombre del Proveedor</th>
					<th>Contacto</th>
					<th>Dirección</th>				
					<th>Opciones</th>
					<th></th>
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
    // Destruye la tabla existente si ya existe
    var existingTable = $('#miTablaProveedores').DataTable();
    if (existingTable) {
        existingTable.destroy();
    }

    // Crea la nueva tabla
    var table = $('#miTablaProveedores').DataTable({
        paging: true,
        ordering: true,
        searching: true,
        dom: 'Bfrtip',
        buttons: [
            {
                extend: 'pdfHtml5',
                download: 'open',
                	 exportOptions: {
                		  columns: [0,1,2]
                     }
            }
    ]
    });

    // Limpia la tabla (opcional)
    table.clear().draw();

    // Realiza una solicitud AJAX para obtener la lista de proveedores
    $.ajax({
        type: "POST",
        url: "procesarData.jsp",
        data: {
            key: "getProveedores"
        },
        success: function (data) {
            console.log(data['proveedores']);

            if (Array.isArray(data['proveedores'])) {
                for (var i = 0; i < data['proveedores'].length; i++) {
                    var proveedor = data['proveedores'][i];

                    var buttonModificar = '<button class="btn btn-primary" onclick="modificarProveedor(\'' + proveedor.nombreProveedor + '\', \'' + proveedor.contacto + '\', \'' + proveedor.direccion + '\', ' + proveedor.proveedorId + ')">Modificar</button>';

                    var buttonEliminar = '<button class="btn btn-danger"  onclick="confirmarEliminarProveedor(\'' + proveedor.proveedorId + '\')">Eliminar</button>';

                    // Agrega la fila directamente a DataTables
                    table.row.add([
                        proveedor.nombreProveedor,
                        proveedor.contacto,
                        proveedor.direccion,
                        buttonModificar,
                        buttonEliminar
                    ]).draw(true);
                }
            }
        },
        error: function (error) {
            console.log("Error en la solicitud AJAX: " + error);
        }
    });
}

function confirmarEliminarProveedor(proveedorId) {
    Swal.fire({
        title: '¿Estás seguro?',
        text: 'Esta acción no se puede deshacer',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Sí, eliminar'
    }).then((result) => {
        if (result.isConfirmed) {
            eliminarProveedor(proveedorId);
        }
    });
}


function modificarProveedor(nombreProveedor, contacto, direccion, proveedorId) {
    // Rellena los campos del modal con los datos del proveedor
    document.getElementById("nombreProveedor").value = nombreProveedor;
    document.getElementById("contacto").value = contacto;
    document.getElementById("direccion").value = direccion;
    document.getElementById("proveedorId").value = proveedorId;

    // Abre el modal
    var myModal = new bootstrap.Modal(
        document.getElementById('exampleModal')
    );
    myModal.show();
}

		// Agrega aquí tu lógica JavaScript para manejar las operaciones CRUD de proveedores.
		// Puedes reutilizar y personalizar el código que usaste para las categorías.
	</script>
</body>
</html>
