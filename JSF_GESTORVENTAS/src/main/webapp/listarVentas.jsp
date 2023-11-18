<%@page import="model.Venta"%>
<%@page import="java.util.List"%>
<%@page import="service.VentaService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Ventas</title>
</head>
<jsp:include page="menu.jsp" />
<body>
    <div class="container mt-5">
        <div class="text-center">
            <h1>Administración de Ventas</h1>
        </div>
        <div class="row">
        <div class="col-3">
            <button class="btn btn-success" id="btnRegistrarVenta">
      		Registrar Venta
        </button>
        </div>
    
        </div>
        <div class="container mt-5">
            <h2>Listado de Ventas</h2>
            <table class="table table-bordered" id="miTablaVentas">
                <thead>
                    <tr>
                   
                        <th>Fecha</th>
                        <th>Total</th>
                        <th>Vendedor</th>                   
                   
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
		
    <jsp:include page="scripts.jsp" />

    <script>
        function cargarTablaVentas() {
            // Limpiar tabla
            var existingTable = $('#miTablaVentas').DataTable();
            if (existingTable) {
                existingTable.destroy();
            }

            var table = $('#miTablaVentas').DataTable({
                paging: true,
                ordering: true,
                searching: true,
                dom: 'Bfrtip',
                buttons: [
                    {
                        extend: 'pdfHtml5',
                        download: 'open',
                        exportOptions: {
                            columns: [0, 1,2]
                        }
                    }
                ]
            });
            table.clear().draw();

            $.ajax({
                type: "POST",
                url: "procesarData.jsp",
                data: {
                    key: "getVentas"
                },
                success: function (data) {
                	console.log(data)
                    if (Array.isArray(data['ventas'])) {
                        for (var i = 0; i < data['ventas'].length; i++) {
       
                            table.row.add([
                                data['ventas'][i].fecha,
                                data['ventas'][i].total,
                                data['ventas'][i].usuarioCorreo,
                            ]).draw(true);
                        }
                    }
                },
                error: function (error) {
                    console.log("Error en la solicitud AJAX: " + error);
                }
            });
        }

        document.addEventListener("DOMContentLoaded", function () {
            cargarTablaVentas();
        });

        function detallesVenta(ventaID) {
            // Aquí puedes redirigir o realizar otras acciones según el ID de la venta
            console.log("Detalles de venta con ID: " + ventaID);
        }
    </script>
    
    <script>
    document.getElementById('btnRegistrarVenta').addEventListener('click', function() {
     
        window.location.href = 'ventas.jsp';
    });
</script>
</body>
</html>
