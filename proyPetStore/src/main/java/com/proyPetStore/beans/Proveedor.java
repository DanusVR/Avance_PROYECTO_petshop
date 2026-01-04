package com.proyPetStore.beans;

import java.sql.Timestamp;

public class Proveedor {
	   private int idProveedor;
	    private String nombre;
	    private String ruc;
	    private String telefono;
	    private String correo;
	    private String direccion;
	    private String tipo;
	    private Timestamp fechaRegistro;
	    private String estado;
	    	       
		public Proveedor() {
		}
		
		public Proveedor(int idProveedor, String nombre, String ruc, String telefono, String correo, String direccion,
				String tipo, Timestamp fechaRegistro, String estado) {
			this.idProveedor = idProveedor;
			this.nombre = nombre;
			this.ruc = ruc;
			this.telefono = telefono;
			this.correo = correo;
			this.direccion = direccion;
			this.tipo = tipo;
			this.fechaRegistro = fechaRegistro;
			this.estado = estado;
		}

		public int getIdProveedor() {
			return idProveedor;
		}

		public void setIdProveedor(int idProveedor) {
			this.idProveedor = idProveedor;
		}

		public String getNombre() {
			return nombre;
		}

		public void setNombre(String nombre) {
			this.nombre = nombre;
		}

		public String getRuc() {
			return ruc;
		}

		public void setRuc(String ruc) {
			this.ruc = ruc;
		}

		public String getTelefono() {
			return telefono;
		}

		public void setTelefono(String telefono) {
			this.telefono = telefono;
		}

		public String getCorreo() {
			return correo;
		}

		public void setCorreo(String correo) {
			this.correo = correo;
		}

		public String getDireccion() {
			return direccion;
		}

		public void setDireccion(String direccion) {
			this.direccion = direccion;
		}

		public String getTipo() {
			return tipo;
		}

		public void setTipo(String tipo) {
			this.tipo = tipo;
		}

		public Timestamp getFechaRegistro() {
			return fechaRegistro;
		}

		public void setFechaRegistro(Timestamp fechaRegistro) {
			this.fechaRegistro = fechaRegistro;
		}

		public String getEstado() {
			return estado;
		}

		public void setEstado(String estado) {
			this.estado = estado;
		}    
		
	    
}
