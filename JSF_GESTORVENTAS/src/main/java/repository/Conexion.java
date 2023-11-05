package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Categoria;

public class Conexion implements CategoriaRepository {

	private final String dbUrl = "jdbc:mysql://localhost:3306/dbventas";

	private Connection conectar() throws Exception {
		Connection con = null;
		// TODO Auto-generated method stub
		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			String username = "root";
			String password = "";

			con = DriverManager.getConnection(dbUrl, username, password);
			System.out.println("Conexion Exitosa");
			return con;

		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Error al conectar a la bd: " + e.getMessage());
		}

	}
	
	public static void main(String[] arg) throws Exception {
		
		Conexion conexion = new Conexion();
		conexion.obtenerTodasLasCategorias();
		
	}
	
	@Override
	public List<Categoria> obtenerTodasLasCategorias() throws Exception {
		Connection con = this.conectar();
		List<Categoria> lista = new ArrayList<Categoria>();
		
		String query="SELECT * FROM Categorias";
		try {
			Statement stmt = con.createStatement();
			ResultSet res = stmt.executeQuery(query);
			
			while(res.next()) {
				Categoria categoria = new Categoria();
				categoria.setCategoriasID(res.getInt("categoriasID"));
				categoria.setNombreCategoria(res.getString("nombre_categoria"));
				categoria.setDescripcion(res.getString("descripcion"));
				categoria.setActivo(res.getBoolean("activo"));
				System.out.println("Nombre: "+categoria.getNombreCategoria());
				lista.add(categoria);
			}
			
			
			
		} catch (Exception e) {
			
			e.printStackTrace();
			throw new Exception("Error al obtener la lista de categorias: " + e.getMessage());
		}
		
		con.close();
		return lista;	
	}


	@Override
	public Categoria crearCategoria(Categoria categoria) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Categoria obtenerCategoriaPorID(int categoriaID) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public Categoria actualizarCategoria(Categoria categoria) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void eliminarCategoria(int categoriaID) {
		// TODO Auto-generated method stub

	}

}
