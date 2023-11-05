package repository;
import java.util.List;

import model.Categoria;

public interface CategoriaRepository {
    // Crear una nueva categoría
    Categoria crearCategoria(Categoria categoria) throws Exception;

    // Leer una categoría por su ID
    Categoria obtenerCategoriaPorID(int categoriaID) throws Exception;

    // Leer todas las categorías
    List<Categoria> obtenerTodasLasCategorias() throws Exception;

    // Actualizar una categoría existente
    Categoria actualizarCategoria(Categoria categoria) throws Exception;

    // Eliminar una categoría por su ID
    Boolean eliminarCategoria(int categoriaID) throws Exception;
}
