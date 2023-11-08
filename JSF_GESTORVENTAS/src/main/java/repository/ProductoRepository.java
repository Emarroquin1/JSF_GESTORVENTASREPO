package repository;

import java.util.List;
import model.Producto;

public interface ProductoRepository {
    // Crear un nuevo producto
    Producto crearProducto(Producto producto) throws Exception;

    // Leer un producto por su ID
    Producto obtenerProductoPorID(int productoID) throws Exception;

    // Leer todos los productos
    List<Producto> obtenerTodosLosProductos() throws Exception;

    // Actualizar un producto existente
    Producto actualizarProducto(Producto producto) throws Exception;

    // Eliminar un producto por su ID
    boolean eliminarProducto(int productoID) throws Exception;
}
