package com.proyPetStore.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.proyPetStore.beans.Historial_Medico;
import com.proyPetStore.beans.Mascota;
import com.proyPetStore.beans.Servicio;
import com.proyPetStore.model.HistorialMedicoModel;
import com.proyPetStore.model.MascotaModel;
import com.proyPetStore.model.ServicioModel;

/**
 * Servlet implementation class HistorialMedicoController
 */
@WebServlet("/HistorialMedicoController")
public class HistorialMedicoController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    HistorialMedicoModel model = new HistorialMedicoModel();
    MascotaModel modelMascota = new MascotaModel();
    ServicioModel modelServicio = new ServicioModel(); 

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
            case "listarPorMascota":
                listarPorMascota(request, response);
                break;
            default:
                listar(request, response);
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            response.setContentType("text/html; charset=UTF-8");
            System.out.println("Entrando a listar Historial...");
            request.setAttribute("listaHistorial", model.listar());
            request.getRequestDispatcher("/Historial/listarHistorial.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(HistorialMedicoController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html; charset=UTF-8");

            // Cargar todas las mascotas para el combo
            List<Mascota> listaMascotas = modelMascota.listarMascota();
            request.setAttribute("listaMascotas", listaMascotas);

            // Si viene id_servicio, precargar la descripción y seleccionar la mascota
            String paramIdServicio = request.getParameter("id_servicio");
            if (paramIdServicio != null) {
                int idServicio = Integer.parseInt(paramIdServicio);
                Servicio s = modelServicio.obtenerServicio(idServicio);
                request.setAttribute("descripcionServicio", "Servicio: " + s.getNombre() + " - " + s.getDescripcion());
                request.setAttribute("idMascotaSeleccionada", s.getId_mascota()); // Para seleccionar en el combo
            }

            // Si viene solo id_mascota, también podemos seleccionarla en el combo
            String paramIdMascota = request.getParameter("id_mascota");
            if (paramIdMascota != null) {
                request.setAttribute("idMascotaSeleccionada", Integer.parseInt(paramIdMascota));
            }

            request.getRequestDispatcher("/Historial/fragments/formNuevo.jsp").forward(request, response);

        } catch (Exception e) {
            Logger.getLogger(HistorialMedicoController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id_historial"));
            Historial_Medico hm = model.ObtenerPorId(id);
            if (hm != null) {
                request.setAttribute("historial", hm);
                request.setAttribute("listaMascotas", modelMascota.listarMascota());
                request.getRequestDispatcher("/Historial/fragments/formEditar.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/error404.jsp");
            }
        } catch (Exception e) {
            Logger.getLogger(HistorialMedicoController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax)
            throws ServletException, IOException {
        try {
            Historial_Medico hm = new Historial_Medico();
            
            // para vincular automáticamente la descripción y mascota
            String paramIdServicio = request.getParameter("id_servicio");
            if (paramIdServicio != null) {
                int idServicio = Integer.parseInt(paramIdServicio);
                Servicio s = modelServicio.obtenerServicio(idServicio);
                hm.setId_mascota(s.getId_mascota());
                hm.setDescripcion("Servicio: " + s.getNombre() + " - " + s.getDescripcion());
                hm.setFecha(new Date(System.currentTimeMillis()));
            } else {
                hm.setId_mascota(Integer.parseInt(request.getParameter("id_mascota")));
                hm.setFecha(Date.valueOf(request.getParameter("fecha")));
                hm.setDescripcion(request.getParameter("descripcion"));
            }

            int resultado = model.insertar(hm);

            if (esAjax) {
                enviarJSON(response, resultado > 0, resultado > 0 ? "Historial insertado" : "Error al insertar");
            } else {
                request.getSession().setAttribute("mensaje", resultado > 0 ? "Registro exitoso" : "Error al registrar");
                listar(request, response);
            }

        } catch (Exception e) {
            if (esAjax) {
                enviarJSON(response, false, "Error: " + e.getMessage());
            } else {
                request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
                listar(request, response);
            }
        }
    }

    private void modificar(HttpServletRequest request, HttpServletResponse response, boolean esAjax)
            throws ServletException, IOException {
        try {
            Historial_Medico hm = new Historial_Medico();
            hm.setId_historial(Integer.parseInt(request.getParameter("id_historial")));
            hm.setId_mascota(Integer.parseInt(request.getParameter("id_mascota")));
            hm.setFecha(Date.valueOf(request.getParameter("fecha")));
            hm.setDescripcion(request.getParameter("descripcion"));

            int resultado = model.modificar(hm);

            if (esAjax) {
                enviarJSON(response, resultado > 0, resultado > 0 ? "Historial modificado" : "Error al modificar");
            } else {
                request.getSession().setAttribute("mensaje",
                        resultado > 0 ? "Modificación exitosa" : "Modificación fallida");
                listar(request, response);
            }
        } catch (Exception e) {
            if (esAjax) {
                enviarJSON(response, false, "Error: " + e.getMessage());
            } else {
                request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
                listar(request, response);
            }
        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idHistorial = Integer.parseInt(request.getParameter("id_historial"));
            model.eliminar(idHistorial);
        } catch (Exception e) {
            Logger.getLogger(HistorialMedicoController.class.getName()).log(Level.SEVERE, null, e);
            request.getSession().setAttribute("mensaje", "Error:" + e.getMessage());
        }
        listar(request, response);
    }

    private void listarPorMascota(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idMascota = Integer.parseInt(request.getParameter("id_mascota"));
            List<Historial_Medico> listaHistorial = model.buscarPorMascota(idMascota);
            Mascota mascota = modelMascota.obtenerMascota(idMascota);

            request.setAttribute("listaHistorial", listaHistorial);
            request.setAttribute("mascota", mascota);

            request.getRequestDispatcher("/Historial/historialMascota.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(HistorialMedicoController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private void enviarJSON(HttpServletResponse response, boolean success, String mensaje) {
        try {
            response.setContentType("application/json; charset=UTF-8");
            PrintWriter out = response.getWriter();
            String json = "{\"success\":" + success + ",\"mensaje\":\"" + mensaje + "\"}";
            out.write(json);
            out.flush();
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
