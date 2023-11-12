<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Venta</title>
<jsp:include page="menu.jsp" />
</head>
<body>

<div class="container-fluid">
		<div class="mb-3">
        </div>

	<h3>SISTEMA DE VENTAS</h3>

	<div class="row">
		<div class="col-4">
			<label for="productosID" class="form-label">Productos</label> 
            <select
				class="form-select" id="productosID">
				<option value="" selected>Selecciona un producto</option>
			</select> <span style="color: red;" id="stockDisplay"></span>
		</div>
		<div class="col-4">
			<label for="miIcantidadProductonput">Digite la cantidad
				vendida</label> <input id="cantidadProducto" type="text" value=""
				placeholder="cantidad" class="form-control"> <span
				style="color: red;" id="cantidadError"></span>
		</div>

		<div class="col-2">
			<br>
			<button id="btnAgregarProducto" class="btn btn-success">Agregar
				Producto</button>
		</div>
	</div>
	<hr>
	<div class="row">
		<table id="tablaProductos" class="table" style="width: 100%;">
			<thead>
				<tr class="table-dark">
					<th>Código</th>
					<th>Nombre</th>
					<th>Precio</th>
					<th>Cantidad Venta</th>
					<th>Sub Total</th>
				</tr>
			</thead>
			<tbody>
				<!-- Aquí se cargarán los productos -->
			</tbody>
		</table>
		<h4 style="color: red;" id="totalVenta"></h4>
	</div>
	<div class="row">
		<div class="col-4">
			<button id="btnRegistrarVenta" class="btn btn-primary"
				onclick="registrarVenta()">Registrar Venta</button>
		</div>
	<div>
	<form id="pdfForm" action="procesarDataPDF.jsp" target="_blank" method="post" style="display: none">
    <button id="btnGeneratePdf" type="submit">Generar PDF</button>
    <input type="hidden" value="pdfTicket" name="key">
    <input type="text" id="txtVentaId" name="txtVentaId">
</form>
	</div>
</div>

