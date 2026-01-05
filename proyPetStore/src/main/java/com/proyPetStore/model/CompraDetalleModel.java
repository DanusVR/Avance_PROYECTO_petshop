package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.CompraDetalle;
import com.proyPetStore.util.Conexion;

public class CompraDetalleModel extends Conexion {

    CallableStatement cs;
    ResultSet rs;

    /**
     * Inserta una lista de detalles de compra
     * 
     * @param lista Lista de detalles a insertar
     */
    public void insertarListaDetalles(List<CompraDetalle> lista) {
        try {
            this.abrirConexion();
            for (CompraDetalle d : lista) {
                String sql = "{CALL sp_insertarDetalleCompra(?, ?, ?, ?, ?)}";
                cs = conexion.prepareCall(sql);

                cs.setInt(1, d.getId_compra());
                cs.setInt(2, d.getId_producto());
                cs.setInt(3, d.getCantidad());
                cs.setDouble(4, d.getPrecio_unitario());
                cs.registerOutParameter(5, java.sql.Types.INTEGER);

                cs.executeUpdate();
                cs.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.cerrarConexion();
        }
    }

    /**
     * Inserta una lista de detalles de compra usando una conexión externa
     * Útil para mantener transacciones
     * 
     * @param lista           Lista de detalles a insertar
     * @param conexionExterna Conexión de base de datos externa
     */
    public void insertarListaDetallesConConexion(List<CompraDetalle> lista, java.sql.Connection conexionExterna) {
        try {
            for (CompraDetalle d : lista) {
                String sql = "{CALL sp_insertarDetalleCompra(?, ?, ?, ?, ?)}";
                CallableStatement csTemp = conexionExterna.prepareCall(sql);

                csTemp.setInt(1, d.getId_compra());
                csTemp.setInt(2, d.getId_producto());
                csTemp.setInt(3, d.getCantidad());
                csTemp.setDouble(4, d.getPrecio_unitario());
                csTemp.registerOutParameter(5, java.sql.Types.INTEGER); // OUT parameter

                csTemp.executeUpdate();
                csTemp.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Error al insertar detalles de compra: " + e.getMessage(), e);
        }
    }

    /**
     * Lista todos los detalles de una compra específica
     * 
     * @param idCompra ID de la compra
     * @return Lista de detalles de la compra
     */
    public List<CompraDetalle> listarPorCompra(int idCompra) {
        List<CompraDetalle> lista = new ArrayList<>();
        try {
            String sql = "{CALL sp_listarDetalleCompra(?)}";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setInt(1, idCompra);

            rs = cs.executeQuery();

            while (rs.next()) {
                CompraDetalle d = new CompraDetalle();
                d.setId_compra_detalle(rs.getInt("id_compra_detalle"));
                d.setId_compra(rs.getInt("id_compra"));
                d.setId_producto(rs.getInt("id_producto"));
                d.setNombreProducto(rs.getString("producto"));
                d.setCantidad(rs.getInt("cantidad"));
                d.setPrecio_unitario(rs.getDouble("precio_unitario"));
                d.setSubtotal(rs.getDouble("subtotal"));

                lista.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.cerrarConexion();
        }

        return lista;
    }

    /**
     * Obtiene un detalle de compra específico por su ID
     * 
     * @param idDetalle ID del detalle de compra
     * @return Objeto CompraDetalle o null si no existe
     */
    public CompraDetalle obtenerDetalle(int idDetalle) {
        CompraDetalle d = null;
        try {
            String sql = "{CALL sp_obtenerDetalleCompra(?)}";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setInt(1, idDetalle);

            rs = cs.executeQuery();

            if (rs.next()) {
                d = new CompraDetalle();
                d.setId_compra_detalle(rs.getInt("id_compra_detalle"));
                d.setId_compra(rs.getInt("id_compra"));
                d.setId_producto(rs.getInt("id_producto"));
                d.setNombreProducto(rs.getString("producto"));
                d.setCantidad(rs.getInt("cantidad"));
                d.setPrecio_unitario(rs.getDouble("precio_unitario"));
                d.setSubtotal(rs.getDouble("subtotal"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.cerrarConexion();
        }

        return d;
    }

    /**
     * Actualiza un detalle de compra existente
     * 
     * @param detalle Objeto CompraDetalle con los datos actualizados
     * @return Número de filas afectadas
     */
    public int actualizarDetalle(CompraDetalle detalle) {
        int filas = 0;
        try {
            String sql = "{CALL sp_actualizarDetalleCompra(?, ?, ?, ?)}";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);

            cs.setInt(1, detalle.getId_compra_detalle());
            cs.setInt(2, detalle.getId_producto());
            cs.setInt(3, detalle.getCantidad());
            cs.setDouble(4, detalle.getPrecio_unitario());

            filas = cs.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.cerrarConexion();
        }

        return filas;
    }

    /**
     * Elimina un detalle de compra
     * 
     * @param idDetalle ID del detalle a eliminar
     * @return Número de filas afectadas
     */
    public int eliminarDetalle(int idDetalle) {
        int filas = 0;
        try {
            String sql = "{CALL sp_eliminarDetalleCompra(?)}";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setInt(1, idDetalle);

            filas = cs.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.cerrarConexion();
        }

        return filas;
    }

    /**
     * Inserta un único detalle de compra
     * 
     * @param detalle Objeto CompraDetalle a insertar
     * @return Número de filas afectadas
     */
    public int insertarDetalle(CompraDetalle detalle) {
        int filas = 0;
        try {
            String sql = "{CALL sp_insertarDetalleCompra(?, ?, ?, ?, ?)}";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);

            cs.setInt(1, detalle.getId_compra());
            cs.setInt(2, detalle.getId_producto());
            cs.setInt(3, detalle.getCantidad());
            cs.setDouble(4, detalle.getPrecio_unitario());
            cs.registerOutParameter(5, java.sql.Types.INTEGER);

            filas = cs.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.cerrarConexion();
        }

        return filas;
    }
}
