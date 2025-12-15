package com.proyPetStore.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.proyPetStore.beans.Cliente;
import com.proyPetStore.beans.Historial_Medico;
import com.proyPetStore.beans.Servicio;
import com.proyPetStore.model.HistorialMedicoModel;
import com.proyPetStore.model.MascotaModel;
import com.proyPetStore.model.ServicioModel;

/**
 * Servlet implementation class ServiciosController
 */
@WebServlet("/ServicioController")
public class ServicioController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    ServicioModel modelo = new ServicioModel();
    MascotaModel mascotaModel = new MascotaModel(); // Para cargar mascotas en los formularios

    public ServicioController() {
        super();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String opc = request.getParameter("op");
        if (opc == null) {
            listar(request, response);
            return;
        }

        boolean esAjax = opc.endsWith("Ajax");

        switch (opc) {
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
            break;
        }
    }

    // LISTAR
  
    private void listar(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");
            request.setAttribute("listarServicio", modelo.listarServicios());
            request.getRequestDispatcher("/Servicio/listarServicio.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // FORM NUEVO

    private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");

            // Se carga listado de mascotas
            request.setAttribute("listaMascotas", mascotaModel.listarMascota());

            String jsp = "/Servicio/fragments/formNuevo.jsp";
            request.getRequestDispatcher(jsp).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // FORM EDITAR

    private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");

            int id = Integer.parseInt(request.getParameter("id"));
            Servicio s = modelo.obtenerServicio(id);

           
            request.setAttribute("listaMascotas", mascotaModel.listarMascota());

            request.setAttribute("servicio", s);
            String jsp = "/Servicio/fragments/formEditar.jsp";
            request.getRequestDispatcher(jsp).forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    // INSERTAR

    private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
        try {
            Servicio s = new Servicio();

            s.setNombre(request.getParameter("nombre"));
            s.setTipo(request.getParameter("tipo"));
            s.setId_mascota(Integer.parseInt(request.getParameter("id_mascota"))); // <-- FALTA EN TU CÓDIGO
            s.setDescripcion(request.getParameter("descripcion"));
            s.setPrecio(Double.parseDouble(request.getParameter("precio")));
            s.setEstado(request.getParameter("estado"));

            int resultado = modelo.insertarServicio(s);
            
            // --- NUEVO: generar historial automático ---
            if (resultado > 0) {
                Historial_Medico hm = new Historial_Medico();
                hm.setId_mascota(s.getId_mascota());
                hm.setFecha(new java.sql.Date(System.currentTimeMillis())); // Fecha actual o puedes usar otra
                hm.setDescripcion("Servicio: " + s.getNombre() +
                                  (s.getDescripcion() != null ? " - " + s.getDescripcion() : ""));
                HistorialMedicoModel historialModel = new HistorialMedicoModel();
                historialModel.insertar(hm);
            }
            // -------------------------------------------

            if (esAjax) {
                enviarJSON(response, resultado > 0,
                        resultado > 0 ? "Servicio registrado exitosamente" : "Error al registrar");
                return;
            }

            request.getSession().setAttribute("mensaje",
                    resultado > 0 ? "Registro exitoso" : "Registro fallido");
            listar(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            if (esAjax) {
                enviarJSON(response, false, "Error: " + e.getMessage());
            } else {
                request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
                listar(request, response);
            }
        }
    }
    // MODIFICAR
  
    private void modificar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
        try {
            Servicio s = new Servicio();

            s.setId_servicio(Integer.parseInt(request.getParameter("id_servicio")));
            s.setNombre(request.getParameter("nombre"));
            s.setTipo(request.getParameter("tipo"));
            s.setId_mascota(Integer.parseInt(request.getParameter("id_mascota")));  // <-- IMPORTANTE
            s.setDescripcion(request.getParameter("descripcion"));
            s.setPrecio(Double.parseDouble(request.getParameter("precio")));
            s.setEstado(request.getParameter("estado"));

            int resultado = modelo.modificarServicio(s);

            if (esAjax) {
                enviarJSON(response, resultado > 0,
                        resultado > 0 ? "Servicio modificado exitosamente" : "Error al modificar");
                return;
            }

            request.getSession().setAttribute("mensaje",
                    resultado > 0 ? "Modificación exitosa" : "Modificación fallida");
            listar(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            if (esAjax) {
                enviarJSON(response, false, "Error: " + e.getMessage());
            } else {
                request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
                listar(request, response);
            }
        }
    }

    // ELIMINAR

    private void eliminar(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int resultado = modelo.eliminarServicio(id);

            request.getSession().setAttribute("mensaje",
                    resultado > 0 ? "Servicio eliminado exitosamente" : "Error al eliminar servicio");

        } catch (Exception e) {
            e.printStackTrace();
        }
        listar(request, response);
    }


    // JSON RESPONSE

    private void enviarJSON(HttpServletResponse response, boolean success, String mensaje) {
        try {
            response.reset();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            mensaje = mensaje.replace("\"", "'");

            String json = "{\"success\":" + success + ",\"mensaje\":\"" + mensaje + "\"}";

            response.getWriter().write(json);
        } catch (Exception e) {
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