</body>
</html>
<jsp:include page="scripts.jsp" />
<script>
  // Agrega un evento de clic al botón
    document.getElementById("btnGeneratePdf").addEventListener("click", function() {
        // Llamada AJAX para generar el PDF
        $.ajax({
            type: "POST",
            url: "procesarDataPDF.jsp",
            data: {
                key: "pdfTicket"
            },
            success: function(response) {
                if (response.success) {
                    // Abre el PDF en una nueva pestaña
                  //  window.open(response.pdfPath, '_blank');
                } else {
                    // Maneja errores o muestra mensajes al usuario según sea necesario
                    alert("Error: " + response.message);
                }
            },
            error: function(error) {
                console.error(error);
                alert("Error al comunicarse con el servidor");
            }
        });
    });
    rolUsuario ="admin";
	document.addEventListener("DOMContentLoaded", function() {
	
			cargarSelectProductos(0);
	
		});

        document.getElementById('cantidadProducto').addEventListener('input', function() {
        var cantidad = parseInt(this.value);
        var select = document.getElementById('productosID');
            
        // Encuentra la opción seleccionada
        var selectedOption = select.options[select.selectedIndex];

        if (selectedOption) {
 
            // Obtén el stock del atributo data-stock
            var stock = selectedOption.getAttribute('data-stock');
            if (cantidad > stock) {
                document.getElementById('cantidadError').textContent = 'La cantidad no puede ser mayor que el stock (' + stock + ')';
                document.getElementById('btnAgregarProducto').disabled = true;
            } else {
                document.getElementById('cantidadError').textContent = '';
                 document.getElementById('btnAgregarProducto').disabled = false;
            }
        }
    });
        function generarTicket(ventaId) {
            // Setea el valor del campo txtVentaId
            document.getElementById('txtVentaId').value = ventaId;

            // Ejecuta el evento submit del formulario
            document.getElementById('pdfForm').submit();
        }

    

       function registrarVenta() {
        Swal.showLoading();
   
        var usuarioID =1;
        $.ajax({
            type: "POST",
            url: "procesarData.jsp", // Ajusta la ruta a tu controlador
            data: {
                key: "registrarVenta",
                arrayProducto: JSON.stringify(productosAgregados),
                totalVenta: totalVenta,
                usuarioID: usuarioID
            },
        }).done(function(resp) {
          
            if (resp) {
             		
        Swal.fire({
            icon: 'success',
            title: 'Venta registrada exitosamente',
            showConfirmButton: true,
            timer: 1500,
            onClose: function () {
                // Esta función se ejecutará cuando se cierre SweetAlert
                generarTicket(resp.ventaId);
                limpiarTabla();
                productosAgregados = [];
                console.log(productosAgregados)
                cargarSelectProductos(); 
                limpiarCampos();
            }
         });

            } else {
                swal("Advertencia", "El registro no se guardo!", "warning");
            }
        }).fail(function(resp) {
            console.log(resp);
        });
    }
   function limpiarTabla() {
        // Selecciona el cuerpo de la tabla
        var tbody = document.querySelector('#tablaProductos tbody');

        // Limpia el contenido del cuerpo de la tabla
        tbody.innerHTML = '';

        // También puedes restablecer el contenido del totalVenta
        document.getElementById('totalVenta').textContent = '';
    }

        document.getElementById('productosID').addEventListener('change', function() {
            // Obtén el select
            var select = document.getElementById('productosID');
            
            // Encuentra la opción seleccionada
            var selectedOption = select.options[select.selectedIndex];
                if (selectedOption && selectedOption.value !="") {
                    // Obtén el stock del atributo data-stock
                 var stock = selectedOption.getAttribute('data-stock');

                    document.getElementById('stockDisplay').textContent = 'Cantidad en stock: ' + stock;
                } else {
                    document.getElementById('stockDisplay').textContent = 'Cantidad en stock: N/A';
                }
               
        });


      document.getElementById('btnAgregarProducto').addEventListener('click', function() {

        var select = document.getElementById('productosID');
            
            // Encuentra la opción seleccionada
        var selectedOption = select.options[select.selectedIndex];
        var cantidadProducto = document.getElementById('cantidadProducto').value;


        validarYAgregarProducto(selectedOption, cantidadProducto)
    });



   function validarYAgregarProducto(selectedOption, cantidad) {
        // Verificar si los valores son nulos o vacíos
        if (!selectedOption.value || !cantidad || selectedOption.value.trim() == '' || cantidad.trim() == '') {
            // Mostrar una alerta dulce
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Por favor, ingrese un código de producto y una cantidad válida.',
            });
        } else {

 

            if (selectedOption) {        
            agregarProductoATabla(selectedOption, cantidad);
        }
    }
}
       // Array para almacenar los productos agregados a la tabla
    var productosAgregados = [];

    function productoYaAgregado(id) {
        return productosAgregados.some(function(producto) {
            return producto.id === id;
        });
    }
    // Función para agregar una fila HTML a la tabla
    var totalVenta = 0;

