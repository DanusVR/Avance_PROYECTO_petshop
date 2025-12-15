package com.proyPetStore.beans;

import java.sql.Date;


public class Cita {
	    private int id_cita;
	    private int id_mascota;
	    private int id_servicio;
	    private Date fecha;
	    private String hora;
	    private String estado;
	    private String observacion;
	    
	    private String mascota;  // nombre
	    private String servicio; // nombre
	    private String tipo_servicio;
	   

		
		public Cita() {
		}
		public Cita(int id_cita, int id_mascota, int id_servicio, Date fecha, String hora, String estado,
				String observacion, String mascota, String servicio) {
			this.id_cita = id_cita;
			this.id_mascota = id_mascota;
			this.id_servicio = id_servicio;
			this.fecha = fecha;
			this.hora = hora;
			this.estado = estado;
			this.observacion = observacion;
			this.mascota = mascota;
			this.servicio = servicio;
		}
		public int getId_cita() {
			return id_cita;
		}
		public void setId_cita(int id_cita) {
			this.id_cita = id_cita;
		}
		public int getId_mascota() {
			return id_mascota;
		}
		public void setId_mascota(int id_mascota) {
			this.id_mascota = id_mascota;
		}
		public int getId_servicio() {
			return id_servicio;
		}
		public void setId_servicio(int id_servicio) {
			this.id_servicio = id_servicio;
		}
		public Date getFecha() {
			return fecha;
		}
		public void setFecha(Date fecha) {
			this.fecha = fecha;
		}
		public String getHora() {
			return hora;
		}
		public void setHora(String hora) {
			this.hora = hora;
		}
		public String getEstado() {
			return estado;
		}
		public void setEstado(String estado) {
			this.estado = estado;
		}
		public String getObservacion() {
			return observacion;
		}
		public void setObservacion(String observacion) {
			this.observacion = observacion;
		}
		public String getMascota() {
			return mascota;
		}
		public void setMascota(String mascota) {
			this.mascota = mascota;
		}
		public String getServicio() {
			return servicio;
		}
		public void setServicio(String servicio) {
			this.servicio = servicio;
		}
		public String getTipo_servicio() {
			return tipo_servicio;
		}
		public void setTipo_servicio(String tipo_servicio) {
			this.tipo_servicio = tipo_servicio;
		}
	
		
}
