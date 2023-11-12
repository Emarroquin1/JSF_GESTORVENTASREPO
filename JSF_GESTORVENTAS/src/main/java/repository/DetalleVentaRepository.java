package repository;

import java.util.List;


import model.DetalleVenta;

public interface DetalleVentaRepository {

    // Leer todas las categorías por id de venta 
    List<DetalleVenta> obtenerDetalleByVentaId(int ventaId) throws Exception;
    
    Boolean crearDetalleVenta(DetalleVenta detalleVenta) throws Exception;
	
}
