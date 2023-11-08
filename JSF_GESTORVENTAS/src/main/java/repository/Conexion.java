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
import model.Producto;
import model.Proveedor;

public class Conexion implements CategoriaRepository, ProveedorRepository, ProductoRepository {

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
	    String query = "INSERT INTO Proveedores (nombre_proveedor, contacto, direccion, activo) VALUES (?, ?, ?, ?)";
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

	    String query = "SELECT * FROM Proveedores WHERE ProveedoresID = ?";
	    PreparedStatement pstmt = null;
	    ResultSet res = null;
	    Proveedor proveedor = null;

	    try {
	        pstmt = con.prepareStatement(query);
	        pstmt.setInt(1, proveedorID);

	        res = pstmt.executeQuery();

	        if (res.next()) {
	            proveedor = new Proveedor();
	            proveedor.setProveedorID(res.getInt("ProveedoresID"));
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

	    String query = "SELECT * FROM Proveedores WHERE activo = 1";
	    try {
	        Statement stmt = con.createStatement();
	        ResultSet res = stmt.executeQuery(query);

	        while (res.next()) {
	            Proveedor proveedor = new Proveedor();
	            proveedor.setProveedorID(res.getInt("ProveedoresID"));
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
	    String query = "UPDATE Proveedores SET nombre_proveedor = ?, contacto = ?, direccion = ?, activo = ? WHERE ProveedoresID = ?";
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
	    String query = "UPDATE Proveedores SET activo = false WHERE ProveedoresID = ?";
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

	@Override
	public Producto crearProducto(Producto producto) throws Exception {
	    Connection con = this.conectar();
	    String query = "INSERT INTO Productos (nombre, codigo, precio_compra, precio_venta, stock, stock_min, ProveedoresID, categoriasID, activo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    PreparedStatement pstmt = null;
	    ResultSet generatedKeys = null;
	    try {
	        pstmt = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
	        pstmt.setString(1, producto.getNombre());
	        pstmt.setString(2, producto.getCodigo());
	        pstmt.setDouble(3, producto.getPrecioCompra());
	        pstmt.setDouble(4, producto.getPrecioVenta());
	        pstmt.setInt(5, producto.getStock());
	        pstmt.setInt(6, producto.getStockMin());
	        pstmt.setInt(7, producto.getProveedoresID());
	        pstmt.setInt(8, producto.getCategoriasID());
	        pstmt.setBoolean(9, producto.isActivo());

	        int affectedRows = pstmt.executeUpdate();

	        if (affectedRows == 0) {
	            throw new SQLException("La inserción falló, no se crearon registros.");
	        }

	        // Obtener el ID generado por la base de datos
	        generatedKeys = pstmt.getGeneratedKeys();

	        if (generatedKeys.next()) {
	            int id = generatedKeys.getInt(1);
	            producto.setProductosID(id); // Establecer el ID en el objeto Producto
	        } else {
	            throw new SQLException("No se generó un ID para el producto.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("Error al guardar el producto: " + e.getMessage());
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
	    return producto;
	}

	@Override
	public Producto obtenerProductoPorID(int productoID) throws Exception {
	    Connection con = this.conectar();

	    String query = "SELECT * FROM Productos WHERE productosID = ?";
	    PreparedStatement pstmt = null;
	    ResultSet res = null;
	    Producto producto = null;

	    try {
	        pstmt = con.prepareStatement(query);
	        pstmt.setInt(1, productoID);

	        res = pstmt.executeQuery();

	        if (res.next()) {
	            producto = new Producto();
	            producto.setProductosID(res.getInt("productosID"));
	            producto.setNombre(res.getString("nombre"));
	            producto.setCodigo(res.getString("codigo"));
	            producto.setPrecioCompra(res.getDouble("precio_compra"));
	            producto.setPrecioVenta(res.getDouble("precio_venta"));
	            producto.setStock(res.getInt("stock"));
	            producto.setStockMin(res.getInt("stock_min"));
	            producto.setProveedoresID(res.getInt("ProveedoresID"));
	            producto.setCategoriasID(res.getInt("categoriasID"));
	            producto.setActivo(res.getBoolean("activo"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("Error al obtener el producto por ID: " + e.getMessage());
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

	    return producto;
	}

	@Override
	public List<Producto> obtenerTodosLosProductos() throws Exception {
	    Connection con = this.conectar();
	    List<Producto> lista = new ArrayList<Producto>();

	    String query = "SELECT P.*, Pr.nombre_proveedor, C.nombre_categoria FROM Productos P " +
	               "INNER JOIN Proveedores Pr ON P.proveedoresID = Pr.ProveedoresID " +
	               "INNER JOIN Categorias C ON P.categoriasID = C.categoriasID " +
	               "WHERE P.activo = 1 AND  C.activo = 1 AND Pr.activo = 1";

	    try {
	        Statement stmt = con.createStatement();
	        ResultSet res = stmt.executeQuery(query);

	        while (res.next()) {
	            Producto producto = new Producto();
	            producto.setProductosID(res.getInt("productosID"));
	            producto.setNombre(res.getString("nombre"));
	            producto.setProveedor(res.getString("nombre_proveedor"));
	            producto.setCategoria(res.getString("nombre_categoria"));
	            producto.setCodigo(res.getString("codigo"));
	            producto.setPrecioCompra(res.getDouble("precio_compra"));
	            producto.setPrecioVenta(res.getDouble("precio_venta"));
	            producto.setStock(res.getInt("stock"));
	            producto.setStockMin(res.getInt("stock_min"));
	            producto.setProveedoresID(res.getInt("ProveedoresID"));
	            producto.setCategoriasID(res.getInt("categoriasID"));
	            producto.setActivo(res.getBoolean("activo"));
	            lista.add(producto);
	 
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("Error al obtener la lista de productos: " + e.getMessage());
	    }

	    con.close();
	    return lista;
	}

	@Override
	public Producto actualizarProducto(Producto producto) throws Exception {
	    Connection con = this.conectar();
	    String query = "UPDATE Productos SET nombre = ?, codigo = ?, precio_compra = ?, precio_venta = ?, stock = ?, stock_min = ?, ProveedoresID = ?, categoriasID = ?, activo = ? WHERE productosID = ?";
	    PreparedStatement pstmt = null;

	    try {
	        pstmt = con.prepareStatement(query);
	        pstmt.setString(1, producto.getNombre());
	        pstmt.setString(2, producto.getCodigo());
	        pstmt.setDouble(3, producto.getPrecioCompra());
	        pstmt.setDouble(4, producto.getPrecioVenta());
	        pstmt.setInt(5, producto.getStock());
	        pstmt.setInt(6, producto.getStockMin());
	        pstmt.setInt(7, producto.getProveedoresID());
	        pstmt.setInt(8, producto.getCategoriasID());
	        pstmt.setBoolean(9, producto.isActivo());
	        pstmt.setInt(10, producto.getProductosID());

	        int filasActualizadas = pstmt.executeUpdate();

	        if (filasActualizadas == 1) {
	            return producto; // Devuelve el producto actualizado
	        } else {
	            throw new Exception(
	                "No se pudo actualizar el producto. No se encontró un producto con el ID proporcionado."
	            );
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("Error al actualizar el producto: " + e.getMessage());
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
	public boolean eliminarProducto(int productoID) throws Exception {
	    Connection con = this.conectar();
	    String query = "UPDATE Productos SET activo = false WHERE productosID = ?";
	    PreparedStatement pstmt = null;

	    try {
	        pstmt = con.prepareStatement(query);
	        pstmt.setInt(1, productoID);

	        int filasActualizadas = pstmt.executeUpdate();

	        if (filasActualizadas != 1) {
	            throw new Exception(
	                "No se pudo eliminar el producto. No se encontró un producto con el ID proporcionado."
	            );
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new Exception("Error al eliminar el producto: " + e.getMessage());
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
