package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Historial_Medico;
import com.proyPetStore.util.Conexion;

public class HistorialMedicoModel extends Conexion {
	CallableStatement cs;
	ResultSet rs;

	// LISTAR todos los historiales médicos
	public List<Historial_Medico> listar() {
		List<Historial_Medico> lista = new ArrayList<>();
		try {
			String sql = "{call sp_listar_historial_medico()}";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();
			while (rs.next()) {
				Historial_Medico hm = new Historial_Medico();
				hm.setId_historial(rs.getInt("id_historial"));
				hm.setId_mascota(rs.getInt("id_mascota"));
				hm.setFecha(rs.getDate("fecha"));
				hm.setDescripcion(rs.getString("descripcion"));
				hm.setNombreMascota(rs.getString("nombreMascota"));
				lista.add(hm);
			}
			this.cerrarConexion();
			;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}

	// INSERTAR un historial médico
	public int insertar(Historial_Medico hm) {
		int filas = 0;
		try {
			String sql = "{call sp_insertar_historial_medico(?, ?, ?)}";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, hm.getId_mascota());
			cs.setDate(2, new java.sql.Date(hm.getFecha().getTime()));
			cs.setString(3, hm.getDescripcion());
			filas = cs.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cerrarConexion();
		}
		return filas;
	}

	// BUSCAR historial por id de mascota
	public List<Historial_Medico> buscarPorMascota(int idMascota) {
		List<Historial_Medico> lista = new ArrayList<>();
		try {
			String sql = "{call sp_buscar_historial_por_mascota(?)}";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idMascota);
			rs = cs.executeQuery();
			while (rs.next()) {
				Historial_Medico hm = new Historial_Medico();
				hm.setId_historial(rs.getInt("id_historial"));
				hm.setId_mascota(rs.getInt("id_mascota"));
				hm.setFecha(rs.getDate("fecha"));
				hm.setDescripcion(rs.getString("descripcion"));
				hm.setNombreMascota(rs.getString("nombreMascota"));
				lista.add(hm);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}
		return lista;
	}
	// BUSCAR historial por ID
	public Historial_Medico ObtenerPorId(int idHistorial) {
	    Historial_Medico hm = null;
	    try {
	        String sql = "{call sp_obtener_historial_por_id(?)}";
	        this.abrirConexion();
	        cs = conexion.prepareCall(sql);
	        cs.setInt(1, idHistorial);
	        rs = cs.executeQuery();
	        if (rs.next()) {
	            hm = new Historial_Medico();
	            hm.setId_historial(rs.getInt("id_historial"));
	            hm.setId_mascota(rs.getInt("id_mascota"));
	            hm.setFecha(rs.getDate("fecha"));
	            hm.setDescripcion(rs.getString("descripcion"));
	            hm.setNombreMascota(rs.getString("nombreMascota"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        this.cerrarConexion();
	    }
	    return hm;
	}

	// MODIFICAR historial médico
	public int modificar(Historial_Medico hm) {
	    int filas = 0;
	    try {
	        String sql = "{call sp_modificar_historial_medico(?, ?, ?, ?)}";
	        this.abrirConexion();
	        cs = conexion.prepareCall(sql);
	        cs.setInt(1, hm.getId_historial());
	        cs.setInt(2, hm.getId_mascota());
	        cs.setDate(3, new java.sql.Date(hm.getFecha().getTime()));
	        cs.setString(4, hm.getDescripcion());
	        filas = cs.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        this.cerrarConexion();
	    }
	    return filas;
	}

	// ELIMINAR historial médico
	public int eliminar(int idHistorial) {
	    int filas = 0;
	    try {
	        String sql = "{call sp_eliminar_historial_medico(?)}";
	        this.abrirConexion();
	        cs = conexion.prepareCall(sql);
	        cs.setInt(1, idHistorial);
	        filas = cs.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        this.cerrarConexion();
	    }
	    return filas;
	}

}
