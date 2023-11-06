package repository;

import java.util.List;

import model.Proveedor;


public interface ProveedorRepository {
    // Crear un nuevo proveedor
    Proveedor crearProveedor(Proveedor proveedor) throws Exception;

    // Leer un proveedor por su ID
    Proveedor obtenerProveedorPorID(int proveedorID) throws Exception;

    // Leer todos los Proveedor
    List<Proveedor> obtenerTodosLosProveedor() throws Exception;

    // Actualizar un proveedor existente
    Proveedor actualizarProveedor(Proveedor proveedor) throws Exception;

    // Eliminar un proveedor por su ID
    boolean eliminarProveedor(int proveedorID) throws Exception;
}
