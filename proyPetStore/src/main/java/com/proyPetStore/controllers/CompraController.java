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

import com.proyPetStore.beans.CompraDetalle;
import com.proyPetStore.beans.Compras;
import com.proyPetStore.model.CompraModel;
import com.proyPetStore.model.ProductoModel;
import com.proyPetStore.model.ProveedorModel;

/**
 * Servlet implementation class CompraController
 */
@WebServlet("/CompraController")
public class CompraController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    CompraModel modelo;
    ProveedorModel proveedorModel;
    ProductoModel productoModel;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CompraController() {
        super();
    }

    @Override
    public void init() throws ServletException {
        try {
            modelo = new CompraModel();
            proveedorModel = new ProveedorModel();
            productoModel = new ProductoModel();
        } catch (Exception e) {
            Logger.getLogger(CompraController.class.getName()).log(Level.SEVERE,
                    "Error initializing CompraController models", e);
            throw new ServletException("Failed to initialize CompraController", e);
        }
    }

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
            case "insertar":
            case "insertarAjax":
                insertar(request, response, esAjax);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            case "ver":
                ver(request, response);
                break;
            default:
                listar(request, response);
        }
    }

    // ================= VER COMPRA =================
    private void ver(HttpServletRequest request, HttpServletResponse response) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Compras compra = modelo.obtenerCompra(id);
            request.setAttribute("compra", compra);
            request.getRequestDispatcher("/Compra/fragments/verCompra.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(CompraController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    // ================= LISTAR =================
    private void listar(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setAttribute("listarCompras", modelo.listarCompras());
            request.getRequestDispatcher("/Compra/listarCompra.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(CompraController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    // ================= FORM NUEVO =================
    private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
        try {
            // Para llenar combo de proveedores y productos
            request.setAttribute("listarProveedor", proveedorModel.listarProveedor());
            request.setAttribute("listarProductos", productoModel.listarProducto());
            request.getRequestDispatcher("/Compra/fragments/formNuevoCompra.jsp").forward(request, response);
        } catch (Exception e) {
            Logger.getLogger(CompraController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    // ================= INSERTAR =================
    private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
        try {
            // Obtener datos de la compra
            String idProvStr = request.getParameter("id_proveedor");
            if (idProvStr == null || idProvStr.isEmpty()) {
                throw new Exception("El proveedor es obligatorio.");
            }
            int idProveedor = Integer.parseInt(idProvStr);

            // Total: Primero intentamos leer, si es null calcularemos sumando detalles
            String totalStr = request.getParameter("total");
            double total = 0.0;
            if (totalStr != null && !totalStr.isEmpty()) {
                try {
                    total = Double.parseDouble(totalStr);
                } catch (NumberFormatException e) {
                    total = 0.0;
                }
            }

            Compras compra = new Compras();
            compra.setId_proveedor(idProveedor);
            // compra.setTotal(total); // Se asignará después de calcular o verificar

            // Obtener detalles desde el formulario (arrays)
            String[] productos = request.getParameterValues("id_producto");
            String[] cantidades = request.getParameterValues("cantidad");
            String[] precios = request.getParameterValues("precio_unitario");

            if (productos == null || productos.length == 0) {
                throw new Exception("Debe agregar al menos un producto.");
            }

            double totalCalculado = 0.0;

            for (int i = 0; i < productos.length; i++) {
                CompraDetalle det = new CompraDetalle();
                det.setId_producto(Integer.parseInt(productos[i]));
                int cant = Integer.parseInt(cantidades[i]);
                double prec = Double.parseDouble(precios[i]);

                det.setCantidad(cant);
                det.setPrecio_unitario(prec);

                // Calculamos subtotal para sumarlo al total general
                double sub = cant * prec;
                det.setSubtotal(sub); // Aunque en BD es calculado, lo seteamos por consistencia

                totalCalculado += sub;

                compra.getDetalles().add(det);
            }

            // Usar el total calculado en el backend es mas seguro
            compra.setTotal(totalCalculado);

            int resultado = modelo.insertarCompra(compra);

            if (esAjax) {
                enviarJSON(response, resultado > 0,
                        resultado > 0 ? "Compra registrada correctamente" : "Error al registrar");
            } else {
                request.getSession().setAttribute("mensaje",
                        resultado > 0 ? "Compra registrada correctamente" : "Error al registrar");
                listar(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            if (esAjax)
                enviarJSON(response, false, "Error: " + e.getMessage());
            else {
                try {
                    request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
                    listar(request, response);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    // ================= ELIMINAR =================
    private void eliminar(HttpServletRequest request, HttpServletResponse response) {
        try {
            int idCompra = Integer.parseInt(request.getParameter("id"));
            int resultado = modelo.eliminarCompra(idCompra);
            request.getSession().setAttribute("mensaje",
                    resultado > 0 ? "Compra anulada correctamente" : "Error al anular");
        } catch (Exception e) {
            Logger.getLogger(CompraController.class.getName()).log(Level.SEVERE, null, e);
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

            String json = "{\"success\":" + success + ",\"mensaje\":\"" + mensaje.replace("\"", "'") + "\"}";
            PrintWriter out = response.getWriter();
            out.write(json);
            out.flush();
            out.close();
        } catch (Exception e) {
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
