package service;

import org.json.simple.JSONObject;

import model.Usuario;
import repository.Conexion;
import repository.UsuarioRepository;

public class UsuarioService {
	
		UsuarioRepository  usuarioRepository = new Conexion();
	
	@SuppressWarnings("unchecked")
	public JSONObject login(Usuario usuario) throws Exception{
        JSONObject jsonResponse = new JSONObject();
		JSONObject usuarioJSON = this.usuarioToJSON(usuarioRepository.login(usuario));
		
		if(usuarioJSON != null) {
	        jsonResponse.put("tipo", "éxito");
	        jsonResponse.put("mensaje", "Usuario encontrado exitosamente");
	        jsonResponse.put("usuario",usuarioJSON);
		}else {
			   jsonResponse.put("tipo", "error");
		       jsonResponse.put("mensaje", "Usuario no encontrado");
		       jsonResponse.put("usuario",0);
		}
		

		return jsonResponse;
		
	}
	
	 @SuppressWarnings("unchecked")
	  public  JSONObject usuarioToJSON(Usuario usuario) {
	        JSONObject usuarioJSON = new JSONObject();
	        if(usuario != null) {
	            usuarioJSON.put("usuarioID", usuario.getUsuarioID());
		        usuarioJSON.put("dui", usuario.getDui());
		        usuarioJSON.put("correo", usuario.getCorreo());
		        usuarioJSON.put("nombre", usuario.getNombre());
		        usuarioJSON.put("rol", usuario.getRol());
		        usuarioJSON.put("contrasena", usuario.getContrasena());
		        usuarioJSON.put("activo", usuario.isActivo());
	        }else {
	        	usuarioJSON =null;
	        }
	   
	        return usuarioJSON;
	    }
}
