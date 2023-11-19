<%@page import="model.Producto"%>
<%@page import="java.util.List"%>
<%@page import="service.ProductoService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MANTENIMIENTO DE PRODUCTOS</title>
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
								<label for="proveedoresID" class="form-label">Proveedor</label> <select class="form-select" id="proveedoresID">
									<option value="" selected>Selecciona un proveedor</option>
								</select>
							</div>
							<div class="mb-3">
								<label for="categoriasID" class="form-label">Categoría</label> <select class="form-select" id="categoriasID">
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
		<table class="table table-secondary" id="miTabla">
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
		
		   if (rolUsuario != 'admin') {
		    	
		    	mensajeValidador();
		    	return false;
		    }
			
		
    // Pregunta al usuario si realmente desea eliminar el producto
    Swal.fire({
        title: '¿Estás seguro?',
        text: 'Esta acción eliminará el producto. ¿Quieres continuar?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Sí, eliminarlo'
    }).then((result) => {
        if (result.isConfirmed) {
            // Si el usuario confirma, realiza la eliminación
        	eliminarP(productoId);
        }
    });
}

	function eliminarP(productoId){
		
		  $.ajax({
              type: "POST",
              url: "procesarData.jsp",
              data: {
                  key: "eliminarProducto",
                  productoId: productoId
              },
              success: function (data) {
                  if (data.tipo === "éxito") {
                      Swal.fire({
                          icon: 'success',
                          title: 'Producto eliminado exitosamente',
                          showConfirmButton: false,
                          timer: 1500
                      });

                      cargarTablaProductos();
                      // Realiza cualquier otra acción necesaria después de eliminar el producto
                  } else {
                      Swal.fire({
                          icon: 'error',
                          title: 'Error',
                          text: 'Error al eliminar el producto: ' + data.mensaje
                      });
                  }
              },
              error: function (error) {
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
			 select.innerHTML = '';
			console.log(id)
			$.ajax({
				type : "POST",
				url : "procesarData.jsp",
				data : {
					key : "getProveedores"
				},
				success : function(data) {
					if (Array.isArray(data['proveedores'])) {
							var option = document.createElement("option");
							option.value = "";
							option.text =  "Seleccione un proveedor";
							select.appendChild(option);	
						data['proveedores'].forEach(function(proveedor) {
							 option = document.createElement("option");
							option.value = proveedor.proveedorId;
							option.text = proveedor.nombreProveedor;
							// Comprueba si el valor de id coincide con el categoriaID de la opción actual
							if (id > 0 && proveedor.proveedorId == id) {
								option.selected = true;
							}
							select.appendChild(option);
							
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
			select.innerHTML = '';
			console.log(id)
			$.ajax({
				type : "POST",
				url : "procesarData.jsp",
				data : {
					key : "getCategorias"
				},
				success : function(data) {
					if (Array.isArray(data['categorias'])) {
							 option = document.createElement("option");
							option.value = "";
							option.text =  "Seleccione una categoria";
							select.appendChild(option);	
						data['categorias'].forEach(function(categoria) {
							var option = document.createElement("option");
							option.value = categoria.categoriaId;
							option.text = categoria.nombreCategoria;
							// Comprueba si el valor de id coincide con el categoriaID de la opción actual
							if (id > 0 && categoria.categoriaId == id) {
									console.log('entro')
								option.selected = true;
							}
							select.appendChild(option);								
						});
					}
				},
				error : function(error) {
					console.log("Error en la solicitud AJAX: " + error);
				}
			});
		}

		function modificarProducto(nombre, codigo, precioCompra, precioVenta, stock, stockMin, proveedoresID, categoriasID, productoId) {
    // Rellena los campos del modal con los datos del producto
    document.getElementById("nombreProducto").value = nombre;
    document.getElementById("codigo").value = codigo;
    document.getElementById("precioCompra").value = precioCompra;
    document.getElementById("precioVenta").value = precioVenta;
    document.getElementById("stock").value = stock;
    document.getElementById("stockMin").value = stockMin;

    cargarSelectProveedores(proveedoresID);
    cargarSelectCategorias(categoriasID);

    document.getElementById("productoId").value = productoId;

    // Abre el modal
   var myModal = new bootstrap.Modal(document.getElementById('exampleModal'));
  	myModal.show();
}


		function cargarTablaProductos() {
			var existingTable = $('#miTabla').DataTable();

// Destruye la tabla existente si ya existe
if (existingTable) {
    existingTable.destroy();
}
// Crea la nueva tabla
var table = $('#miTabla').DataTable({
    paging: true,
    ordering: true,
    searching: true,
    dom: 'Bfrtip',
    buttons: [
        {
            extend: 'pdfHtml5',
            download: 'open',
            	 exportOptions: {
            		  columns: [0,1,2,3,4,5,6,7]
                 }
        }
]
});

// Limpia la tabla (opcional)
table.clear().draw();										
			// Realiza una solicitud AJAX para obtener la lista de productos
			$.ajax({
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

					
					
var producto = data['productos'][i];
var nombre = producto.nombre;
var codigo = producto.codigo;
var precioCompra = producto.precioCompra;
var precioVenta = producto.precioVenta;
var stock = producto.stock;
var stockMin = producto.stockMin;
var proveedoresID = producto.proveedoresID;
var categoriasID = producto.categoriasID;
var productoId = producto.productoId;

var buttonModificar = '<button class="btn btn-primary" onclick="modificarProducto(\'' + nombre + '\', \'' + codigo + '\', ' + precioCompra + ', ' + precioVenta + ', ' + stock + ', ' + stockMin + ', \'' + proveedoresID + '\', \'' + categoriasID + '\', ' + productoId + ')">Modificar</button>';
var buttonEliminar = '<button class="btn btn-danger"  onclick="eliminarProducto(\'' + productoId + '\')">Eliminar</button>';
             // Agrega la fila directamente a DataTables
                    table.row.add([
                        data['productos'][i].nombre,
                        data['productos'][i].codigo,
                        data['productos'][i].precioCompra,
                        data['productos'][i].precioVenta,
                        data['productos'][i].stock,
                        data['productos'][i].stockMin,
                        data['productos'][i].categoria,
                        data['productos'][i].proveedor,
                        buttonModificar,
						buttonEliminar
                    ]).draw(true);
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
