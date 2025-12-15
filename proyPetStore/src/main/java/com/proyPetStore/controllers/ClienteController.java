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
import com.proyPetStore.model.ClienteModel;


/**
 * Servlet implementation class ClienteController
 */
@WebServlet("/ClienteController")
public class ClienteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ClienteModel modelo = new ClienteModel();

	public ClienteController() {
		super();
		// TODO Auto-generated constructor stub
	}
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String opc = request.getParameter("op");
		if (opc == null) {
			listar(request, response);
			return;
		}
		 // Detectar si es AJAX
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
			insertar(request, response, false);
			break;
		case "modificar":
			modificar(request, response, esAjax);
			break;
		case "eliminar":
			eliminar(request, response);
			break;
		case "reporte":
			break;
		default: listar(request, response);
			break;

		}

	}

	private void listar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setAttribute("listarCliente", modelo.listarClientes());
			request.getRequestDispatcher("/Cliente/listarCliente.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			Logger.getLogger(ClienteController.class.getName()).log(Level.SEVERE, null, e);
		}

	}
	private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
	    try {
	        response.setContentType("text/html; charset=UTF-8");
	        

	        String jsp = "/Cliente/fragments/formNuevo.jsp";
	        request.getRequestDispatcher(jsp).forward(request, response);
	    } catch (ServletException | IOException e) {
	        Logger.getLogger(ClienteController.class.getName()).log(Level.SEVERE, null, e);
	    }
	}
	private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			String id = request.getParameter("id");
			Cliente c = modelo.obtenerCliente(Integer.parseInt(id));
			
			 // PASO IMPORTANTE: pasar el cliente al JSP
	        request.setAttribute("cliente", c);

			String jsp =  "/Cliente/fragments/formEditar.jsp";
			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (ServletException | IOException e) {
			Logger.getLogger(ClienteController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {

		try {

			Cliente c = new Cliente();
			c.setDni(request.getParameter("dni"));
			c.setNombreC(request.getParameter("nombreC"));
			c.setApellido(request.getParameter("apellido"));
			c.setTelefono(request.getParameter("telefono"));
			c.setDireccion(request.getParameter("direccion"));

			int resultado = modelo.insertarClientes(c);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Cliente registrado exitosamente" : "Error al registrar");
			} else {

				response.setContentType("text/html; charset=UTF-8");
				if (resultado > 0) {
					request.getSession().setAttribute("mensaje", "Registro exitoso");
				} else {
					request.getSession().setAttribute("mensaje", "Registro fallido");
				}
				listar(request, response);
			}
		} catch (Exception e) {

			e.printStackTrace();

			if (esAjax) {
				enviarJSON(response, false, "Error: " + e.getMessage());
			} else {
				try {
					response.setContentType("text/html; charset=UTF-8");
					request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
					listar(request, response);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		}
	}

	private void modificar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
	    try {
	        Cliente c = new Cliente();
	        c.setId_cliente(Integer.parseInt(request.getParameter("id_cliente")));
	        c.setDni(request.getParameter("dni"));
	        c.setNombreC(request.getParameter("nombreC"));
	        c.setApellido(request.getParameter("apellido")); 
	        c.setTelefono(request.getParameter("telefono"));
	        c.setDireccion(request.getParameter("direccion"));

	        int resultado = modelo.modificarClientes(c);

	        if (esAjax) {
	            enviarJSON(response, resultado > 0,
	                    resultado > 0 ? "Cliente modificado exitosamente" : "Error al modificar");
	        } else {
	            response.setContentType("text/html; charset=UTF-8");
	            if (resultado > 0) {
	                request.getSession().setAttribute("mensaje", "Modificación exitosa");
	            } else {
	                request.getSession().setAttribute("mensaje", "Modificación fallida");
	            }
	            listar(request, response);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();

	        if (esAjax) {
	            enviarJSON(response, false, "Error: " + e.getMessage());
	        } else {
	            try {
	                response.setContentType("text/html; charset=UTF-8");
	                request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
	                listar(request, response);
	            } catch (Exception ex) {
	                ex.printStackTrace();
	            }
	        }
	    }
	}

	/**
	 * Elimina un autor
	 */
	private void eliminar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			int id = Integer.parseInt(request.getParameter("id"));

			int resultado = modelo.eliminarClientes(id);
			String mensaje = resultado > 0 ? "cliente eliminado exitosamente" : "Error al eliminar autor";
			request.getSession().setAttribute("mensaje", mensaje);

		} catch (Exception e) {
			Logger.getLogger(ClienteController.class.getName()).log(Level.SEVERE, null, e);
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

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

}
