package com.proyPetStore.beans;

import java.sql.Date;
import java.util.List;

public class Compras {

	private int id_compra;
	private int id_proveedor;
	private String nombreProveedor;
	private Date fecha_compra;
	private double total;
	private String estado;

	// lista de los productos comprados
	private List<CompraDetalle> detalles;

	public Compras() {
		this.detalles = new java.util.ArrayList<>();
	}

	public Compras(int id_compra, int id_proveedor, String nombreProveedor, Date fecha_compra, double total,
			String estado, List<CompraDetalle> detalles) {
		this.id_compra = id_compra;
		this.id_proveedor = id_proveedor;
		this.nombreProveedor = nombreProveedor;
		this.fecha_compra = fecha_compra;
		this.total = total;
		this.estado = estado;
		this.detalles = detalles;
	}

	public int getId_compra() {
		return id_compra;
	}

	public void setId_compra(int id_compra) {
		this.id_compra = id_compra;
	}

	public int getId_proveedor() {
		return id_proveedor;
	}

	public void setId_proveedor(int id_proveedor) {
		this.id_proveedor = id_proveedor;
	}

	public String getNombreProveedor() {
		return nombreProveedor;
	}

	public void setNombreProveedor(String nombreProveedor) {
		this.nombreProveedor = nombreProveedor;
	}

	public Date getFecha_compra() {
		return fecha_compra;
	}

	public void setFecha_compra(Date fecha_compra) {
		this.fecha_compra = fecha_compra;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public List<CompraDetalle> getDetalles() {
		return detalles;
	}

	public void setDetalles(List<CompraDetalle> detalles) {
		this.detalles = detalles;
	}

}
