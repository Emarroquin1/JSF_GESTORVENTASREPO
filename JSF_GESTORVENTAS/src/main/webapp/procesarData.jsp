<%@page import="service.ProductoService"%>
<%@page import="model.Producto"%>
<%@page import="service.ProveedorService"%>
<%@page import="model.Proveedor"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="service.CategoriaService"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="model.Categoria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.sql.*"%>
<%
// Recibe los datos del POST

String key = request.getParameter("key");

CategoriaService categoriaService = new CategoriaService();

ProveedorService proveedorService = new ProveedorService();

ProductoService productoService = new ProductoService();

JSONObject jsonResponse = new JSONObject();
if (key != null) {
	switch (key) {
	case "modificarCategoria":
		Categoria categoria = new Categoria();
		String nombreCategoriaUpdate = request.getParameter("nombreCategoria");
		String descripcionUpdate = request.getParameter("descripcion");
		int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));

		categoria.setCategoriasID(categoriaId);
		categoria.setActivo(true);
		categoria.setNombreCategoria(nombreCategoriaUpdate);
		categoria.setDescripcion(descripcionUpdate);
		jsonResponse = categoriaService.actualizarCategoria(categoria);
		break;

	case "guardarCategoria":
		Categoria categoriaSave = new Categoria();
		String nombreCategoria = request.getParameter("nombreCategoria");
		String descripcion = request.getParameter("descripcion");

		categoriaSave.setActivo(true);
		categoriaSave.setNombreCategoria(nombreCategoria);
		categoriaSave.setDescripcion(descripcion);
		jsonResponse = categoriaService.crearCategoria(categoriaSave);
		break;

	case "getCategorias":
		jsonResponse = categoriaService.obtenerTodasLasCategorias();
		break;
	case "eliminarCategoria":
		int id = Integer.parseInt(request.getParameter("categoriaId"));

		jsonResponse = categoriaService.eliminarCategoria(id);
		break;
	case "modificarProveedor":
		Proveedor proveedor = new Proveedor();
		String nombreProveedorUpdate = request.getParameter("nombreProveedor");
		String contactoUpdate = request.getParameter("contacto");
		String direccionUpdate = request.getParameter("direccion");
		int proveedorId = Integer.parseInt(request.getParameter("proveedorId"));

		proveedor.setProveedorID(proveedorId);
		proveedor.setActivo(true);
		proveedor.setNombreProveedor(nombreProveedorUpdate);
		proveedor.setContacto(contactoUpdate);
		proveedor.setDireccion(direccionUpdate);
		jsonResponse = proveedorService.actualizarProveedor(proveedor);
		break;

	case "guardarProveedor":
		Proveedor proveedorSave = new Proveedor();
		String nombreProveedor = request.getParameter("nombreProveedor");
		String contacto = request.getParameter("contacto");
		String direccion = request.getParameter("direccion");

		proveedorSave.setActivo(true);
		proveedorSave.setNombreProveedor(nombreProveedor);
		proveedorSave.setContacto(contacto);
		proveedorSave.setDireccion(direccion);
		jsonResponse = proveedorService.crearProveedor(proveedorSave);
		break;

	case "getProveedores":
		jsonResponse = proveedorService.obtenerTodosLosProveedores();
		break;

	case "eliminarProveedor":
		int idDelete = Integer.parseInt(request.getParameter("proveedorId"));
		jsonResponse = proveedorService.eliminarProveedor(idDelete);
		break;

	case "modificarProducto":
		Producto producto = new Producto();
		String nombreProductoUpdate = request.getParameter("nombreProducto");
		String codigoUpdate = request.getParameter("codigo");
		double precioCompraUpdate = Double.parseDouble(request.getParameter("precioCompra"));
		double precioVentaUpdate = Double.parseDouble(request.getParameter("precioVenta"));
		int stockUpdate = Integer.parseInt(request.getParameter("stock"));
		int stockMinUpdate = Integer.parseInt(request.getParameter("stockMin"));
		int proveedoresIDUpdate = Integer.parseInt(request.getParameter("proveedoresID"));
		int categoriasIDUpdate = Integer.parseInt(request.getParameter("categoriasID"));
		int productoID = Integer.parseInt(request.getParameter("productoId"));

		producto.setProductosID(productoID);
		producto.setActivo(true);
		producto.setNombre(nombreProductoUpdate);
		producto.setCodigo(codigoUpdate);
		producto.setPrecioCompra(precioCompraUpdate);
		producto.setPrecioVenta(precioVentaUpdate);
		producto.setStock(stockUpdate);
		producto.setStockMin(stockMinUpdate);
		producto.setProveedoresID(proveedoresIDUpdate);
		producto.setCategoriasID(categoriasIDUpdate);
		jsonResponse = productoService.actualizarProducto(producto);
		break;

	case "guardarProducto":
		Producto productoSave = new Producto();
		String nombreProducto = request.getParameter("nombreProducto");
		String codigo = request.getParameter("codigo");
		double precioCompra = Double.parseDouble(request.getParameter("precioCompra"));
		double precioVenta = Double.parseDouble(request.getParameter("precioVenta"));
		int stock = Integer.parseInt(request.getParameter("stock"));
		int stockMin = Integer.parseInt(request.getParameter("stockMin"));
		int proveedoresID = Integer.parseInt(request.getParameter("proveedoresID"));
		int categoriasID = Integer.parseInt(request.getParameter("categoriasID"));

		productoSave.setActivo(true);
		productoSave.setNombre(nombreProducto);
		productoSave.setCodigo(codigo);
		productoSave.setPrecioCompra(precioCompra);
		productoSave.setPrecioVenta(precioVenta);
		productoSave.setStock(stock);
		productoSave.setStockMin(stockMin);
		productoSave.setProveedoresID(proveedoresID);
		productoSave.setCategoriasID(categoriasID);
		jsonResponse = productoService.crearProducto(productoSave);
		break;

	case "getProductos":
		jsonResponse = productoService.obtenerTodosLosProductos();
		break;

	case "eliminarProducto":
		int idDeleteProd = Integer.parseInt(request.getParameter("productoId"));
		jsonResponse = productoService.eliminarProducto(idDeleteProd);
		break;

	}

} else {
	// Si no se proporciona un "key", establece una respuesta de error
	jsonResponse.put("tipo", "error");
	jsonResponse.put("mensaje", "Operación no válida");
}
String jsonString = jsonResponse.toString();
// Configurar la respuesta HTTP
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

// Enviar la respuesta
response.getWriter().write(jsonString);
%>
