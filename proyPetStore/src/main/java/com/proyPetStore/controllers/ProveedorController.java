package com.proyPetStore.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.proyPetStore.beans.Proveedor;
import com.proyPetStore.model.ProveedorModel;

/**
 * Servlet implementation class ProveedorController
 */
@WebServlet("/ProveedorController")
public class ProveedorController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	ProveedorModel modelo = new ProveedorModel();
	
    public ProveedorController() {
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

    // ================= LISTAR =================
    private void listar(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");
            request.setAttribute("listarProveedor", modelo.listarProveedor());
            request.getRequestDispatcher("/Proveedor/listarProveedor.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(ProveedorController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    // ================= FORM NUEVO =================
    private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");
            request.getRequestDispatcher("/Proveedor/fragments/formNuevo.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(ProveedorController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    // ================= FORM EDITAR =================
    private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");
            int id = Integer.parseInt(request.getParameter("id"));
            Proveedor p = modelo.obtenerProveedor(id);
            request.setAttribute("proveedor", p);
            request.getRequestDispatcher("/Proveedor/fragments/formEditar.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(ProveedorController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    // ================= INSERTAR =================
    private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
        try {
            Proveedor p = new Proveedor();
            p.setNombre(request.getParameter("nombre"));
            p.setRuc(request.getParameter("ruc"));
            p.setTelefono(request.getParameter("telefono"));
            p.setCorreo(request.getParameter("correo"));
            p.setDireccion(request.getParameter("direccion"));
            p.setTipo(request.getParameter("tipo"));

            int resultado = modelo.insertarProveedor(p);

            if (esAjax) {
                enviarJSON(response, resultado > 0,
                        resultado > 0 ? "Proveedor registrado correctamente" : "Error al registrar");
            } else {
                request.getSession().setAttribute("mensaje",
                        resultado > 0 ? "Registro exitoso" : "Registro fallido");
                listar(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            if (esAjax) {
                enviarJSON(response, false, "Error: " + e.getMessage());
            }
        }
    }

    // ================= MODIFICAR =================
    private void modificar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
        try {
            Proveedor p = new Proveedor();
            p.setIdProveedor(Integer.parseInt(request.getParameter("id_proveedor")));
            p.setNombre(request.getParameter("nombre"));
            p.setRuc(request.getParameter("ruc"));
            p.setTelefono(request.getParameter("telefono"));
            p.setCorreo(request.getParameter("correo"));
            p.setDireccion(request.getParameter("direccion"));
            p.setTipo(request.getParameter("tipo"));

            int resultado = modelo.modificarProveedor(p);

            if (esAjax) {
                enviarJSON(response, resultado > 0,
                        resultado > 0 ? "Proveedor modificado correctamente" : "Error al modificar");
            } else {
                request.getSession().setAttribute("mensaje",
                        resultado > 0 ? "Modificación exitosa" : "Modificación fallida");
                listar(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            if (esAjax) {
                enviarJSON(response, false, "Error: " + e.getMessage());
            }
        }
    }

    // ================= ELIMINAR =================
    private void eliminar(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int resultado = modelo.eliminarProveedor(id);
            request.getSession().setAttribute("mensaje",
                    resultado > 0 ? "Proveedor eliminado correctamente" : "Error al eliminar proveedor");
        } catch (Exception e) {
            Logger.getLogger(ProveedorController.class.getName()).log(Level.SEVERE, null, e);
            request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
        }
        listar(request, response);
    }

    // ================= JSON =================
    private void enviarJSON(HttpServletResponse response, boolean success, String mensaje) {
        try {
            response.reset();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.setHeader("Cache-Control", "no-cache");

            String json = "{\"success\":" + success + ",\"mensaje\":\"" +
                    mensaje.replace("\"", "'") + "\"}";

            PrintWriter  out = response.getWriter();
            out.write(json);
            out.flush();
            out.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
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
