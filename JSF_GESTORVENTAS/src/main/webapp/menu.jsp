
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="index.jsp">Inicio</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarNav" aria-controls="navbarNav"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarNav">
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="Categoria.jsp">Categorias</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="Proveedores.jsp">Proveedores</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="Producto.jsp">Producto</a>
			</li>
			<li class="nav-item"><a class="nav-link" href="listarVentas.jsp">Venta</a>
			</li>
			</li>		
			<li class="nav-item"><a class="nav-link" href="#" id="logoutLink">Salir</a></li>
		</ul>
	</div>
</nav>

<jsp:include page="styles.jsp" />


<script>
	document.addEventListener('DOMContentLoaded', function() {
		// Agrega un evento click al enlace de logout
		document.getElementById('logoutLink').addEventListener('click',
				function() {
					// Borra la variable del localStorage
					localStorage.removeItem("usuario");

					// Redirige al usuario a index.jsp
					window.location.href = 'index.jsp';
				});
	});
</script>
