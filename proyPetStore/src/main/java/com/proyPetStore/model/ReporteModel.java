package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Venta;
import com.proyPetStore.util.Conexion;

public class ReporteModel extends Conexion {
	
	CallableStatement cs;
	ResultSet rs;

    public List<Venta> filtrarVentas(String fechaInicio, String fechaFin) {
        List<Venta> lista = new ArrayList<>();
      

        /*String sql = "SELECT v.id_venta, v.fecha, c.nombre AS nombreCliente, c.apellido AS apellidoCliente, " +
                "u.nombre_usuario, v.tipo_pago, v.total, v.monto_pagado " +
                "FROM venta v " +
                "INNER JOIN cliente c ON v.id_cliente = c.id_cliente " +
                "INNER JOIN usuarios u ON v.idusuario = u.idusuario " +
                "WHERE v.fecha BETWEEN ? AND ? " +
                "ORDER BY v.fecha DESC";*/

        try {
        	String sql = "CALL sp_reporteVentas(?,?)";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setString(1, fechaInicio);
            cs.setString(2, fechaFin);
            rs = cs.executeQuery();

            while (rs.next()) {
                Venta v = new Venta();
                v.setId_venta(rs.getInt("id_venta"));
                v.setFecha(rs.getDate("fecha"));

                // Combine Name + Surname for display
                String clienteFull = rs.getString("cliente_nombre") + " " + rs.getString("cliente_apellido");
                v.setNombreCliente(clienteFull);

                v.setNombreUsuario(rs.getString("usuario_nombre"));
                v.setTipo_pago(rs.getString("tipo_pago"));
                v.setTotal(rs.getDouble("total"));
                v.setMonto_pagado(rs.getDouble("monto_pagado"));

                lista.add(v);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (cs != null)
                    cs.close();
                this.cerrarConexion();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return lista;
    }
}
