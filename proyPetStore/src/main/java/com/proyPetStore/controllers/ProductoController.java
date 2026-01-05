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

import com.proyPetStore.beans.Mascota;
import com.proyPetStore.beans.Producto;
import com.proyPetStore.model.ProductoModel;

/**
 * Servlet implementation class ProductoController
 */
@WebServlet("/ProductoController")
public class ProductoController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    ProductoModel modelo = new ProductoModel();

    public ProductoController() {
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
            case "insertarAjax":
            case "insertar":
                insertar(request, response, esAjax);
                break;
            case "modificarAjax":
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

    // LISTAR PRODUCTOS
    private void listar(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");

            request.setAttribute("listarProducto", modelo.listarProducto());
            request.getRequestDispatcher("/Producto/listarProducto.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            Logger.getLogger(ProductoController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    // FORMULARIO NUEVO
    private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");
            // combo categoria
            request.setAttribute("listarCategoria", modelo.listarCategoria());
            String jsp = "/Producto/fragments/formNuevo.jsp";

            request.getRequestDispatcher(jsp).forward(request, response);

        } catch (ServletException | IOException e) {
            Logger.getLogger(ProductoController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    // FORMULARIO EDITAR
    private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");

            int id = Integer.parseInt(request.getParameter("id"));
            Producto producto = modelo.obtenerProducto(id);

            request.setAttribute("producto", producto);
            if (producto != null) {
                request.setAttribute("producto", producto);
                request.setAttribute("listarCategoria", modelo.listarCategoria());
                String jsp = "/Producto/fragments/formEditar.jsp";
                request.getRequestDispatcher(jsp).forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/error404.jsp");
            }

        } catch (ServletException | IOException e) {
            Logger.getLogger(ProductoController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    // INSERTAR PRODUCTO
    // INSERTAR PRODUCTO
    private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
        try {
            Producto p = new Producto();

            p.setNombre(request.getParameter("nombre"));
            p.setId_categoria(Integer.parseInt(request.getParameter("id_categoria")));
            p.setDescripcion(request.getParameter("descripcion"));
            p.setStock(Integer.parseInt(request.getParameter("stock")));
            p.setPrecio_costo(Double.parseDouble(request.getParameter("precio_costo")));
            p.setPrecio_venta(Double.parseDouble(request.getParameter("precio_venta")));

            int resultado = modelo.insertarProducto(p);

            if (esAjax) {
                enviarJSON(response, resultado > 0,
                        resultado > 0 ? "Producto registrado exitosamente" : "Error al registrar");
            } else {
                request.getSession().setAttribute("mensaje",
                        resultado > 0 ? "Registro exitoso" : "Registro fallido");
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

    // MODIFICAR PRODUCTO
    private void modificar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
        try {
            Producto p = new Producto();

            p.setId_producto(Integer.parseInt(request.getParameter("id_producto")));
            p.setNombre(request.getParameter("nombre"));
            p.setId_categoria(Integer.parseInt(request.getParameter("id_categoria")));
            p.setDescripcion(request.getParameter("descripcion"));
            p.setStock(Integer.parseInt(request.getParameter("stock")));
            p.setPrecio_costo(Double.parseDouble(request.getParameter("precio_costo")));
            p.setPrecio_venta(Double.parseDouble(request.getParameter("precio_venta")));
            p.setEstado(request.getParameter("estado"));

            int resultado = modelo.modificarProducto(p);

            if (esAjax) {
                enviarJSON(response, resultado > 0,
                        resultado > 0 ? "Producto modificado exitosamente" : "Error al modificar");
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

    // ELIMINAR PRODUCTO
    private void eliminar(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int resultado = modelo.eliminarProducto(id);

            request.getSession().setAttribute("mensaje",
                    resultado > 0 ? "Producto eliminado con éxito" : "Error al eliminar");

            listar(request, response);

        } catch (Exception e) {
            Logger.getLogger(ProductoController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    // RESPUESTA JSON AJAX
    private void enviarJSON(HttpServletResponse response, boolean success, String mensaje) {
        try {
            response.setContentType("application/json; charset=UTF-8");

            String json = "{\"success\":" + success + ",\"mensaje\":\"" + mensaje + "\"}";

            PrintWriter out = response.getWriter();
            out.write(json);
            out.flush();

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
