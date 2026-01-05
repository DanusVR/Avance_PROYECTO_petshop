package com.proyPetStore.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.ArrayList;
import java.util.List;

import com.proyPetStore.beans.Cliente;
import com.proyPetStore.beans.Detalle_Venta;
import com.proyPetStore.beans.Producto;
import com.proyPetStore.beans.Servicio;
import com.proyPetStore.beans.Venta;
import com.proyPetStore.model.ClienteModel;
import com.proyPetStore.model.DetalleVentaModel;
import com.proyPetStore.model.ProductoModel;
import com.proyPetStore.model.ServicioModel;
import com.proyPetStore.model.VentaModel;

/**
 * Servlet implementation class VentaController
 */
@WebServlet("/VentaController")
public class VentaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private List<Detalle_Venta> listaDetalle = new ArrayList<>();
	private VentaModel ventaModel = new VentaModel();
	private ProductoModel productoModel = new ProductoModel();
	private ServicioModel servicioModel = new ServicioModel();
	private ClienteModel clienteModel = new ClienteModel();

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String op = request.getParameter("op");
		if (op == null)
			op = "nuevo";

		switch (op) {
			case "nuevo":
				mostrarFormulario(request, response);
				break;
			case "agregar":
				agregarDetalle(request);
				mostrarFormulario(request, response);
				break;
			case "registrar":
				int idVenta = registrarVenta(request, response);
				if (idVenta > 0) {
					listaDetalle.clear();
					response.sendRedirect(request.getContextPath() + "/Venta/Recibo.jsp?idVenta=" + idVenta);
				} else {
					request.setAttribute("error", "No se pudo registrar la venta.");
					mostrarFormulario(request, response);
				}
				break;
			case "listar":
				listar(request, response);
				break;
			case "verRecibo":
				verRecibo(request, response);
				break;
			case "eliminar":
				eliminar(request, response);
				break;

			default:
				mostrarFormulario(request, response);
		}

	}

	private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("DEBUG: VentaController.mostrarFormulario called");
		request.setAttribute("clientes", clienteModel.listarClientes());
		request.setAttribute("productos", productoModel.listarProducto());
		request.setAttribute("servicios", servicioModel.listarServicios());
		request.setAttribute("detalle", listaDetalle);

		double total = listaDetalle.stream().mapToDouble(d -> d.getSubtotal() != null ? d.getSubtotal() : 0).sum();
		request.setAttribute("total", total);

		request.getRequestDispatcher("/Venta/NuevaVenta.jsp").forward(request, response);
	}

	private void agregarDetalle(HttpServletRequest request) {
		String tipo = request.getParameter("tipo");
		String error = null;
		Detalle_Venta dv = new Detalle_Venta();

		try {
			if ("producto".equals(tipo)) {
				int idProd = Integer.parseInt(request.getParameter("id_Producto"));
				int cant = Integer.parseInt(request.getParameter("cantidad"));
				Producto p = productoModel.obtenerProducto(idProd);

				if (p == null)
					error = "Producto no encontrado.";
				else if (p.getStock() < cant)
					error = "Stock insuficiente.";
				else {
					dv.setId_producto(idProd);
					dv.setNombre_producto(p.getNombre());
					dv.setCantidad(cant);
					dv.setPrecio(p.getPrecio_venta());
					dv.setSubtotal(cant * p.getPrecio_venta());
					listaDetalle.add(dv);
				}

			} else if ("servicio".equals(tipo)) {
				int idServ = Integer.parseInt(request.getParameter("id_Servicio"));
				Servicio s = servicioModel.obtenerServicio(idServ);

				if (s == null)
					error = "Servicio no encontrado.";
				else {
					dv.setId_servicio(idServ);
					dv.setNombre_servicio(s.getNombre());
					dv.setCantidad(1);
					dv.setPrecio(s.getPrecio());
					dv.setSubtotal(s.getPrecio());
					listaDetalle.add(dv);
				}
			} else {
				error = "Tipo inválido.";
			}
		} catch (Exception e) {
			error = "Datos inválidos.";
		}

		if (error != null)
			request.setAttribute("error", error);
	}

	private int registrarVenta(HttpServletRequest request, HttpServletResponse response) {
		if (listaDetalle.isEmpty())
			return -1;

		try {
			String idClienteStr = request.getParameter("id_Cliente");
			if (idClienteStr == null || idClienteStr.isEmpty())
				return -1;

			Venta venta = new Venta();
			venta.setId_cliente(Integer.parseInt(idClienteStr));
			venta.setIdusuario(1);
			venta.setTipo_pago(request.getParameter("tipo_pago"));

			String montoStr = request.getParameter("monto_pagado");
			venta.setMonto_pagado(montoStr != null && !montoStr.isEmpty() ? Double.parseDouble(montoStr) : 0.0);

			double total = listaDetalle.stream().mapToDouble(d -> d.getSubtotal() != null ? d.getSubtotal() : 0).sum();
			venta.setTotal(total);

			int idVenta = ventaModel.insertarVenta(venta);
			if (idVenta <= 0)
				return -1;

			for (Detalle_Venta d : listaDetalle) {
				d.setId_venta(idVenta);
				if (d.getId_producto() != null && d.getId_producto() > 0) {
					ventaModel.descontarStock(d.getId_producto(), d.getCantidad());
				}
			}

			new DetalleVentaModel().insertarListaDetalles(listaDetalle);

			return idVenta;

		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	private void listar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");

			List<Venta> listaVentas = ventaModel.listarVentas();
			request.setAttribute("listarVentas", listaVentas);

			request.getRequestDispatcher("/Venta/listarVentas.jsp")
					.forward(request, response);

		} catch (Exception e) {
			Logger.getLogger(VentaController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	private void verRecibo(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			int idRecibo = Integer.parseInt(request.getParameter("idVenta"));

			Venta ventaRecibo = ventaModel.obtenerVentaporId(idRecibo);
			List<Detalle_Venta> detallesRecibo = new DetalleVentaModel().listarPorVentaporid(idRecibo);

			request.setAttribute("venta", ventaRecibo);
			request.setAttribute("detalles", detallesRecibo);

			request.getRequestDispatcher("/Venta/Recibo.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void eliminar(HttpServletRequest request, HttpServletResponse response) {
		try {
			int idVenta = Integer.parseInt(request.getParameter("id"));
			ventaModel.eliminarVenta(idVenta);
		} catch (Exception e) {
			Logger.getLogger(VentaController.class.getName()).log(Level.SEVERE, null, e);
		}
		listar(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

}
