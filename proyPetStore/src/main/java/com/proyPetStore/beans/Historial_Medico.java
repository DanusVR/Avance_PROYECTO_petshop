package com.proyPetStore.beans;

import java.sql.Date;

public class Historial_Medico {
	private int id_historial ;
    private int id_mascota;
    private Date fecha;
    private String descripcion ;
    
    private String nombreMascota;
       

	public Historial_Medico() {
	}

	public Historial_Medico(int id_historial, int id_mascota, Date fecha, String descripcion, String nombreMascota) {
		this.id_historial = id_historial;
		this.id_mascota = id_mascota;
		this.fecha = fecha;
		this.descripcion = descripcion;
		this.nombreMascota = nombreMascota;
	}

	public int getId_historial() {
		return id_historial;
	}

	public void setId_historial(int id_historial) {
		this.id_historial = id_historial;
	}

	public int getId_mascota() {
		return id_mascota;
	}

	public void setId_mascota(int id_mascota) {
		this.id_mascota = id_mascota;
	}

	public Date getFecha() {
		return fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getNombreMascota() {
		return nombreMascota;
	}

	public void setNombreMascota(String nombreMascota) {
		this.nombreMascota = nombreMascota;
	}
	
    
    
    
}
