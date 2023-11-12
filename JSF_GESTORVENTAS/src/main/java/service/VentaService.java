package service;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;


import model.DetalleVenta;
import repository.Conexion;
import repository.VentaRepository;

public class VentaService {
	
	VentaRepository ventaRepository = new Conexion();
	
	
	public org.json.simple.JSONObject registrarVenta(JSONArray detalles, double totalVenta, int usuarioID) throws Exception {
		try {
			org.json.simple.JSONObject jsonResponse = new org.json.simple.JSONObject();
				List<DetalleVenta> listaDetalles = new ArrayList<DetalleVenta>();
			  for (int i = 0; i < detalles.length(); i++) {
		            org.json.JSONObject detalle = detalles.getJSONObject(i);
		            
		            // Accediendo a los campos específicos según las claves proporcionadas en tu JSON
		            double precio = detalle.getDouble("precio");
		            int productoID = detalle.getInt("id");
		            int cantidad = detalle.getInt("cantidad");
		            int stock = detalle.getInt("stock");		          
		            
		            DetalleVenta detalleVenta = new DetalleVenta();
		            detalleVenta.setActivo(true);
		            detalleVenta.setCantidad(cantidad);
		            detalleVenta.setProductosID(productoID);
		            detalleVenta.setStock(stock);
		            detalleVenta.setPrecioVenta(precio);
		          	listaDetalles.add(detalleVenta);
		        }
			  	int ventaId =ventaRepository.registrarVenta(listaDetalles, totalVenta, usuarioID);
		      	jsonResponse.put("tipo", "éxito");
	            jsonResponse.put("mensaje", "Venta registrada exitosamente");    
	            jsonResponse.put("ventaId", ventaId);
			//retornamos el id de la venta
			return jsonResponse;  
		} catch (Exception e) {
			// TODO: handle exception
				throw new Exception("Error al guardar el registro de la venta: "+e.getMessage());
		}
		
	}

}
