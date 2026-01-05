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

import com.proyPetStore.beans.Categoria;
import com.proyPetStore.beans.Cliente;
import com.proyPetStore.model.CategoriaModel;

/**
 * Servlet implementation class CategoriaController
 */
@WebServlet("/CategoriaController")
public class CategoriaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	CategoriaModel modelo = new CategoriaModel();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CategoriaController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String opc = request.getParameter("op");
		if (opc == null) {
			listar(request, response);
			return;
		} // Detectar si es AJAX
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
				insertar(request, response, false);
				break;
			case "modificarAjax":
			case "modificar":
				modificar(request, response, esAjax);
				break;
			case "eliminar":
				eliminar(request, response);
				break;
			case "reporte":
				break;
			default:
				listar(request, response);
				break;

		}

	}

	private void listar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setAttribute("listarCategoria", modelo.listarCategoria());
			request.getRequestDispatcher("/Categoria/listarCategoria.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			Logger.getLogger(CategoriaController.class.getName()).log(Level.SEVERE, null, e);
		}

	}

	private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");

			String jsp = "/Categoria/fragments/formNuevo.jsp";
			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (ServletException | IOException e) {
			Logger.getLogger(CategoriaController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			String id = request.getParameter("id");
			Categoria c = modelo.obtenerCategoria(Integer.parseInt(id));

			request.setAttribute("categoria", c);

			String jsp = "/Categoria/fragments/formEditar.jsp";
			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (ServletException | IOException e) {
			Logger.getLogger(CategoriaController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {

		try {

			Categoria c = new Categoria();
			c.setNombreCat(request.getParameter("nombreCat"));
			int resultado = modelo.insertarCategoria(c);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Categoria registrado exitosamente" : "Error al registrar");
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
			Categoria c = new Categoria();
			c.setId_categoria(Integer.parseInt(request.getParameter("id_categoria")));
			c.setNombreCat(request.getParameter("nombreCat"));

			int resultado = modelo.modificarCategoria(c);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Categoria modificado exitosamente" : "Error al modificar");
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

	private void eliminar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			int id = Integer.parseInt(request.getParameter("id"));

			int resultado = modelo.eliminarCategoria(id);
			String mensaje = resultado > 0 ? "categoria eliminado exitosamente" : "Error al eliminar autor";
			request.getSession().setAttribute("mensaje", mensaje);

		} catch (Exception e) {
			Logger.getLogger(CategoriaController.class.getName()).log(Level.SEVERE, null, e);
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
