package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Categoria;
import com.proyPetStore.util.Conexion;



public class CategoriaModel extends Conexion{
	CallableStatement cs;
	ResultSet rs;

	
	public List<Categoria> listarCategoria() {
		List<Categoria> lista = new ArrayList<>();
		try {
			String sql = "CALL sp_listarCategoria()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();
			while (rs.next()) {
				Categoria c = new Categoria();
				c.setId_categoria(rs.getInt("id_categoria"));
				c.setNombreCat(rs.getString("nombreCat"));
				
				lista.add(c);
			}
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return lista;
	}

	
	public int insertarCategoria(Categoria categoria) {
		int f = 0;
		try {
			String sql = "CALL sp_insertarCategoria(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);			
			cs.setString(1, categoria.getNombreCat());			
			f = cs.executeUpdate();
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return f;
	}

	public Categoria obtenerCategoria(int id) {
		Categoria c = new Categoria();
		try {
			String sql = "CALL sp_obtenerCategoria(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, id);
			rs = cs.executeQuery();
			if (rs.next()) {
				c.setId_categoria(rs.getInt("id_categoria"));
				c.setNombreCat(rs.getString("nombreCat"));
				
			}
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}
		return c;
	}

	
	public int modificarCategoria(Categoria categoria) {
		int f = 0;
		try {
			String sql = "CALL sp_modificarCategoria(?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, categoria.getId_categoria());
			cs.setString(2, categoria.getNombreCat());
			
			f = cs.executeUpdate();
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return f;
	}

	public int eliminarCategoria(int id) {
		int f = 0;
		try {
			String sql = "CALL sp_eliminarCategoria(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, id);
			f = cs.executeUpdate();
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return f;
	}
}
