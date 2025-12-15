package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Cliente;
import com.proyPetStore.beans.Detalle_Venta;
import com.proyPetStore.beans.Producto;
import com.proyPetStore.beans.Venta;
import com.proyPetStore.util.Conexion;

public class VentaModel extends Conexion {
	CallableStatement cs;
	ResultSet rs;

	public int insertarVenta(Venta v) {
		int idVenta = 0;

		try {
			this.abrirConexion();
			String sql = "{CALL sp_insertarVenta(?, ?, ?, ?, ?, ?)}";
			cs = conexion.prepareCall(sql);
			cs.setInt(1, v.getId_cliente());
			cs.setInt(2, v.getIdusuario());
			cs.setDouble(3, v.getTotal());
			cs.setString(4, v.getTipo_pago());
			cs.setDouble(5, v.getMonto_pagado());
			cs.registerOutParameter(6, Types.INTEGER);

			cs.execute();

			idVenta = cs.getInt(6);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
			this.cerrarConexion();
		}

		return idVenta;
	}

	public void insertarDetalle(List<Detalle_Venta> lista) {

		try {
			this.abrirConexion();

			for (Detalle_Venta d : lista) {
				String sql = "{CALL sp_insertarDetalleVenta(?, ?, ?, ?, ?, ?)}";
				cs = conexion.prepareCall(sql);

				cs.setInt(1, d.getId_venta());
				if (d.getId_producto() != null)
					cs.setInt(2, d.getId_producto());
				else
					cs.setNull(2, Types.INTEGER);

				if (d.getId_servicio() != null)
					cs.setInt(3, d.getId_servicio());
				else
					cs.setNull(3, Types.INTEGER);

				cs.setInt(4, d.getCantidad());
				cs.setDouble(5, d.getPrecio());
				cs.setDouble(6, d.getSubtotal());

				cs.execute();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
			this.cerrarConexion();
		}
	}

	public void descontarStock(int idProducto, int cantidad) {
		try {
			this.abrirConexion();
           String sql  = "{CALL sp_descontarStock(?, ?)}";
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idProducto);
			cs.setInt(2, cantidad);

			cs.execute();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
	      this.cerrarConexion();
		}
	}
	public List<Venta> listarVentas() {
	    List<Venta> lista = new ArrayList<>();
	    try {
	        String sql = "{CALL sp_listarVentas()}"; 
	        this.abrirConexion();
	        cs = conexion.prepareCall(sql);
	        rs = cs.executeQuery();
	        
	        while (rs.next()) {
	            Venta v = new Venta();
	            v.setId_venta(rs.getInt("id_venta"));
	            v.setId_cliente(rs.getInt("id_cliente"));
	            v.setNombreCliente(rs.getString("cliente")); 
	            v.setFecha(rs.getDate("fecha"));
	            v.setTotal(rs.getDouble("total"));
	            v.setTipo_pago(rs.getString("tipo_pago"));
	            v.setMonto_pagado(rs.getDouble("monto_pagado"));
	            lista.add(v);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        this.cerrarConexion();
	    }
	    return lista;
	}

	public Venta obtenerVentaporId(int idVenta) {
	    Venta venta = null;
	    try {
	       
	        String sql = "{CALL sp_obtenerVentaPorId(?)}";
	        this.abrirConexion();
	        cs = conexion.prepareCall(sql);
	        cs.setInt(1, idVenta);

	        rs = cs.executeQuery();

	        if (rs.next()) {
	            venta = new Venta();
	            venta.setId_venta(rs.getInt("id_venta"));
	            venta.setId_cliente(rs.getInt("id_cliente"));
	            venta.setIdusuario(rs.getInt("idusuario")); 
	            venta.setFecha(rs.getDate("fecha"));  
	            venta.setTotal(rs.getDouble("total"));
	            venta.setTipo_pago(rs.getString("tipo_pago"));
	            venta.setMonto_pagado(rs.getDouble("monto_pagado"));	         
	            venta.setNombreCliente(rs.getString("nombreCliente")); 
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        this.cerrarConexion();
	    }

	    return venta;
	}
	



}
