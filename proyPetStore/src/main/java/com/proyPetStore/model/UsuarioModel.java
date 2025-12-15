package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Usuario;
import com.proyPetStore.util.Conexion;

public class UsuarioModel extends Conexion {

	CallableStatement cs;
	ResultSet rs;
	// ===============================
	// AUTENTICAR USUARIO
	// ===============================
	public Usuario autenticarUsuario(String user, String pass) {
		Usuario u = null;
		try {
			String sql = "CALL sp_autenticarUsuario(?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setString(1, user);
			cs.setString(2, pass);
			rs = cs.executeQuery();

			if (rs.next()) {
				u = new Usuario();
				u.setId_usuario(rs.getInt("id_usuario"));
				u.setNombre(rs.getString("nombre"));
				u.setUsuario(rs.getString("usuario"));
				u.setClave(rs.getString("clave"));
				u.setRol(rs.getString("rol"));
				u.setEstado(rs.getString("estado"));
			}

			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return u;
	}

	// ===============================
	// LISTAR USUARIOS
	// ===============================
	public List<Usuario> listarUsuarios() {
		List<Usuario> lista = new ArrayList();
		try {
			String sql = "CALL sp_listarUsuarios()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();

			while (rs.next()) {
				Usuario u = new Usuario();
				u.setId_usuario(rs.getInt("id_usuario"));
				u.setNombre(rs.getString("nombre"));
				u.setUsuario(rs.getString("usuario"));
				u.setClave(rs.getString("clave"));
				u.setRol(rs.getString("rol"));
				u.setEstado(rs.getString("estado"));
				lista.add(u);
			}

			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return lista;
	}

	// ===============================
	// INSERTAR USUARIO
	// ===============================
	public int insertarUsuario(Usuario u) {
		int filas = 0;
		try {
			String sql = "CALL sp_insertarUsuario(?,?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setString(1, u.getNombre());
			cs.setString(2, u.getUsuario());
			cs.setString(3, u.getClave());
			cs.setString(4, u.getRol());
			cs.setString(5, u.getEstado());
			filas = cs.executeUpdate();

			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return filas;
	}

	// ===============================
	// OBTENER USUARIO POR ID
	// ===============================
	public Usuario obtenerUsuario(int id) {
		Usuario u = null;
		try {
			String sql = "CALL sp_obtenerUsuario(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, id);
			rs = cs.executeQuery();

			if (rs.next()) {
				u = new Usuario();
				u.setId_usuario(rs.getInt("id_usuario"));
				u.setNombre(rs.getString("nombre"));
				u.setUsuario(rs.getString("usuario"));
				u.setClave(rs.getString("clave"));
				u.setRol(rs.getString("rol"));
				u.setEstado(rs.getString("estado"));
				
			}

			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return u;
	}

	// ===============================
	// MODIFICAR USUARIO
	// ===============================
	public int modificarUsuario(Usuario u) {
		int filas = 0;
		try {
			String sql = "CALL sp_modificarUsuario(?,?,?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, u.getId_usuario());
			cs.setString(2, u.getNombre());
			cs.setString(3, u.getUsuario());
			cs.setString(4, u.getClave());
			cs.setString(5, u.getRol());
			cs.setString(6, u.getEstado());
			filas = cs.executeUpdate();

			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return filas;
	}

	// ===============================
	// ELIMINAR USUARIO
	// ===============================
	public int eliminarUsuario(int id) {
		int filas = 0;
		try {
			String sql = "CALL sp_eliminarUsuario(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, id);
			filas = cs.executeUpdate();

			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return filas;
	}
}