function limpiarCampos() {
    // Limpia el valor del campo de selección
    document.getElementById('productosID').value = '';

    // Limpia el valor del campo de cantidad
    document.getElementById('cantidadProducto').value = '';

    // Limpia los mensajes de error si los hubiera
    document.getElementById('stockDisplay').textContent = '';
    document.getElementById('cantidadError').textContent = '';
}

   function agregarProductoATabla(selectedOption, cantidad) {

       
        var codigo = selectedOption.getAttribute('data-codigo');
        var nombre = selectedOption.text; 
        var precio = selectedOption.getAttribute('data-precio');
        var productoId = selectedOption.value;
        var stock = selectedOption.getAttribute('data-stock');


        if (productoYaAgregado(productoId)) {
            // Si el producto ya está en el array, muestra una alerta de SweetAlert
              Swal.fire({
                icon: 'error',
                title:  "Producto duplicado",
                text: "El producto ya ha sido agregado.",
            });
            return false;
        }

        // Crea un objeto con los datos del producto
        var productoAgregado = {
            id: productoId,
            codigo: codigo,
            nombre: nombre,
            precio: precio,
            cantidad: cantidad,
            stock: stock
        };
        //    console.log(productoAgregado)
        //Agrega el producto al array
        productosAgregados.push(productoAgregado);
        console.log(productosAgregados)
        var total = productoAgregado.precio * productoAgregado.cantidad;

        // Obtén la referencia a la tabla
        var tabla = $("#tablaProductos");

        // Crea una nueva fila
        var nuevaFila = $("<tr></tr>");

        // Crea las celdas para cada columna
        var celdaCodigo = $("<td>" + codigo + "</td>");

        var celdaNombre = $("<td>" + nombre + "</td>");

        if (rolUsuario != 'admin') {

            var celdaPrecio = $("<td><input type='number' id='" + productoId + "' class='precio-input'  value='" + precio + "' disabled></td>");

        } else {
            var celdaPrecio = $("<td><input type='number' id='" + productoId + "' class='precio-input'  value='" + precio + "'></td>");

        }

        var celdaCantidad = $("<td><input type='number' id='" + productoId + "' class='cantidad-input' value='" + cantidad + "'></td>");

        var celdaSubTotal = $("<td>" + total + "</td>");
        // Agrega las celdas a la fila
        nuevaFila.append(celdaCodigo);
        nuevaFila.append(celdaNombre);
        nuevaFila.append(celdaPrecio);
        nuevaFila.append(celdaCantidad);
        nuevaFila.append(celdaSubTotal);

        celdaCantidad.find('input').on('change', function() {
            var nuevaCantidad = $(this).val();
            var nuevoPrecio = celdaPrecio.find('input').val();
            var subtotal = nuevaCantidad * nuevoPrecio;

            // Busca el objeto en el array con el mismo ID
            var productoAgregado = productosAgregados.find(function(producto) {
                return producto.id === productoId;
            });

            // Actualiza la cantidad y el subtotal en el objeto
            productoAgregado.cantidad = nuevaCantidad;

            celdaSubTotal.text(subtotal);

            // Actualiza el total de la venta
            actualizarTotalVenta();
        });

        celdaPrecio.find('input').on('change', function() {

            if (rolUsuario != 'admin') {
                swal("Advertencia", "Solamente el administrador puede modificar el precio de venta", "warning");
                return false;
            }
            var nuevoPrecio = $(this).val();
            var nuevaCantidad = celdaCantidad.find('input').val();
            var subtotal = nuevaCantidad * nuevoPrecio;

            // Busca el objeto en el array con el mismo ID
            var productoAgregado = productosAgregados.find(function(producto) {
                return producto.id === productoId;
            });

            // Actualiza el precio y el subtotal en el objeto
            productoAgregado.precio = nuevoPrecio;

            celdaSubTotal.text(subtotal);

                // Actualiza el total de la venta
            actualizarTotalVenta();
        });

        totalVenta = totalVenta + total;

        document.getElementById('totalVenta').textContent = 'Total venta: ' + totalVenta;

        tabla.find('tbody').append(nuevaFila);
    
            limpiarCampos();

    }

      function actualizarTotalVenta() {
        totalVenta = 0;
        for (var i = 0; i < productosAgregados.length; i++) {
            totalVenta += productosAgregados[i].cantidad * productosAgregados[i].precio;
        }
        document.getElementById('totalVenta').textContent = 'Total venta: ' + totalVenta;
    }


    function calcularTotalVenta() {
        var totalVenta = 0;
        productosAgregados.forEach(function(producto) {
            var subtotal = producto.precio * producto.cantidad;
            totalVenta += subtotal;
        });
        return totalVenta;
    }


  

	function cargarSelectProductos(id) {
		var select = document.getElementById("productosID");
          // Limpiar las opciones actuales
         select.innerHTML = '';
		console.log(id)
		$.ajax({
			type : "POST",
			url : "procesarData.jsp",
			data : {
				key : "getProductos"
			},
			success : function(data) {
				if (Array.isArray(data['productos'])) {
                        var option = document.createElement("option");
                    	option.value = "";
						option.text = "Seleccione un producto";
						select.appendChild(option);	
					data['productos'].forEach(function(producto) {
						option = document.createElement("option");
						option.value = producto.productoId;
						option.text = producto.nombre;
                        option.setAttribute('data-stock', producto.stock);
                        option.setAttribute('data-precio', producto.precioVenta);                     
                        option.setAttribute('data-codigo', producto.codigo);   
						select.appendChild(option);					
					});
				}
			},
			error : function(error) {
				console.log("Error en la solicitud AJAX: " + error);
			}
		});
	}
</script>