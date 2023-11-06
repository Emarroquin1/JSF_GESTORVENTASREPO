package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Categoria;
import model.Proveedor;

public class Conexion implements CategoriaRepository, ProveedorRepository {

	public final String dbUrl = "jdbc:mysql://localhost:3306/dbventas?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
	public final String driver = "com.mysql.jdbc.Driver";

	public Connection conectar() throws Exception {
		Connection con = null;
		// TODO Auto-generated method stub
		try {
			Class.forName(driver);
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Error al cargar el driver: " + e.getMessage());
		}
		try {

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
		conexion.conectar();
	}

	@Override
	public List<Categoria> obtenerTodasLasCategorias() throws Exception {
		Connection con = this.conectar();
		List<Categoria> lista = new ArrayList<Categoria>();

		String query = "SELECT * FROM Categorias WHERE activo = 1";
		try {
			Statement stmt = con.createStatement();
			ResultSet res = stmt.executeQuery(query);

			while (res.next()) {
				Categoria categoria = new Categoria();
				categoria.setCategoriasID(res.getInt("categoriasID"));
				categoria.setNombreCategoria(res.getString("nombre_categoria"));
				categoria.setDescripcion(res.getString("descripcion"));
				categoria.setActivo(res.getBoolean("activo"));
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
	public Categoria crearCategoria(Categoria categoria) throws Exception {
	    Connection con = this.conectar();
	    String query = "INSERT INTO Categorias (nombre_categoria, descripcion, activo) VALUES (?, ?, ?)";
	    PreparedStatement pstmt = null;
	    ResultSet generatedKeys = null;
	    try {
	        pstmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	        pstmt.setString(1, categoria.getNombreCategoria());
	        pstmt.setString(2, categoria.getDescripcion());
	        pstmt.setBoolean(3, categoria.getActivo());

	        int affectedRows = pstmt.executeUpdate();

	        if (affectedRows == 0) {
	            throw new SQLException("La inserción falló, no se crearon registros.");
	        }

	        // Obtener el ID generado por la base de datos
	        generatedKeys = pstmt.getGeneratedKeys();

	        if (generatedKeys.next()) {
	            int id = generatedKeys.getInt(1);
	            categoria.setCategoriasID(id); // Establecer el ID en el objeto Categoria
	        } else {
	            throw new SQLException("No se generó un ID para la categoría.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("Error al guardar la categoría: " + e.getMessage());
	    } finally {
	        if (generatedKeys != null) {
	            try {
	                generatedKeys.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (pstmt != null) {
	            try {
	                pstmt.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        con.close();
	    }
	    return categoria;
	}

	@Override
	public Categoria obtenerCategoriaPorID(int categoriaID) throws Exception {
		Connection con = this.conectar();

		String query = "SELECT * FROM Categorias WHERE categoriasID = ?";
		PreparedStatement pstmt = null;
		ResultSet res = null;
		Categoria categoria = null;

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, categoriaID);

			res = pstmt.executeQuery();

			if (res.next()) {
				categoria = new Categoria();
				categoria.setCategoriasID(res.getInt("categoriasID"));
				categoria.setNombreCategoria(res.getString("nombre_categoria"));
				categoria.setDescripcion(res.getString("descripcion"));
				categoria.setActivo(res.getBoolean("activo"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Error al obtener la categoría por ID: " + e.getMessage());
		} finally {
			if (res != null) {
				try {
					res.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			con.close();
		}

		return categoria;
	}

	@Override
	public Categoria actualizarCategoria(Categoria categoria) throws Exception {
		Connection con = this.conectar();
		String query = "UPDATE Categorias SET nombre_categoria = ?, descripcion = ?, activo = ? WHERE categoriasID = ?";
		PreparedStatement pstmt = null;

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, categoria.getNombreCategoria());
			pstmt.setString(2, categoria.getDescripcion());
			pstmt.setBoolean(3, categoria.getActivo());
			pstmt.setInt(4, categoria.getCategoriasID());

			int filasActualizadas = pstmt.executeUpdate();

			if (filasActualizadas == 1) {
				return categoria; // Devuelve la categoría actualizada
			} else {
				throw new Exception(
						"No se pudo actualizar la categoría. No se encontró una categoría con el ID proporcionado.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Error al actualizar la categoría: " + e.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			con.close();
		}
	}

	@Override
	public Boolean eliminarCategoria(int categoriaID) throws Exception {
		Connection con = this.conectar();
		String query = "UPDATE Categorias SET activo = false WHERE categoriasID = ?";
		PreparedStatement pstmt = null;

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, categoriaID);

			int filasActualizadas = pstmt.executeUpdate();

			if (filasActualizadas != 1) {
				throw new Exception(
						"No se pudo eliminar la categoría. No se encontró una categoría con el ID proporcionado.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("Error al eliminar la categoría: " + e.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			con.close();
		}
		return true;
	}

	@Override
	public Proveedor crearProveedor(Proveedor proveedor) throws Exception {
	    Connection con = this.conectar();
	    String query = "INSERT INTO Proveedor (nombre_proveedor, contacto, direccion, activo) VALUES (?, ?, ?, ?)";
	    PreparedStatement pstmt = null;
	    ResultSet generatedKeys = null;
	    try {
	        pstmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	        pstmt.setString(1, proveedor.getNombreProveedor());
	        pstmt.setString(2, proveedor.getContacto());
	        pstmt.setString(3, proveedor.getDireccion());
	        pstmt.setBoolean(4, proveedor.isActivo());

	        int affectedRows = pstmt.executeUpdate();

	        if (affectedRows == 0) {
	            throw new SQLException("La inserción falló, no se crearon registros.");
	        }

	        // Obtener el ID generado por la base de datos
	        generatedKeys = pstmt.getGeneratedKeys();

	        if (generatedKeys.next()) {
	            int id = generatedKeys.getInt(1);
	            proveedor.setProveedorID(id); // Establecer el ID en el objeto Proveedor
	        } else {
	            throw new SQLException("No se generó un ID para el proveedor.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("Error al guardar el proveedor: " + e.getMessage());
	    } finally {
	        if (generatedKeys != null) {
	            try {
	                generatedKeys.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (pstmt != null) {
	            try {
	                pstmt.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        con.close();
	    }
	    return proveedor;
	}

	@Override
	public Proveedor obtenerProveedorPorID(int proveedorID) throws Exception {
	    Connection con = this.conectar();

	    String query = "SELECT * FROM Proveedor WHERE ProveedorID = ?";
	    PreparedStatement pstmt = null;
	    ResultSet res = null;
	    Proveedor proveedor = null;

	    try {
	        pstmt = con.prepareStatement(query);
	        pstmt.setInt(1, proveedorID);

	        res = pstmt.executeQuery();

	        if (res.next()) {
	            proveedor = new Proveedor();
	            proveedor.setProveedorID(res.getInt("ProveedorID"));
	            proveedor.setNombreProveedor(res.getString("nombre_proveedor"));
	            proveedor.setContacto(res.getString("contacto"));
	            proveedor.setDireccion(res.getString("direccion"));
	            proveedor.setActivo(res.getBoolean("activo"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("Error al obtener el proveedor por ID: " + e.getMessage());
	    } finally {
	        if (res != null) {
	            try {
	                res.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        if (pstmt != null) {
	            try {
	                pstmt.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        con.close();
	    }

	    return proveedor;
	}

	@Override
	public List<Proveedor> obtenerTodosLosProveedor() throws Exception {
	    Connection con = this.conectar();
	    List<Proveedor> lista = new ArrayList<Proveedor>();

	    String query = "SELECT * FROM Proveedor WHERE activo = 1";
	    try {
	        Statement stmt = con.createStatement();
	        ResultSet res = stmt.executeQuery(query);

	        while (res.next()) {
	            Proveedor proveedor = new Proveedor();
	            proveedor.setProveedorID(res.getInt("ProveedorID"));
	            proveedor.setNombreProveedor(res.getString("nombre_proveedor"));
	            proveedor.setContacto(res.getString("contacto"));
	            proveedor.setDireccion(res.getString("direccion"));
	            proveedor.setActivo(res.getBoolean("activo"));
	            lista.add(proveedor);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("Error al obtener la lista de Proveedor: " + e.getMessage());
	    }

	    con.close();
	    return lista;
	}

	@Override
	public Proveedor actualizarProveedor(Proveedor proveedor) throws Exception {
	    Connection con = this.conectar();
	    String query = "UPDATE Proveedor SET nombre_proveedor = ?, contacto = ?, direccion = ?, activo = ? WHERE ProveedorID = ?";
	    PreparedStatement pstmt = null;

	    try {
	        pstmt = con.prepareStatement(query);
	        pstmt.setString(1, proveedor.getNombreProveedor());
	        pstmt.setString(2, proveedor.getContacto());
	        pstmt.setString(3, proveedor.getDireccion());
	        pstmt.setBoolean(4, proveedor.isActivo());
	        pstmt.setInt(5, proveedor.getProveedorID());

	        int filasActualizadas = pstmt.executeUpdate();

	        if (filasActualizadas == 1) {
	            return proveedor; // Devuelve el proveedor actualizado
	        } else {
	            throw new Exception(
	                "No se pudo actualizar el proveedor. No se encontró un proveedor con el ID proporcionado."
	            );
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("Error al actualizar el proveedor: " + e.getMessage());
	    } finally {
	        if (pstmt != null) {
	            try {
	                pstmt.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        con.close();
	    }
	}

	@Override
	public boolean eliminarProveedor(int proveedorID) throws Exception {
	    Connection con = this.conectar();
	    String query = "UPDATE Proveedor SET activo = false WHERE ProveedorID = ?";
	    PreparedStatement pstmt = null;

	    try {
	        pstmt = con.prepareStatement(query);
	        pstmt.setInt(1, proveedorID);

	        int filasActualizadas = pstmt.executeUpdate();

	        if (filasActualizadas != 1) {
	            throw new Exception(
	                "No se pudo eliminar el proveedor. No se encontró un proveedor con el ID proporcionado."
	            );
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("Error al eliminar el proveedor: " + e.getMessage());
	    } finally {
	        if (pstmt != null) {
	            try {
	                pstmt.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        con.close();
	    }
	    return true;
	}


}
