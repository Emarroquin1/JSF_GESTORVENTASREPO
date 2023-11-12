
<%@page import="model.Categoria"%>
<%@page import="java.util.List"%>
<%@page import="service.CategoriaService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MANTENIMIENTO DE CATEGORIAS</title>
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
						<input Type="hidden" id="categoriaId" value="0">
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
		<table class="table table-bordered" id="miTablaCategoria">
			<thead>
				<tr>
					<th>Nombre de Categoría</th>
					<th>Descripción</th>				
					<th>Opciones</th>
					<th></th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
	</div>

	<jsp:include page="scripts.jsp" />

	<!-- Agrega esto a tu archivo HTML para incluir la biblioteca jQuery -->
	<script>
		function eliminarCategoria(categoriaId) {
			$.ajax({
				type : "POST",
				url : "procesarData.jsp",
				data : {
					key : "eliminarCategoria",
					categoriaId : categoriaId
				},
				success : function(data) {
					if (data.tipo === "éxito") {
						Swal.fire({
							icon : 'success',
							title : 'Categoría eliminada exitosamente',
							showConfirmButton : true,
							timer : 1500
						// Cierra automáticamente después de 1.5 segundos
						});

						cargarTabla();
						// Realiza cualquier otra acción necesaria después de eliminar la categoría
					} else {
						Swal.fire({
							icon : 'error',
							title : 'Error',
							text : 'Error al eliminar la categoría: '
									+ data.mensaje
						});
					}
				},
				error : function(error) {
					console.log("Error en la solicitud AJAX: " + error);
				}
			});
		}

		  function cargarTabla() {
              // Limpiar tabla
              
                var existingTable = $('#miTablaCategoria').DataTable();
				    if (existingTable) {
				        existingTable.destroy();
				  }
				    
	                var table = $('#miTablaCategoria').DataTable({
	                paging: true,
	                ordering: true,
	                searching: true,
	                dom: 'Bfrtip',
	                buttons: [
	                    {
	                        extend: 'pdfHtml5',
	                        download: 'open',
	                        	 exportOptions: {
	                        		  columns: [0,1]
	                             }
	                    }
	            ]
	            });
              table.clear().draw();

              $.ajax({
                  type: "POST",
                  url: "procesarData.jsp",
                  data: {
                      key: "getCategorias"
                  },
                  success: function (data) {
                      if (Array.isArray(data['categorias'])) {
                          for (var i = 0; i < data['categorias'].length; i++) {
                           //Modificar
                              <!-- Modificar -->
							var buttonModificar = '<button class="btn btn-primary" onclick="modificarCategoria(\'' + data['categorias'][i].nombreCategoria + '\', \'' + data['categorias'][i].descripcion + '\', ' + data['categorias'][i].categoriaId + ')">Modificar</button>';
							// Eliminar
                              var buttonEliminar = '<button class="btn btn-danger" onclick="eliminarCategoria(' + data['categorias'][i].categoriaId + ')">Eliminar</button>';
                              // Agregar fila directamente a DataTables
                              table.row.add([
                                  data['categorias'][i].nombreCategoria,
                                  data['categorias'][i].descripcion,
                                  buttonModificar,                           
                                  buttonEliminar,
                              ]).draw(true);
                          }
                      }
                  },
                  error: function (error) {
                      console.log("Error en la solicitud AJAX: " + error);
                  }
              });
          }
			document.addEventListener("DOMContentLoaded", function() {

			cargarTabla();

		});

		function limpiarCampos() {
    // Obtiene los elementos de entrada por su ID y establece su valor en cadena vacía
    document.getElementById("nombreCategoria").value = "";
    document.getElementById("descripcion").value = "";
    document.getElementById("categoriaId").value = "0";
}
		
	    function modificarCategoria(nombreCategoria, descripcion, categoriaId) {
	        // Rellena los campos del modal con los datos de la categoría
	        $("#nombreCategoria").val(nombreCategoria);
	        $("#descripcion").val(descripcion);
	        // Establece el valor del campo "categoriaId"
	        $("#categoriaId").val(categoriaId);
	        
	        // Abre el modal
	        var myModal = new bootstrap.Modal(document.getElementById('exampleModal'));
	        myModal.show();
	    }


		function guardarCategoria() {
			// Obtener los valores de los campos del modal
			var nombreCategoria = $("#nombreCategoria").val();
			var descripcion = $("#descripcion").val();
			var categoriaId = $("#categoriaId").val();

				limpiarCampos();
				if(categoriaId > 0) {
				
				var data = {
				categoriaId : categoriaId,
				nombreCategoria : nombreCategoria,
				descripcion : descripcion,
				key: "modificarCategoria"
				};
				}else{
					
				var data = {
				nombreCategoria : nombreCategoria,
				descripcion : descripcion,
				key : 'guardarCategoria'
				};
				}		
		
			// Realizar una solicitud AJAX para enviar los datos a "procesarData.jsp"
			$.ajax({
				type : "POST", // Método de la solicitud
				url : "procesarData.jsp", // URL del archivo que manejará los datos
				data : data, // Los datos que deseas enviar
				success : function(response) {
					if(categoriaId>0){
						Swal.fire({
						icon : 'success',
						title : 'Categoría Actualizada exitosamente',
						showConfirmButton : true,
						timer : 1500
				
					});	
					}else{
							Swal.fire({
						icon : 'success',
						title : 'Categoría Almacenada exitosamente',
						showConfirmButton : true,
						timer : 1500
				
					});
					}
				
					//cargamos la tabla
					cargarTabla();
					
				},
				error : function(xhr, status, error) {
					// Manejar errores en caso de que la solicitud AJAX falle
					console.log("Error en la solicitud:", status, error);
				}
			});
		}

	</script>



</body>
</html>
