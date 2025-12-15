package com.proyPetStore.beans;

public class Mascota {
	
	   
	   private int id_mascota;
	    private int id_cliente;
	    private String nombre_mascota;
	    private String especie;
	    private String raza;
	    private String sexo;
	    private int edad;

	    private String nombre; //Nombre del cliente

	    public Mascota() {}

		public Mascota(int id_mascota, int id_cliente, String nombre_mascota, String especie, String raza, String sexo,
				int edad, String nombre) {
			this.id_mascota = id_mascota;
			this.id_cliente = id_cliente;
			this.nombre_mascota = nombre_mascota;
			this.especie = especie;
			this.raza = raza;
			this.sexo = sexo;
			this.edad = edad;
			this.nombre = nombre;
		}

		public int getId_mascota() {
			return id_mascota;
		}

		public void setId_mascota(int id_mascota) {
			this.id_mascota = id_mascota;
		}

		public int getId_cliente() {
			return id_cliente;
		}

		public void setId_cliente(int id_cliente) {
			this.id_cliente = id_cliente;
		}

		public String getNombre_mascota() {
			return nombre_mascota;
		}

		public void setNombre_mascota(String nombre_mascota) {
			this.nombre_mascota = nombre_mascota;
		}

		public String getEspecie() {
			return especie;
		}

		public void setEspecie(String especie) {
			this.especie = especie;
		}

		public String getRaza() {
			return raza;
		}

		public void setRaza(String raza) {
			this.raza = raza;
		}

		public String getSexo() {
			return sexo;
		}

		public void setSexo(String sexo) {
			this.sexo = sexo;
		}

		public int getEdad() {
			return edad;
		}

		public void setEdad(int edad) {
			this.edad = edad;
		}

		public String getNombre() {
			return nombre;
		}

		public void setNombre(String nombre) {
			this.nombre = nombre;
		}

		


	    
}
