package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.CompraDetalle;
import com.proyPetStore.beans.Compras;
import com.proyPetStore.util.Conexion;

public class CompraModel extends Conexion{
	 CallableStatement cs;
	 ResultSet rs;

	    // Listar 
	    public List<Compras> listarCompras() {
	        List<Compras> lista = new ArrayList<>();
	        try {
	            String sql = "CALL sp_listarCompras()";
	            this.abrirConexion();
	            cs = conexion.prepareCall(sql);
	            rs = cs.executeQuery();

	            while (rs.next()) {
	                Compras c = new Compras();
	                c.setId_compra(rs.getInt("id_compra"));
	                c.setId_proveedor(rs.getInt("id_proveedor"));
	                c.setNombreProveedor(rs.getString("proveedor"));
	                c.setFecha_compra(rs.getDate("fecha_compra"));
	                c.setTotal(rs.getDouble("total"));
	                c.setEstado(rs.getString("estado"));
	                lista.add(c);
	            }
	        } catch (Exception e) { e.printStackTrace(); }
	        finally { this.cerrarConexion(); }
	        return lista;
	    }

	    // Obtener una compra con detalles
	    public Compras obtenerCompra(int id_compra) {
	        Compras c = null;
	        try {
	            String sql = "CALL sp_obtenerCompra(?)";
	            abrirConexion();
	            cs = conexion.prepareCall(sql);
	            cs.setInt(1, id_compra);
	            rs = cs.executeQuery();

	            if (rs.next()) {
	                c = new Compras();
	                c.setId_compra(rs.getInt("id_compra"));
	                c.setId_proveedor(rs.getInt("id_proveedor"));
	                c.setNombreProveedor(rs.getString("proveedor"));
	                c.setFecha_compra(rs.getDate("fecha_compra"));
	                c.setTotal(rs.getDouble("total"));
	                c.setEstado(rs.getString("estado"));
	            }
	            // Traer detalle
	            sql = "CALL sp_listarDetalleCompra(?)";
	            cs = conexion.prepareCall(sql);
	            cs.setInt(1, id_compra);
	            rs = cs.executeQuery();

	            List<CompraDetalle> detalles = new ArrayList<>();
	            while (rs.next()) {
	                CompraDetalle d = new CompraDetalle();
	                d.setId_compra_detalle(rs.getInt("id_compra_detalle"));
	                d.setId_producto(rs.getInt("id_producto"));
	                d.setNombreProducto(rs.getString("producto"));
	                d.setCantidad(rs.getInt("cantidad"));
	                d.setPrecio_unitario(rs.getDouble("precio_unitario"));
	                d.setSubtotal(rs.getDouble("subtotal"));
	                detalles.add(d);
	            }
	            if (c != null) c.setDetalles(detalles);

	        } catch (Exception e) { e.printStackTrace(); }
	        finally { cerrarConexion(); }
	        return c;
	    }

	    // Insertar compra con detalle y actualizar stock
	    public int insertarCompra(Compras compra) {
	        int filas = 0;

	        try {
	            this.abrirConexion();

	            //  Insertar la compra
	            String sqlCompra = "{CALL sp_insertarCompra(?, ?, ?)}"; 
	            cs = conexion.prepareCall(sqlCompra);
	            cs.setInt(1, compra.getId_proveedor());
	            cs.setDouble(2, compra.getTotal());
	            cs.setString(3, "activo"); 
	            cs.executeUpdate();

	            // Obtener el id_compra insertado
	            cs = conexion.prepareCall("SELECT LAST_INSERT_ID() AS id_compra");
	            ResultSet rs = cs.executeQuery();
	            int idCompraGenerada = 0;
	            if (rs.next()) {
	                idCompraGenerada = rs.getInt("id_compra");
	            }
	            rs.close();

	            // Insertar cada detalle y actualizar stock
	            String sqlDetalle = "{CALL sp_insertarDetalleCompra(?, ?, ?, ?)}";
	            for (CompraDetalle d : compra.getDetalles()) {
	                CallableStatement csDet = conexion.prepareCall(sqlDetalle);
	                csDet.setInt(1, idCompraGenerada);     
	                csDet.setInt(2, d.getId_producto());   
	                csDet.setInt(3, d.getCantidad());      
	                csDet.setDouble(4, d.getPrecio_unitario());
	                csDet.executeUpdate();
	                csDet.close();
	            }

	            filas = 1;

	        } catch (Exception e) {
	            e.printStackTrace();	           
	        } finally {
	        	this.cerrarConexion();
	        }

	        return filas;
	    }
	    
	    //Eliminar	    
	    public int eliminarCompra(int idCompra) {
	        int filas = 0;

	        try {
	            this.abrirConexion();
	            // Llamamos al procedimiento que anula la compra y actualiza stock
	            String sql = "{CALL sp_anularCompra(?)}";
	            cs = conexion.prepareCall(sql);
	            cs.setInt(1, idCompra);

	            filas = cs.executeUpdate();

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	        	this.cerrarConexion();
	        }

	        return filas;
	    }



}
