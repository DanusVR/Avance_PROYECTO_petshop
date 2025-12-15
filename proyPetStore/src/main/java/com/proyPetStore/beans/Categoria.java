package com.proyPetStore.beans;

public class Categoria {
	private int id_categoria ;
	private String nombreCat;
	
	public Categoria() {
	}
	public Categoria(int id_categoria, String nombreCat) {
		this.id_categoria = id_categoria;
		this.nombreCat = nombreCat;
	}
	public int getId_categoria() {
		return id_categoria;
	}
	public void setId_categoria(int id_categoria) {
		this.id_categoria = id_categoria;
	}
	public String getNombreCat() {
		return nombreCat;
	}
	public void setNombreCat(String nombreCat) {
		this.nombreCat = nombreCat;
	}
	
	

}
