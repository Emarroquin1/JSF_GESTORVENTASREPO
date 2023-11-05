package repository;
import java.util.List;

import model.Categoria;

public interface CategoriaRepository {
    // Crear una nueva categoría
    Categoria crearCategoria(Categoria categoria);

    // Leer una categoría por su ID
    Categoria obtenerCategoriaPorID(int categoriaID);

    // Leer todas las categorías
    List<Categoria> obtenerTodasLasCategorias() throws Exception;

    // Actualizar una categoría existente
    Categoria actualizarCategoria(Categoria categoria);

    // Eliminar una categoría por su ID
    void eliminarCategoria(int categoriaID);
}
