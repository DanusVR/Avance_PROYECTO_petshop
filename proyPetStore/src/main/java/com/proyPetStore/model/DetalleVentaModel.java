package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Detalle_Venta;
import com.proyPetStore.util.Conexion;

public class DetalleVentaModel extends Conexion {

	CallableStatement cs;
	ResultSet rs;

	public void insertarListaDetalles(List<Detalle_Venta> lista) {

		try {
			this.abrirConexion();
			for (Detalle_Venta d : lista) {
				String sql = "{CALL sp_insertarDetalleVenta(?, ?, ?, ?, ?, ?)}";
				cs = conexion.prepareCall(sql);

				cs.setInt(1, d.getId_venta());
				if (d.getId_producto() != null && d.getId_producto() > 0)
					cs.setInt(2, d.getId_producto());
				else
					cs.setNull(2, Types.INTEGER);

				if (d.getId_servicio() != null && d.getId_servicio() > 0)
					cs.setInt(3, d.getId_servicio());
				else
					cs.setNull(3, Types.INTEGER);

				cs.setInt(4, d.getCantidad() != null ? d.getCantidad() : 1);

				if (d.getPrecio() != null)
					cs.setDouble(5, d.getPrecio());
				else
					cs.setNull(5, Types.DOUBLE);
				if (d.getSubtotal() != null)
					cs.setDouble(6, d.getSubtotal());
				else
					cs.setNull(6, Types.DOUBLE);

				cs.executeUpdate();
				cs.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			this.cerrarConexion();
		}
	}
	
	public List<Detalle_Venta> listarPorVentaporid(int idVenta) {
	    List<Detalle_Venta> lista = new ArrayList<>();
	    try {
	        String sql = "{CALL sp_listarDetallePorVenta(?)}";
	        this.abrirConexion();
	        cs = conexion.prepareCall(sql);
	        cs.setInt(1, idVenta);

	        rs = cs.executeQuery();

	        while (rs.next()) {
	            Detalle_Venta d = new Detalle_Venta();

	            int prod = rs.getInt("id_producto");
	            d.setId_producto(rs.wasNull() ? null : prod);

	            int serv = rs.getInt("id_servicio");
	            d.setId_servicio(rs.wasNull() ? null : serv);

	            d.setId_detalle(rs.getInt("id_detalle"));
	            d.setId_venta(rs.getInt("id_venta"));
	            d.setCantidad(rs.getInt("cantidad"));
	            d.setPrecio(rs.getDouble("precio"));
	            d.setSubtotal(rs.getDouble("subtotal"));

	            d.setNombre_producto(rs.getString("nombre_producto"));
	            d.setNombre_servicio(rs.getString("nombre_servicio"));

	            lista.add(d);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        this.cerrarConexion();
	    }

	    return lista;
	}


}
