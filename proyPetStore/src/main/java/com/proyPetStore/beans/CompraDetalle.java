package com.proyPetStore.beans;

public class CompraDetalle {
	private int id_compra_detalle;
	private int id_compra;
	private int id_producto;
	private String nombreProducto;
	private int cantidad;
	private double precio_unitario;
	private double subtotal;
	
	public CompraDetalle() {
	}

	public CompraDetalle(int id_compra_detalle, int id_compra, int id_producto, String nombreProducto, int cantidad,
			double precio_unitario, double subtotal) {
		this.id_compra_detalle = id_compra_detalle;
		this.id_compra = id_compra;
		this.id_producto = id_producto;
		this.nombreProducto = nombreProducto;
		this.cantidad = cantidad;
		this.precio_unitario = precio_unitario;
		this.subtotal = subtotal;
	}

	public int getId_compra_detalle() {
		return id_compra_detalle;
	}

	public void setId_compra_detalle(int id_compra_detalle) {
		this.id_compra_detalle = id_compra_detalle;
	}

	public int getId_compra() {
		return id_compra;
	}

	public void setId_compra(int id_compra) {
		this.id_compra = id_compra;
	}

	public int getId_producto() {
		return id_producto;
	}

	public void setId_producto(int id_producto) {
		this.id_producto = id_producto;
	}

	public String getNombreProducto() {
		return nombreProducto;
	}

	public void setNombreProducto(String nombreProducto) {
		this.nombreProducto = nombreProducto;
	}

	public int getCantidad() {
		return cantidad;
	}

	public void setCantidad(int cantidad) {
		this.cantidad = cantidad;
	}

	public double getPrecio_unitario() {
		return precio_unitario;
	}

	public void setPrecio_unitario(double precio_unitario) {
		this.precio_unitario = precio_unitario;
	}

	public double getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(double subtotal) {
		this.subtotal = subtotal;
	}
}
