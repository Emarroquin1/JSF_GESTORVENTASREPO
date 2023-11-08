package service;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import model.Producto;
import repository.Conexion;
import repository.ProductoRepository;

import java.util.List;

public class ProductoService {
    ProductoRepository productoRepository = new Conexion();

    @SuppressWarnings("unchecked")
    public JSONObject crearProducto(Producto producto) throws Exception {
        JSONObject jsonResponse = new JSONObject();
        Producto productoGuardado = productoRepository.crearProducto(producto);
        jsonResponse.put("tipo", "éxito");
        jsonResponse.put("mensaje", "Producto guardado exitosamente");
        jsonResponse.put("productoId", productoGuardado.getProductosID());

        return jsonResponse;
    }

    @SuppressWarnings("unchecked")
    public JSONObject obtenerProductoPorID(int productoID) throws Exception {
        JSONObject jsonResponse = new JSONObject();

        Producto producto = productoRepository.obtenerProductoPorID(productoID);

        if (producto != null) {
            jsonResponse.put("tipo", "éxito");
            jsonResponse.put("mensaje", "Producto obtenido exitosamente");
            JSONObject productoJSON = productoToJSON(producto);
            jsonResponse.put("producto", productoJSON);
        } else {
            jsonResponse.put("tipo", "error");
            jsonResponse.put("mensaje", "Producto no encontrado");
        }

        return jsonResponse;
    }

    @SuppressWarnings("unchecked")
    public JSONObject obtenerTodosLosProductos() throws Exception {
        JSONObject jsonResponse = new JSONObject();

        List<Producto> listaProductos = productoRepository.obtenerTodosLosProductos();

        if (!listaProductos.isEmpty()) {
            jsonResponse.put("tipo", "éxito");
            jsonResponse.put("mensaje", "Productos obtenidos exitosamente");
            JSONArray jsonArrayProductos = new JSONArray();

            for (Producto producto : listaProductos) {
                jsonArrayProductos.add(productoToJSON(producto));
            }

            jsonResponse.put("productos", jsonArrayProductos);
        } else {
            jsonResponse.put("tipo", "error");
            jsonResponse.put("mensaje", "No se encontraron productos");
        }

        return jsonResponse;
    }

    @SuppressWarnings("unchecked")
    public JSONObject actualizarProducto(Producto producto) throws Exception {
        JSONObject jsonResponse = new JSONObject();

        if (productoRepository.actualizarProducto(producto) != null) {
            jsonResponse.put("tipo", "éxito");
            jsonResponse.put("mensaje", "Producto actualizado exitosamente");
            jsonResponse.put("productoId", producto.getProductosID());
        } else {
            jsonResponse.put("tipo", "error");
            jsonResponse.put("mensaje", "Producto no encontrado");
        }

        return jsonResponse;
    }

    @SuppressWarnings("unchecked")
    public JSONObject eliminarProducto(int productoID) throws Exception {
        JSONObject jsonResponse = new JSONObject();

        if (productoRepository.eliminarProducto(productoID)) {
            jsonResponse.put("tipo", "éxito");
            jsonResponse.put("mensaje", "Producto eliminado exitosamente");
            jsonResponse.put("productoId", productoID);
        } else {
            jsonResponse.put("tipo", "error");
            jsonResponse.put("mensaje", "Producto no encontrado");
        }

        return jsonResponse;
    }

    @SuppressWarnings("unchecked")
    private JSONObject productoToJSON(Producto producto) {
        JSONObject productoJSON = new JSONObject();
        productoJSON.put("productoId", producto.getProductosID());
        productoJSON.put("nombre", producto.getNombre());
        productoJSON.put("codigo", producto.getCodigo());
        productoJSON.put("precioCompra", producto.getPrecioCompra());
        productoJSON.put("precioVenta", producto.getPrecioVenta());
        productoJSON.put("stock", producto.getStock());
        productoJSON.put("stockMin", producto.getStockMin());
        productoJSON.put("proveedoresID", producto.getProveedoresID());
        productoJSON.put("categoriasID", producto.getCategoriasID());
        productoJSON.put("activo", producto.isActivo());
        productoJSON.put("proveedor", producto.getProveedor());
        productoJSON.put("categoria", producto.getCategoria());
        return productoJSON;
    }
}
