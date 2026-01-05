package com.proyPetStore.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.proyPetStore.beans.Venta;
import com.proyPetStore.model.ReporteModel;

@WebServlet("/ReporteController")
public class ReporteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    ReporteModel modelo = new ReporteModel();

    public ReporteController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
        if (op == null)
            op = "listar";

        switch (op) {
            case "listar":
                mostrarPantallaReporte(request, response);
                break;
            case "filtrar":
                filtrarReporte(request, response);
                break;
            default:
                mostrarPantallaReporte(request, response);
                break;
        }
    }

    private void mostrarPantallaReporte(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Initially show no data or maybe current month?
        // For now, clean slate.
        request.getRequestDispatcher("/Reporte/reporteVentas.jsp").forward(request, response);
    }

    private void filtrarReporte(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fechaInicio = request.getParameter("fechaInicio");
        String fechaFin = request.getParameter("fechaFin");

        if (fechaInicio != null && !fechaInicio.isEmpty() && fechaFin != null && !fechaFin.isEmpty()) {
            // Append times if necessary, but "BETWEEN '2023-01-01' AND '2023-01-01'" only
            // covers 00:00:00.
            // Ideally, we want end of day for the end date.
            // Simple fix: Append " 23:59:59" to fechaFin if it's just a date string.
            // Assuming input type="date" returns YYYY-MM-DD

            String fechaFinQuery = fechaFin + " 23:59:59";
            String fechaInicioQuery = fechaInicio + " 00:00:00";

            List<Venta> lista = modelo.filtrarVentas(fechaInicioQuery, fechaFinQuery);
            request.setAttribute("listaVentas", lista);
            request.setAttribute("fechaInicio", fechaInicio);
            request.setAttribute("fechaFin", fechaFin);
        } else {
            request.setAttribute("error", "Seleccione ambas fechas");
        }

        request.getRequestDispatcher("/Reporte/reporteVentas.jsp").forward(request, response);
    }
}
