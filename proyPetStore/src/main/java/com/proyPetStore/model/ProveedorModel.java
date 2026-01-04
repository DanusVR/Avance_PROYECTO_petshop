package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Proveedor;
import com.proyPetStore.util.Conexion;

public class ProveedorModel extends Conexion{
	CallableStatement cs;
	ResultSet rs;
	
	// LISTAR PROVEEDORES

	public List<Proveedor> listarProveedor() {
	    List<Proveedor> lista = new ArrayList<>();
	    try {
	        String sql = "CALL sp_proveedor_listar()";
	        this.abrirConexion();
	        cs = conexion.prepareCall(sql);
	        rs = cs.executeQuery();

	        while (rs.next()) {
	            Proveedor p = new Proveedor();
	            p.setIdProveedor(rs.getInt("id_proveedor"));
	            p.setNombre(rs.getString("nombre"));
	            p.setRuc(rs.getString("ruc"));
	            p.setTelefono(rs.getString("telefono"));
	            p.setCorreo(rs.getString("correo"));
	            p.setDireccion(rs.getString("direccion"));
	            p.setTipo(rs.getString("tipo"));
	            p.setEstado(rs.getString("estado"));
	            lista.add(p);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        this.cerrarConexion();
	    }
	    return lista;
	}	
	// OBTENER PROVEEDOR
	public Proveedor obtenerProveedor(int idProveedor) {
	    Proveedor p = null;
	    try {
	        String sql = "CALL sp_proveedor_obtener(?)";
	        this.abrirConexion();
	        cs = conexion.prepareCall(sql);
	        cs.setInt(1, idProveedor);
	        rs = cs.executeQuery();

	        if (rs.next()) {
	            p = new Proveedor();
	            p.setIdProveedor(rs.getInt("id_proveedor"));
	            p.setNombre(rs.getString("nombre"));
	            p.setRuc(rs.getString("ruc"));
	            p.setTelefono(rs.getString("telefono"));
	            p.setCorreo(rs.getString("correo"));
	            p.setDireccion(rs.getString("direccion"));
	            p.setTipo(rs.getString("tipo"));
	            p.setEstado(rs.getString("estado"));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        this.cerrarConexion();
	    }
	    return p;
	}
	
	// INSERTAR PROVEEDOR

	public int insertarProveedor(Proveedor p) {
	    int filas = 0;
	    try {
	        String sql = "CALL sp_proveedor_insertar(?,?,?,?,?,?)";
	        this.abrirConexion();
	        cs = conexion.prepareCall(sql);

	        cs.setString(1, p.getNombre());
	        cs.setString(2, p.getRuc());
	        cs.setString(3, p.getTelefono());
	        cs.setString(4, p.getCorreo());
	        cs.setString(5, p.getDireccion());
	        cs.setString(6, p.getTipo());

	        filas = cs.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        this.cerrarConexion();
	    }
	    return filas;
	}
	
	// MODIFICAR PROVEEDOR

	public int modificarProveedor(Proveedor p) {
	    int filas = 0;
	    try {
	        String sql = "CALL sp_proveedor_actualizar(?,?,?,?,?,?,?)";
	        this.abrirConexion();
	        cs = conexion.prepareCall(sql);

	        cs.setInt(1, p.getIdProveedor());
	        cs.setString(2, p.getNombre());
	        cs.setString(3, p.getRuc());
	        cs.setString(4, p.getTelefono());
	        cs.setString(5, p.getCorreo());
	        cs.setString(6, p.getDireccion());
	        cs.setString(7, p.getTipo());

	        filas = cs.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        this.cerrarConexion();
	    }
	    return filas;
	}
	
	// ELIMINAR 
	public int eliminarProveedor(int idProveedor) {
	    int filas = 0;
	    try {
	        String sql = "CALL sp_proveedor_desactivar(?)";
	        this.abrirConexion();
	        cs = conexion.prepareCall(sql);
	        cs.setInt(1, idProveedor);

	        filas = cs.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        this.cerrarConexion();
	    }
	    return filas;
	}
	

}
