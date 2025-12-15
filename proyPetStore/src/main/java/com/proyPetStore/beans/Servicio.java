package com.proyPetStore.beans;

public class Servicio {
	
	private int id_servicio;
	private String nombre ;
	private String tipo; 
	private int id_mascota;
	private String descripcion;
	private double precio ;
	private String estado;
	
	private String nombreMascota;
	
	public Servicio() {
	}

	public Servicio(int id_servicio, String nombre, String tipo, int id_mascota, String descripcion, double precio,
			String estado, String nombreMascota) {
		this.id_servicio = id_servicio;
		this.nombre = nombre;
		this.tipo = tipo;
		this.id_mascota = id_mascota;
		this.descripcion = descripcion;
		this.precio = precio;
		this.estado = estado;
		this.nombreMascota = nombreMascota;
	}

	public int getId_servicio() {
		return id_servicio;
	}

	public void setId_servicio(int id_servicio) {
		this.id_servicio = id_servicio;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public int getId_mascota() {
		return id_mascota;
	}

	public void setId_mascota(int id_mascota) {
		this.id_mascota = id_mascota;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public double getPrecio() {
		return precio;
	}

	public void setPrecio(double precio) {
		this.precio = precio;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getNombreMascota() {
		return nombreMascota;
	}

	public void setNombreMascota(String nombreMascota) {
		this.nombreMascota = nombreMascota;
	}
	
	

	
	
}
