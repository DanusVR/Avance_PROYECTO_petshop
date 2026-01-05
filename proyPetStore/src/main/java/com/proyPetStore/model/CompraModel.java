package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.CompraDetalle;
import com.proyPetStore.beans.Compras;
import com.proyPetStore.util.Conexion;

public class CompraModel extends Conexion {
	CallableStatement cs;
	ResultSet rs;
	CompraDetalleModel detalleModel = new CompraDetalleModel();

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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}
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
			if (c != null)
				c.setDetalles(detalles);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cerrarConexion();
		}
		return c;
	}

	// Insertar compra con detalle y actualizar stock
	public int insertarCompra(Compras compra) {
		int filas = 0;

		try {
			this.abrirConexion();
			this.conexion.setAutoCommit(false);

			// Insertar la compra
			String sqlCompra = "{CALL sp_insertarCompra(?, ?, ?, ?)}";
			cs = conexion.prepareCall(sqlCompra);
			cs.setInt(1, compra.getId_proveedor());
			cs.setDouble(2, compra.getTotal());
			cs.setString(3, "activo");
			cs.registerOutParameter(4, java.sql.Types.INTEGER);
			cs.executeUpdate();

			int idCompraGenerada = cs.getInt(4);

			// Insertar cada detalle y actualizar stock usando CompraDetalleModel
			// Asignar el id_compra generado a cada detalle
			for (CompraDetalle d : compra.getDetalles()) {
				d.setId_compra(idCompraGenerada);
			}

			detalleModel.insertarListaDetallesConConexion(compra.getDetalles(), this.conexion);

			this.conexion.commit(); // Confirmar transaccion
			filas = 1;

		} catch (Exception e) {
			try {
				if (this.conexion != null)
					this.conexion.rollback(); // Revertir cambios en error
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}

		return filas;
	}

	// Eliminar
	public int eliminarCompra(int idCompra) {
		int filas = 0;
		// 1. Obtener detalles para revertir stock (antes de abrir nueva tx)
		List<CompraDetalle> detalles = detalleModel.listarPorCompra(idCompra);

		java.sql.PreparedStatement ps = null;

		try {
			this.abrirConexion();
			this.conexion.setAutoCommit(false);

			// 2. Descontar Stock (Revertir la compra)
			String sqlStock = "UPDATE producto SET stock = stock - ? WHERE id_producto = ?";
			ps = conexion.prepareStatement(sqlStock);

			for (CompraDetalle d : detalles) {
				ps.setInt(1, d.getCantidad());
				ps.setInt(2, d.getId_producto());
				ps.executeUpdate();
			}
			ps.close();

			// 3. Cambiar estado a 'anulado'
			String sqlAnular = "UPDATE compra SET estado = 'anulado' WHERE id_compra = ?";
			ps = conexion.prepareStatement(sqlAnular);
			ps.setInt(1, idCompra);

			filas = ps.executeUpdate();

			this.conexion.commit();

		} catch (Exception e) {
			try {
				if (this.conexion != null)
					this.conexion.rollback();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (Exception ex) {
			}
			this.cerrarConexion();
		}

		return filas;
	}

}
