package service;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.Categoria;
import repository.CategoriaRepository;
import repository.Conexion;

public class CategoriaService {

	CategoriaRepository categoriaRepository = new Conexion();
	
	JSONObject jsonResponse = new JSONObject();

	 @SuppressWarnings("unchecked")
	public JSONObject crearCategoria(Categoria categoria) throws Exception {
		
		Categoria categoriaSave = categoriaRepository.crearCategoria(categoria);
		// Establece el tipo de respuesta como "éxito" y proporciona un mensaje
		jsonResponse.put("tipo", "éxito");
		jsonResponse.put("mensaje", "Categoría guardada exitosamente");
		jsonResponse.put("categoriaId", categoriaSave.getCategoriasID());
		return jsonResponse;
	}

	//Leer una categoría por su ID
	 @SuppressWarnings("unchecked")
	public Categoria obtenerCategoriaPorID(int categoriaID) throws Exception {
	
		Categoria categoria = categoriaRepository.obtenerCategoriaPorID(categoriaID);
		System.out.println(categoria.getNombreCategoria());
		return categoriaRepository.obtenerCategoriaPorID(categoriaID);
	}

	// Leer todas las categorías
	 @SuppressWarnings("unchecked")
	public JSONObject obtenerTodasLasCategorias() throws Exception {
		
		List<Categoria> listaCategorias = categoriaRepository.obtenerTodasLasCategorias();
		// Agregar la lista de categorías al objeto JSON
		jsonResponse.put("tipo", "éxito");
		jsonResponse.put("mensaje", "Categorías obtenidas exitosamente");
		// categoriaRepositoryvertir el objeto JSON a una cadena
		JSONArray jsonArrayCategorias = new JSONArray();
		for (Categoria categoria : listaCategorias) {
			JSONObject categoriaJSON = new JSONObject();
			categoriaJSON.put("categoriaId", categoria.getCategoriasID());
			categoriaJSON.put("nombreCategoria", categoria.getNombreCategoria());
		
			categoriaJSON.put("descripcion", categoria.getDescripcion());
			categoriaJSON.put("activo", categoria.getActivo());
			jsonArrayCategorias.add(categoriaJSON);
		}

		// Agrega el JSONArray al objeto JSON de respuesta
		jsonResponse.put("categorias", jsonArrayCategorias);

		return jsonResponse;
	}

	// Actualizar una categoría existente
	 @SuppressWarnings("unchecked")
	public JSONObject actualizarCategoria(Categoria categoria) throws Exception {
		
		categoriaRepository.actualizarCategoria(categoria);
		jsonResponse.put("tipo", "éxito");
		jsonResponse.put("mensaje", "Categoría actualizada exitosamente");
		jsonResponse.put("categoriaId", categoria.getCategoriasID());
		return jsonResponse;
	}

	// Eliminar una categoría por su ID
	 @SuppressWarnings("unchecked")
	public JSONObject eliminarCategoria(int categoriaID) throws Exception {
	
		categoriaRepository.eliminarCategoria(categoriaID);
		jsonResponse.put("tipo", "éxito");
		jsonResponse.put("mensaje", "Categoría eliminada exitosamente");
		jsonResponse.put("categoriaId",categoriaID);
		return jsonResponse;
	}

	public static void main(String[] args) throws Exception {

		CategoriaService categoriaService = new CategoriaService();
		// Categoria categoria =categoriaService.obtenerCategoriaPorID(1);
		// System.out.println("Res: "+categoria.getNombreCategoria());
		categoriaService.obtenerTodasLasCategorias();

	}

}
