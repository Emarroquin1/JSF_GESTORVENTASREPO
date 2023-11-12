package repository;


import java.util.List;


import model.DetalleVenta;
import model.Venta;

public interface VentaRepository {

	  public int crearVenta(Venta Venta) throws Exception;
	  
	  public int registrarVenta(List<DetalleVenta> lista, double totalVenta, int usuarioID) throws Exception; 
	  
	  public Venta  findById(int id) throws Exception; 
		  
}
