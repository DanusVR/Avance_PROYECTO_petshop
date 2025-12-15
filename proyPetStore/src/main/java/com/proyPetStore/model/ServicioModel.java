package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Mascota;
import com.proyPetStore.beans.Servicio;
import com.proyPetStore.util.Conexion;

public class ServicioModel extends Conexion {

	CallableStatement cs;
	ResultSet rs;

	public List<Servicio> listarServicios() {
		List<Servicio> lista = new ArrayList<>();
		try {
			String sql = "CALL sp_listar_servicios()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();

			while (rs.next()) {
				Servicio s = new Servicio();
				s.setId_servicio(rs.getInt("id_servicio"));
				s.setNombre(rs.getString("nombre"));
				s.setTipo(rs.getString("tipo"));
				s.setId_mascota(rs.getInt("id_mascota"));
				s.setNombreMascota(rs.getString("nombreMascota"));
				s.setDescripcion(rs.getString("descripcion"));
				s.setPrecio(rs.getDouble("precio"));
				s.setEstado(rs.getString("estado"));
				lista.add(s);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}
		return lista;
	}

	// LISTAR SERVICIOS POR MASCOTA (si quieres filtrar)
	public List<Servicio> listarServiciosPorMascota(int idMascota) {
		List<Servicio> lista = new ArrayList<>();

		try {
			String sql = "CALL sp_listar_servicios_por_mascota(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idMascota);
			rs = cs.executeQuery();

			while (rs.next()) {
				Servicio s = new Servicio();
				s.setId_servicio(rs.getInt("id_servicio"));
				s.setNombre(rs.getString("nombre"));
				s.setTipo(rs.getString("tipo"));
				s.setId_mascota(rs.getInt("id_mascota"));
				s.setNombreMascota(rs.getString("nombreMascota"));
				s.setDescripcion(rs.getString("descripcion"));
				s.setPrecio(rs.getDouble("precio"));
				s.setEstado(rs.getString("estado"));
				lista.add(s);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}

		return lista;
	}

	// INSERTAR SERVICIO
	public int insertarServicio(Servicio servicio) {
		int f = 0;
		try {
			String sql = "CALL sp_insertar_servicio(?,?,?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);

			cs.setString(1, servicio.getNombre());
			cs.setString(2, servicio.getTipo());
			cs.setInt(3, servicio.getId_mascota());
			cs.setString(4, servicio.getDescripcion());
			cs.setDouble(5, servicio.getPrecio());
			cs.setString(6, servicio.getEstado());

			f = cs.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}
		return f;
	}

	// OBTENER SERVICIO POR ID
	public Servicio obtenerServicio(int id) {
		Servicio s = null;

		try {
			String sql = "CALL sp_buscar_servicio(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, id);
			rs = cs.executeQuery();

			if (rs.next()) {
				s = new Servicio();
				s.setId_servicio(rs.getInt("id_servicio"));
				s.setNombre(rs.getString("nombre"));
				s.setTipo(rs.getString("tipo"));
				s.setId_mascota(rs.getInt("id_mascota"));
				s.setNombreMascota(rs.getString("nombreMascota"));
				s.setDescripcion(rs.getString("descripcion"));
				s.setPrecio(rs.getDouble("precio"));
				s.setEstado(rs.getString("estado"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}

		return s;
	}

	public double obtenerPrecio(int idServicio) {
		double precio = 0;
		try {
			String sql = "{CALL sp_obtenerPrecioServicio(?, ?)}";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idServicio);
			cs.registerOutParameter(2, Types.DECIMAL);
			cs.execute();
			precio = cs.getDouble(2);

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			this.cerrarConexion();
		}

		return precio;
	}

	// MODIFICAR SERVICIO
	public int modificarServicio(Servicio servicio) {
		int f = 0;
		try {
			String sql = "CALL sp_actualizar_servicio(?,?,?,?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);

			cs.setInt(1, servicio.getId_servicio());
			cs.setString(2, servicio.getNombre());
			cs.setString(3, servicio.getTipo());
			cs.setInt(4, servicio.getId_mascota());
			cs.setString(5, servicio.getDescripcion());
			cs.setDouble(6, servicio.getPrecio());
			cs.setString(7, servicio.getEstado());

			f = cs.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}
		return f;
	}

	// ELIMINAR SERVICIO
	public int eliminarServicio(int id) {
		int f = 0;

		try {
			String sql = "CALL sp_eliminar_servicio(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, id);

			f = cs.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}

		return f;
	}

	public List<Mascota> listarMascota() {
		List<Mascota> lista = new ArrayList<>();
		try {
			String sql = "CALL sp_listarMascota()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();

			while (rs.next()) {
				Mascota m = new Mascota();
				m.setId_mascota(rs.getInt("id_mascota"));
				m.setNombre_mascota(rs.getString("mascota"));
				m.setEspecie(rs.getString("especie"));
				m.setRaza(rs.getString("raza"));
				m.setSexo(rs.getString("sexo"));
				m.setEdad(rs.getInt("edad"));
				m.setId_cliente(rs.getInt("id_cliente"));
				m.setNombre(rs.getString("cliente"));
				lista.add(m);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}

		return lista;
	}

}
