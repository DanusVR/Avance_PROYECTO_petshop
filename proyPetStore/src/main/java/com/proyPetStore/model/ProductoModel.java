package com.proyPetStore.model;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Categoria;
import com.proyPetStore.beans.Mascota;
import com.proyPetStore.beans.Producto;
import com.proyPetStore.util.Conexion;

public class ProductoModel extends Conexion {
	CallableStatement cs;
	ResultSet rs;

	// LISTAR
	public List<Producto> listarProducto() {
		List<Producto> lista = new ArrayList<>();
		try {
			String sql = "CALL sp_listarProducto()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();

			while (rs.next()) {
				Producto p = new Producto();
				p.setId_producto(rs.getInt("id_producto"));
				p.setNombre(rs.getString("nombre"));
				p.setNombreCat(rs.getString("categoria"));
				p.setDescripcion(rs.getString("descripcion"));
				p.setStock(rs.getInt("stock"));
				p.setPrecio_costo(rs.getDouble("precio_costo"));
				p.setPrecio_venta(rs.getDouble("precio_venta"));
				p.setEstado(rs.getString("estado"));
				p.setFecha_registro(rs.getDate("fecha_registro"));

				lista.add(p);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cerrarConexion();
		}
		return lista;
	}

	// OBTENER POR ID
	public Producto obtenerProducto(int idproducto) {
		Producto p = null;
		try {
			String sql = "CALL sp_obtenerProducto(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idproducto);
			rs = cs.executeQuery();

			if (rs.next()) {
				p = new Producto();
				p.setId_producto(rs.getInt("id_producto"));
				p.setNombre(rs.getString("nombre"));
				p.setNombreCat(rs.getString("categoria"));
				p.setDescripcion(rs.getString("descripcion"));
				p.setStock(rs.getInt("stock"));
				p.setPrecio_costo(rs.getDouble("precio_costo"));
				p.setPrecio_venta(rs.getDouble("precio_venta"));
				p.setId_categoria(rs.getInt("id_categoria"));
				p.setEstado(rs.getString("estado"));
				p.setFecha_registro(rs.getDate("fecha_registro"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}
		return p;
	}

	public double obtenerPrecio(int idProducto) {
		Producto prod = obtenerProducto(idProducto);
		return (prod != null) ? prod.getPrecio_venta() : 0;
	}

	// INSERTAR
	public int insertarProducto(Producto p) throws SQLException {
		int filas = 0;
		try {
			String sql = "CALL sp_insertarProducto(?,?,?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);

			cs.setString(1, p.getNombre());
			cs.setInt(2, p.getId_categoria());
			cs.setString(3, p.getDescripcion());
			cs.setInt(4, p.getStock());
			cs.setDouble(5, p.getPrecio_costo());
			cs.setDouble(6, p.getPrecio_venta());

			filas = cs.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cerrarConexion();
		}
		return filas;
	}

	// MODIFICAR
	public int modificarProducto(Producto p) throws SQLException {
		int filas = 0;
		try {
			String sql = "CALL sp_modificarProducto(?,?,?,?,?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);

			cs.setInt(1, p.getId_producto());
			cs.setString(2, p.getNombre());
			cs.setInt(3, p.getId_categoria());
			cs.setString(4, p.getDescripcion());
			cs.setInt(5, p.getStock());
			cs.setDouble(6, p.getPrecio_costo());
			cs.setDouble(7, p.getPrecio_venta());
			cs.setString(8, p.getEstado());

			filas = cs.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			this.cerrarConexion();
		}
		return filas;
	}

	// ELIMINAR
	public int eliminarProducto(int idproducto) {
		int filas = 0;
		try {
			String sql = "CALL sp_eliminarProducto(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idproducto);
			filas = cs.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cerrarConexion();
		}
		return filas;
	}

	// LISTAR CATEGORIA
	public List<Categoria> listarCategoria() {
		List<Categoria> lista = new ArrayList<>();
		try {
			String sql = "CALL sp_listarCategoria()";
			abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();

			while (rs.next()) {
				Categoria c = new Categoria();
				c.setId_categoria(rs.getInt("id_categoria"));
				c.setNombreCat(rs.getString("nombreCat"));
				lista.add(c);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cerrarConexion();
		}
		return lista;
	}
}
