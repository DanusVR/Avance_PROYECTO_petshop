package com.proyPetStore.beans;

import java.sql.Date;

public class Producto {
	
		 private int id_producto;
		 private String nombre ;
		 private int  id_categoria;
		 private String descripcion; 		 
		 private int  stock;
		 private double  precio_costo;
		 private double  precio_venta;
		 private String estado;
		 private Date fecha_registro;
		 
		//nombre de la categoria
		 private String nombreCat;
		 
		public Producto() {
		}

		public Producto(int id_producto, String nombre, int id_categoria, String descripcion, int stock,
				double precio_costo, double precio_venta, String estado, Date fecha_registro, String nombreCat) {
			this.id_producto = id_producto;
			this.nombre = nombre;
			this.id_categoria = id_categoria;
			this.descripcion = descripcion;
			this.stock = stock;
			this.precio_costo = precio_costo;
			this.precio_venta = precio_venta;
			this.estado = estado;
			this.fecha_registro = fecha_registro;
			this.nombreCat = nombreCat;
		}

		public int getId_producto() {
			return id_producto;
		}

		public void setId_producto(int id_producto) {
			this.id_producto = id_producto;
		}

		public String getNombre() {
			return nombre;
		}

		public void setNombre(String nombre) {
			this.nombre = nombre;
		}

		public int getId_categoria() {
			return id_categoria;
		}

		public void setId_categoria(int id_categoria) {
			this.id_categoria = id_categoria;
		}

		public String getDescripcion() {
			return descripcion;
		}

		public void setDescripcion(String descripcion) {
			this.descripcion = descripcion;
		}

		public int getStock() {
			return stock;
		}

		public void setStock(int stock) {
			this.stock = stock;
		}

		public double getPrecio_costo() {
			return precio_costo;
		}

		public void setPrecio_costo(double precio_costo) {
			this.precio_costo = precio_costo;
		}

		public double getPrecio_venta() {
			return precio_venta;
		}

		public void setPrecio_venta(double precio_venta) {
			this.precio_venta = precio_venta;
		}

		public String getEstado() {
			return estado;
		}

		public void setEstado(String estado) {
			this.estado = estado;
		}

		public Date getFecha_registro() {
			return fecha_registro;
		}

		public void setFecha_registro(Date fecha_registro) {
			this.fecha_registro = fecha_registro;
		}

		public String getNombreCat() {
			return nombreCat;
		}

		public void setNombreCat(String nombreCat) {
			this.nombreCat = nombreCat;
		}
		
		
	
		
		 		
}
