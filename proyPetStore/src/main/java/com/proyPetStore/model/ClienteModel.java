package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Cliente;
import com.proyPetStore.util.Conexion;

public class ClienteModel extends Conexion {

	CallableStatement cs;
	ResultSet rs;

	// Listar todos los clientes
	public List<Cliente> listarClientes() {
		List<Cliente> lista = new ArrayList<>();
		try {
			String sql = "CALL sp_listarClientes()"; // si quieres crear este procedimiento luego
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();
			while (rs.next()) {
				Cliente c = new Cliente();
				c.setId_cliente(rs.getInt("id_cliente"));
				c.setDni(rs.getString("dni"));
				c.setNombreC(rs.getString("nombreC"));
				c.setApellido(rs.getString("apellido"));
				c.setTelefono(rs.getString("telefono"));
				c.setDireccion(rs.getString("direccion"));
				lista.add(c);
			}
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return lista;
	}

	// Insertar cliente
	public int insertarClientes(Cliente cliente) {
		int f = 0;
		try {
			String sql = "CALL sp_insertarCliente(?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setString(1,cliente.getDni());
			cs.setString(2, cliente.getNombreC());
			cs.setString(3, cliente.getApellido());
			cs.setString(4, cliente.getTelefono());
			cs.setString(5, cliente.getDireccion());
			f = cs.executeUpdate();
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return f;
	}

	// Obtener cliente por id
	public Cliente obtenerCliente(int id) {
		Cliente c = new Cliente();
		try {
			String sql = "CALL sp_obtenerCliente(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, id);
			rs = cs.executeQuery();
			if (rs.next()) {
				c.setId_cliente(rs.getInt("id_cliente"));
				c.setDni(rs.getString("dni"));
				c.setNombreC(rs.getString("nombreC"));
				c.setApellido(rs.getString("apellido"));
				c.setTelefono(rs.getString("telefono"));
				c.setDireccion(rs.getString("direccion"));
			}
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}
		return c;
	}

	// Modificar cliente
	public int modificarClientes(Cliente cliente) {
		int f = 0;
		try {
			String sql = "CALL sp_modificarCliente(?,?,?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, cliente.getId_cliente());
			cs.setString(2, cliente.getDni());
			cs.setString(3, cliente.getNombreC());
			cs.setString(4, cliente.getApellido());
			cs.setString(5, cliente.getTelefono());
			cs.setString(6, cliente.getDireccion());
			f = cs.executeUpdate();
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return f;
	}

	// Eliminar cliente
	public int eliminarClientes(int id) {
		int f = 0;
		try {
			String sql = "CALL sp_eliminarCliente(?)";
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
