package com.proyPetStore.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.proyPetStore.beans.Cita;
import com.proyPetStore.beans.Servicio;
import com.proyPetStore.model.CitaModel;

/**
 * Servlet implementation class CitaController
 */
@WebServlet("/CitaController")
public class CitaController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    CitaModel modelo = new CitaModel();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        if (op == null) {
            listar(request, response);
            return;
        }

        boolean esAjax = op.endsWith("Ajax");

        switch (op) {
            case "listar":
                listar(request, response);
                break;
            case "nuevo":
                cargarFormularioNuevo(request, response);
                break;
            case "editar":
                cargarFormularioEditar(request, response);
                break;
            case "insertar":
                insertar(request, response, esAjax);
                break;
            case "modificar":
                modificar(request, response, esAjax);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            default:
                listar(request, response);
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setAttribute("listarCita", modelo.listarCitas());
            request.getRequestDispatcher("/Cita/listarCita.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");
            request.setAttribute("listaMascotas", modelo.listarMascotas());
            request.setAttribute("listaServicios", modelo.listarServicios());
            request.getRequestDispatcher("/Cita/fragments/formNuevo.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(CitaController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");
            int id = Integer.parseInt(request.getParameter("id"));
            Cita c = modelo.obtenerCita(id);

            if (c != null) {
                request.setAttribute("cita", c);
                request.setAttribute("listaMascotas", modelo.listarMascotas());
                request.setAttribute("listaServicios", modelo.listarServicios());
                request.getRequestDispatcher("/Cita/fragments/formEditar.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/error404.jsp");
            }
        } catch (Exception e) {
            Logger.getLogger(CitaController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
        try {
            Cita c = new Cita();
            c.setId_mascota(Integer.parseInt(request.getParameter("id_mascota")));
            c.setId_servicio(Integer.parseInt(request.getParameter("id_servicio")));
            c.setFecha(Date.valueOf(request.getParameter("fecha")));
            c.setHora(request.getParameter("hora"));
            c.setEstado(request.getParameter("estado"));
            c.setObservacion(request.getParameter("observacion"));

            int resultado = modelo.insertarCita(c);

            if (esAjax) {
                enviarJSON(response, resultado > 0,
                        resultado > 0 ? "Cita registrada correctamente" : "Error al registrar cita");
            } else {
                request.getSession().setAttribute("mensaje",
                        resultado > 0 ? "Registro exitoso" : "Registro fallido");

              
                response.sendRedirect(request.getContextPath() + "/CitaController?op=listar");
            }

        } catch (Exception e) {
            e.printStackTrace();
            if (esAjax) enviarJSON(response, false, "Error: " + e.getMessage());
        }
    }
    private void modificar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
        try {
            Cita c = new Cita();
            c.setId_cita(Integer.parseInt(request.getParameter("id_cita")));
            c.setId_mascota(Integer.parseInt(request.getParameter("id_mascota")));
            c.setId_servicio(Integer.parseInt(request.getParameter("id_servicio")));
            c.setFecha(Date.valueOf(request.getParameter("fecha")));
            c.setHora(request.getParameter("hora"));
            c.setEstado(request.getParameter("estado"));
            c.setObservacion(request.getParameter("observacion"));

            int resultado = modelo.modificarCita(c);

            if (esAjax) {
                enviarJSON(response, resultado > 0,
                        resultado > 0 ? "Cita modificada correctamente" : "Error al modificar cita");
            } else {
                request.getSession().setAttribute("mensaje",
                        resultado > 0 ? "Modificación exitosa" : "Error al modificar");
                listar(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (esAjax) enviarJSON(response, false, "Error: " + e.getMessage());
        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response) {
        try {
        	response.setContentType("text/html; charset=UTF-8");
			int id = Integer.parseInt(request.getParameter("id"));

			int resultado = modelo.eliminarCita(id);
			String mensaje = resultado > 0 ? "cita eliminada exitosamente" : "Error al eliminar cita";
			request.getSession().setAttribute("mensaje", mensaje);

		} catch (Exception e) {
			Logger.getLogger(CitaController.class.getName()).log(Level.SEVERE, null, e);
			request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
		}
		listar(request, response);
    }

    private void enviarJSON(HttpServletResponse response, boolean success, String mensaje) {
		try {
			
			response.reset();
			
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Cache-Control", "no-cache");
			
			String mensajeLimpio = mensaje.replace("\"", "'").replace("\n", " ").replace("\r", " ");

			String json = "{\"success\":" + success + ",\"mensaje\":\"" + mensajeLimpio + "\"}";
			
			PrintWriter out = response.getWriter();
			out.write(json);
			out.flush();
			out.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
