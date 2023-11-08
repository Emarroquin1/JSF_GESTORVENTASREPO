package service;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import model.Proveedor;
import repository.Conexion;
import repository.ProveedorRepository;

import java.util.List;

public class ProveedorService {

	

	//Conexion proveedorRepository = new Conexion();
	ProveedorRepository proveedorRepository = new Conexion();
	
    @SuppressWarnings("unchecked")
	public JSONObject crearProveedor(Proveedor proveedor) throws Exception {
        JSONObject jsonResponse = new JSONObject();
        Proveedor proveedorGuardado = proveedorRepository.crearProveedor(proveedor);
        jsonResponse.put("tipo", "éxito");
        jsonResponse.put("mensaje", "Proveedor guardado exitosamente");
        jsonResponse.put("proveedorId", proveedorGuardado.getProveedorID());

        return jsonResponse;
    }
    
    @SuppressWarnings("unchecked")
    public JSONObject obtenerProveedorPorID(int proveedorID) throws Exception {
        JSONObject jsonResponse = new JSONObject();

        Proveedor proveedor = proveedorRepository.obtenerProveedorPorID(proveedorID);

        if (proveedor != null) {
            jsonResponse.put("tipo", "éxito");
            jsonResponse.put("mensaje", "Proveedor obtenido exitosamente");
            JSONObject proveedorJSON = proveedorToJSON(proveedor);
            jsonResponse.put("proveedor", proveedorJSON);
        } else {
            jsonResponse.put("tipo", "error");
            jsonResponse.put("mensaje", "Proveedor no encontrado");
        }

        return jsonResponse;
    }
    
    @SuppressWarnings("unchecked")
    public JSONObject obtenerTodosLosProveedores() throws Exception {
        JSONObject jsonResponse = new JSONObject();

        List<Proveedor> listaProveedores = proveedorRepository.obtenerTodosLosProveedor();

        if (!listaProveedores.isEmpty()) {
            jsonResponse.put("tipo", "éxito");
            jsonResponse.put("mensaje", "Proveedores obtenidos exitosamente");
            JSONArray jsonArrayProveedores = new JSONArray();

            for (Proveedor proveedor : listaProveedores) {
                jsonArrayProveedores.add(proveedorToJSON(proveedor));
            }

            jsonResponse.put("proveedores", jsonArrayProveedores);
        } else {
            jsonResponse.put("tipo", "error");
            jsonResponse.put("mensaje", "No se encontraron proveedores");
        }

        return jsonResponse;
    }
    
    @SuppressWarnings("unchecked")
    public JSONObject actualizarProveedor(Proveedor proveedor) throws Exception {
        JSONObject jsonResponse = new JSONObject();

        if (proveedorRepository.actualizarProveedor(proveedor) != null) {
            jsonResponse.put("tipo", "éxito");
            jsonResponse.put("mensaje", "Proveedor actualizado exitosamente");
            jsonResponse.put("proveedorId", proveedor.getProveedorID());
        } else {
            jsonResponse.put("tipo", "error");
            jsonResponse.put("mensaje", "Proveedor no encontrado");
        }

        return jsonResponse;
    }
    @SuppressWarnings("unchecked")
    public JSONObject eliminarProveedor(int proveedorID) throws Exception {
        JSONObject jsonResponse = new JSONObject();

        if (proveedorRepository.eliminarProveedor(proveedorID)) {
            jsonResponse.put("tipo", "éxito");
            jsonResponse.put("mensaje", "Proveedor eliminado exitosamente");
            jsonResponse.put("proveedorId", proveedorID);
        } else {
            jsonResponse.put("tipo", "error");
            jsonResponse.put("mensaje", "Proveedor no encontrado");
        }

        return jsonResponse;
    }
    @SuppressWarnings("unchecked")
    private JSONObject proveedorToJSON(Proveedor proveedor) {
        JSONObject proveedorJSON = new JSONObject();
        proveedorJSON.put("proveedorId", proveedor.getProveedorID());
        proveedorJSON.put("nombreProveedor", proveedor.getNombreProveedor());
        proveedorJSON.put("contacto", proveedor.getContacto());
        proveedorJSON.put("direccion", proveedor.getDireccion());
        proveedorJSON.put("activo", proveedor.isActivo());

        return proveedorJSON;
    }
}
