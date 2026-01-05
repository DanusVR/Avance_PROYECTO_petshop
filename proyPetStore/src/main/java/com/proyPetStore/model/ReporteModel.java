package com.proyPetStore.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Venta;
import com.proyPetStore.util.Conexion;

public class ReporteModel extends Conexion {

    public List<Venta> filtrarVentas(String fechaInicio, String fechaFin) {
        List<Venta> lista = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs = null;

        // Use direct SQL to avoid dependency on unknown Stored Procedures
        // Assumes tables: venta, cliente, usuarios (based on models)
        String sql = "SELECT v.id_venta, v.fecha, c.nombre AS nombreCliente, c.apellido AS apellidoCliente, " +
                "u.nombre_usuario, v.tipo_pago, v.total, v.monto_pagado " +
                "FROM venta v " +
                "INNER JOIN cliente c ON v.id_cliente = c.id_cliente " +
                "INNER JOIN usuarios u ON v.idusuario = u.idusuario " +
                "WHERE v.fecha BETWEEN ? AND ? " +
                "ORDER BY v.fecha DESC";

        try {
            this.abrirConexion();
            ps = conexion.prepareStatement(sql);
            ps.setString(1, fechaInicio);
            ps.setString(2, fechaFin); // Ensure dates are in 'YYYY-MM-DD' or compatible format provided by input
                                       // type="date"

            rs = ps.executeQuery();

            while (rs.next()) {
                Venta v = new Venta();
                v.setId_venta(rs.getInt("id_venta"));
                v.setFecha(rs.getDate("fecha"));

                // Combine Name + Surname for display
                String clienteFull = rs.getString("nombreCliente") + " " + rs.getString("apellidoCliente");
                v.setNombreCliente(clienteFull);

                v.setNombreUsuario(rs.getString("nombre_usuario"));
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
                if (ps != null)
                    ps.close();
                this.cerrarConexion();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return lista;
    }
}
