package com.proyPetStore.beans;

public class Cliente {
	

	  private int id_cliente; 
	  private String dni ;
	  private String nombreC;
	  private String apellido;	
	  private String telefono;
	  private String direccion ;
	 	  	  
	  public Cliente() {}

	  public Cliente(int id_cliente, String dni, String nombreC, String apellido, String telefono, String direccion) {
		this.id_cliente = id_cliente;
		this.dni = dni;
		this.nombreC = nombreC;
		this.apellido = apellido;
		this.telefono = telefono;
		this.direccion = direccion;
	  }

	  public int getId_cliente() {
		  return id_cliente;
	  }

	  public void setId_cliente(int id_cliente) {
		  this.id_cliente = id_cliente;
	  }

	  public String getDni() {
		  return dni;
	  }

	  public void setDni(String dni) {
		  this.dni = dni;
	  }

	  public String getNombreC() {
		  return nombreC;
	  }

	  public void setNombreC(String nombreC) {
		  this.nombreC = nombreC;
	  }

	  public String getApellido() {
		  return apellido;
	  }

	  public void setApellido(String apellido) {
		  this.apellido = apellido;
	  }

	  public String getTelefono() {
		  return telefono;
	  }

	  public void setTelefono(String telefono) {
		  this.telefono = telefono;
	  }

	  public String getDireccion() {
		  return direccion;
	  }

	  public void setDireccion(String direccion) {
		  this.direccion = direccion;
	  }

	 

	
}
