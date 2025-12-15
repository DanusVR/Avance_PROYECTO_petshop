package com.proyPetStore.beans;

import java.sql.Date;

public class Venta {

    private int id_venta;
    private int id_cliente;
    private int idusuario;
    private Date fecha;
    private double total;

    // 🔹 Nuevos campos para pago
    private String tipo_pago;
    private double monto_pagado;

   
    private String nombreCliente;
    private String nombreUsuario;

    public Venta() {
    }

    public Venta(int id_venta, int id_cliente, int idusuario, Date fecha, double total,
                 String tipo_pago, double monto_pagado,
                 String nombreCliente, String nombreUsuario) {
        this.id_venta = id_venta;
        this.id_cliente = id_cliente;
        this.idusuario = idusuario;
        this.fecha = fecha;
        this.total = total;
        this.tipo_pago = tipo_pago;
        this.monto_pagado = monto_pagado;
        this.nombreCliente = nombreCliente;
        this.nombreUsuario = nombreUsuario;
    }

    public int getId_venta() {
        return id_venta;
    }

    public void setId_venta(int id_venta) {
        this.id_venta = id_venta;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public int getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(int idusuario) {
        this.idusuario = idusuario;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getTipo_pago() {
        return tipo_pago;
    }

    public void setTipo_pago(String tipo_pago) {
        this.tipo_pago = tipo_pago;
    }

    public double getMonto_pagado() {
        return monto_pagado;
    }

    public void setMonto_pagado(double monto_pagado) {
        this.monto_pagado = monto_pagado;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }


}
