package service;

import java.util.List;


import model.Categoria;
import repository.Conexion;

public class CategoriaService {

	
	 	public Categoria crearCategoria(Categoria categoria) throws Exception{
	 			Conexion con = new Conexion();
	 			return con.crearCategoria(categoria);
	 	}

	    // Leer una categoría por su ID
	 	public Categoria obtenerCategoriaPorID(int categoriaID) throws Exception{
			Conexion con = new Conexion();
			Categoria categoria = con.obtenerCategoriaPorID(categoriaID);
			System.out.println(categoria.getNombreCategoria());
 			return con.obtenerCategoriaPorID(categoriaID);
	 	}

	    // Leer todas las categorías
	 	public List<Categoria> obtenerTodasLasCategorias() throws Exception{
	 		Conexion con = new Conexion();
 			return con.obtenerTodasLasCategorias();
	 	}


	    // Actualizar una categoría existente
	 	public Categoria actualizarCategoria(Categoria categoria) throws Exception{
	 		Conexion con = new Conexion();
 			return con.actualizarCategoria(categoria);
	 	}


	    // Eliminar una categoría por su ID
	 	public  Boolean eliminarCategoria(int categoriaID) throws Exception{
	 		Conexion con = new Conexion();
 			return con.eliminarCategoria(categoriaID);
	 	}
	 	
	 	

		public static void main(String[] args) throws Exception {

			CategoriaService  categoriaService = new CategoriaService();
			//Categoria categoria =categoriaService.obtenerCategoriaPorID(1);
			//System.out.println("Res: "+categoria.getNombreCategoria());
			categoriaService.obtenerTodasLasCategorias();

		}

}
