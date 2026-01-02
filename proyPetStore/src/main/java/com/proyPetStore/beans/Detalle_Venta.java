package com.proyPetStore.beans;

public class Detalle_Venta {
	private Integer id_detalle;
	private Integer id_venta;
	private Integer id_producto; // null si es solo servicio
	private Integer id_servicio;// null si es solo producto
	private Integer cantidad;
	private Double precio;
	private Double subtotal;


	private String nombre_producto;
	private String nombre_servicio;

	public Detalle_Venta() {
	}

	public Detalle_Venta(Integer id_detalle, Integer id_venta, Integer id_producto, Integer id_servicio,
			Integer cantidad, Double precio, Double subtotal, String nombre_producto, String nombre_servicio) {
		this.id_detalle = id_detalle;
		this.id_venta = id_venta;
		this.id_producto = id_producto;
		this.id_servicio = id_servicio;
		this.cantidad = cantidad;
		this.precio = precio;
		this.subtotal = subtotal;
		this.nombre_producto = nombre_producto;
		this.nombre_servicio = nombre_servicio;
	}

	public Integer getId_detalle() {
		return id_detalle;
	}

	public void setId_detalle(Integer id_detalle) {
		this.id_detalle = id_detalle;
	}

	public Integer getId_venta() {
		return id_venta;
	}

	public void setId_venta(Integer id_venta) {
		this.id_venta = id_venta;
	}

	public Integer getId_producto() {
		return id_producto;
	}

	public void setId_producto(Integer id_producto) {
		this.id_producto = id_producto;
	}

	public Integer getId_servicio() {
		return id_servicio;
	}

	public void setId_servicio(Integer id_servicio) {
		this.id_servicio = id_servicio;
	}

	public Integer getCantidad() {
		return cantidad;
	}

	public void setCantidad(Integer cantidad) {
		this.cantidad = cantidad;
	}

	public Double getPrecio() {
		return precio;
	}

	public void setPrecio(Double precio) {
		this.precio = precio;
	}

	public Double getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(Double subtotal) {
		this.subtotal = subtotal;
	}

	public String getNombre_producto() {
		return nombre_producto;
	}

	public void setNombre_producto(String nombre_producto) {
		this.nombre_producto = nombre_producto;
	}

	public String getNombre_servicio() {
		return nombre_servicio;
	}

	public void setNombre_servicio(String nombre_servicio) {
		this.nombre_servicio = nombre_servicio;
	}

	
}
