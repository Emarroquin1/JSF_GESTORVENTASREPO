package repository;

import model.Usuario;

public interface UsuarioRepository {
	public Usuario login(Usuario usuario) throws Exception;
}
