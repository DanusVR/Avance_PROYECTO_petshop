
package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Cliente;
import com.proyPetStore.beans.Mascota;
import com.proyPetStore.util.Conexion;

public class MascotaModel  extends Conexion{
	CallableStatement cs;
	ResultSet rs;

	 
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

	        } catch (Exception e) { e.printStackTrace(); }
	        finally { this.cerrarConexion(); }

	        return lista;
	    }
	
	 public Mascota obtenerMascota(int idmascota) {
		    Mascota m = null;
		    try {
		        String sql = "CALL sp_obtenerMascota(?)";
		        abrirConexion();
		        cs = conexion.prepareCall(sql);
		        cs.setInt(1, idmascota);
		        rs = cs.executeQuery();

		        if (rs.next()) {
		            m = new Mascota();
		            m.setId_mascota(rs.getInt("id_mascota"));
		            m.setNombre_mascota(rs.getString("mascota"));
		            m.setEspecie(rs.getString("especie"));
		            m.setRaza(rs.getString("raza"));
		            m.setSexo(rs.getString("sexo"));
		            m.setEdad(rs.getInt("edad"));
		            m.setId_cliente(rs.getInt("id_cliente"));
		            m.setNombre(rs.getString("cliente"));
		        }

		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        cerrarConexion();
		    }
		    return m;
		}
	
	 public int insertarMascota(Mascota m) throws SQLException {
		    int filas = 0;
		    try {
		        String sql = "CALL sp_insertarMascota(?,?,?,?,?,?)";
		        this.abrirConexion();
		        cs = conexion.prepareCall(sql);

		        // Validar especie
		        String especie = m.getEspecie();
		        if (!"Perro".equals(especie) && !"Gato".equals(especie)) {
		            especie = "Perro"; // valor por defecto
		        }

		        // Validar sexo
		        String sexo = m.getSexo();
		        if (!"Macho".equals(sexo) && !"Hembra".equals(sexo)) {
		            sexo = "Macho"; // valor por defecto
		        }

		        cs.setInt(1, m.getId_cliente());
		        cs.setString(2, m.getNombre_mascota());
		        cs.setString(3, especie);
		        cs.setString(4, m.getRaza());
		        cs.setInt(5, m.getEdad());
		        cs.setString(6, sexo);

		        filas = cs.executeUpdate();

		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        this.cerrarConexion();
		    }
		    return filas;
		}


	
	 public int modificarMascota(Mascota m) throws SQLException {
		    int filas = 0;
		    try {
		        String sql = "CALL sp_modificarMascota(?,?,?,?,?,?,?)";
		        this.abrirConexion();
		        cs = conexion.prepareCall(sql);

		        // Validar especie
		        String especie = m.getEspecie();
		        if (!"Perro".equals(especie) && !"Gato".equals(especie)) {
		            especie = "Perro"; 
		        }

		        // Validar sexo
		        String sexo = m.getSexo();
		        if (!"Macho".equals(sexo) && !"Hembra".equals(sexo)) {
		            sexo = "Macho"; 
		        }

		        cs.setInt(1, m.getId_mascota());
		        cs.setInt(2, m.getId_cliente());
		        cs.setString(3, m.getNombre_mascota());
		        cs.setString(4, especie);
		        cs.setString(5, m.getRaza());
		        cs.setInt(6, m.getEdad());
		        cs.setString(7, sexo);

		        filas = cs.executeUpdate();

		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        this.cerrarConexion();
		    }
		    return filas;
		}


	
	//metodo eliminar
	 public int eliminarMascota(int idmascota) {
		    int filas = 0;
		    try {
		        String sql = "CALL sp_eliminarMascota(?)";
		        this.abrirConexion();
		        cs = conexion.prepareCall(sql);
		        cs.setInt(1, idmascota);
		        filas = cs.executeUpdate();
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		    	this.cerrarConexion();
		    }
		    return filas;
		}

	
	//para llenar un combo
	public List<Cliente> listarClientes(){
	    List<Cliente> lista = new ArrayList<>();
	    try {
	        String sql = "CALL sp_listarClientes()"; 
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
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        this.cerrarConexion();
	    }
	    return lista;
	}
}
