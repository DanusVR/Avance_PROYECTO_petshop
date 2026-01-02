package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Cita;
import com.proyPetStore.beans.Mascota;
import com.proyPetStore.beans.Servicio;
import com.proyPetStore.util.Conexion;

public class CitaModel extends Conexion {
	CallableStatement cs;
	ResultSet rs;

	// Listar todas las citas

	public List<Cita> listarCitas() {
		List<Cita> lista = new ArrayList<>();
		try {
			String sql = "{CALL sp_listarCita()}";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();

			while (rs.next()) {
				Cita c = new Cita();
				c.setId_cita(rs.getInt("id_cita"));
				c.setId_mascota(rs.getInt("id_mascota"));
				c.setId_servicio(rs.getInt("id_servicio"));
				c.setFecha(rs.getDate("fecha"));
				c.setHora(rs.getString("hora"));
				c.setEstado(rs.getString("estado"));
				c.setObservacion(rs.getString("observacion"));
				c.setMascota(rs.getString("mascota"));
				c.setServicio(rs.getString("servicio"));
				c.setTipo_servicio(rs.getString("tipo_servicio"));

				lista.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}
		return lista;
	}

<<<<<<< HEAD
	// Insertar una cita
=======
	    public int insertarCita(Cita c) {
	        int filas = 0;
	        try {
	            String sql = "{CALL sp_insertarCita(?, ?, ?, ?, ?,?)}";
	            this.abrirConexion();
	            cs = conexion.prepareCall(sql);
	            cs.setInt(1, c.getId_mascota());
	            cs.setInt(2, c.getId_servicio());
	            cs.setDate(3, c.getFecha());
	            cs.setString(4, c.getHora());
	            cs.setString(5, c.getEstado());
	            cs.setString(6,c.getObservacion());
	            filas = cs.executeUpdate();
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            this.cerrarConexion();
	        }
	        return filas;
	    }
>>>>>>> branch 'main' of https://github.com/DanusVR/Avance_PROYECTO_petshop.git

	public int insertarCita(Cita c) {
		int filas = 0;
		try {
			String sql = "{CALL sp_insertarCita(?, ?, ?, ?, ?,?)}";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, c.getId_mascota());
			cs.setInt(2, c.getId_servicio());
			cs.setDate(3, c.getFecha());
			cs.setString(4, c.getHora());
			cs.setString(5, c.getEstado());
			cs.setString(6, c.getObservacion());
			filas = cs.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}
		return filas;
	}

	// Modificar una cita

	public int modificarCita(Cita c) {
		int filas = 0;
		try {
			String sql = "{CALL sp_modificarCita(?, ?, ?, ?, ?, ?,?)}";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, c.getId_cita());
			cs.setInt(2, c.getId_mascota());
			cs.setInt(3, c.getId_servicio());
			cs.setDate(4, c.getFecha());
			cs.setString(5, c.getHora());
			cs.setString(6, c.getEstado());
			cs.setString(7, c.getObservacion());
			filas = cs.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}
		return filas;
	}

	// Eliminar una cita
	public int eliminarCita(int id) {
		int filas = 0;
		try {
			String sql = "{CALL sp_eliminar_cita(?)}";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, id);
			filas = cs.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}
		return filas;
	}
	// Obtener una cita por id

	public Cita obtenerCita(int id) {
		Cita c = null;
		try {
			String sql = "{CALL sp_obtenerCita(?)}";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, id);
			rs = cs.executeQuery();

			if (rs.next()) {
				c = new Cita();
				c.setId_cita(rs.getInt("id_cita"));
				c.setId_mascota(rs.getInt("id_mascota"));
				c.setId_servicio(rs.getInt("id_servicio"));
				c.setFecha(rs.getDate("fecha"));
				c.setHora(rs.getString("hora"));
				c.setEstado(rs.getString("estado"));
				c.setObservacion(rs.getString("observacion"));
				c.setMascota(rs.getString("mascota"));
				c.setServicio(rs.getString("servicio"));
				c.setTipo_servicio(rs.getString("tipo_servicio"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}
		return c;
	}

	// Listar Servicios para ComboBox
	public List<Servicio> listarServicios() {
		ServicioModel sm = new ServicioModel();
		return sm.listarServicios();
	}

	// Listar Mascotas para ComboBox
	public List<Mascota> listarMascotas() {
		ServicioModel sm = new ServicioModel();
		return sm.listarMascota();
	}

}
