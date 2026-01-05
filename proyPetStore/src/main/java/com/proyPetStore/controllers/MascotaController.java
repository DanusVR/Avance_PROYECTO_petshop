package com.proyPetStore.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.ServerException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.proyPetStore.beans.Cliente;
import com.proyPetStore.beans.Mascota;
import com.proyPetStore.model.MascotaModel;

/**
 * Servlet implementation class MascotaController
 */
@WebServlet("/MascotaController")
public class MascotaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	MascotaModel modelo = new MascotaModel();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MascotaController() {
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
			case "insertarAjax":
			case "insertar":
				insertar(request, response, esAjax);
				break;
			case "modificarAjax":
			case "modificar":
				modificar(request, response, esAjax);
				break;
			case "eliminar":
				this.eliminar(request, response);
				break;
			case "reporte":

			default:
				listar(request, response);
				break;
		}
	}

	// metodo listar
	private void listar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			System.out.println("Entrando a listar Mascotas...");
			request.setAttribute("listarMascota", modelo.listarMascota());
			request.getRequestDispatcher("/Mascota/listarMascota.jsp").forward(request, response);

		} catch (Exception e) {
			Logger.getLogger(MascotaController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			// cargar Combo cliente
			request.setAttribute("listarMascota", modelo.listarMascota());
			request.setAttribute("listarCliente", modelo.listarClientes());

			String jsp = "/Mascota/fragments/formNuevo.jsp";
			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (ServletException | IOException e) {
			Logger.getLogger(MascotaController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			String id = request.getParameter("id");
			Mascota mascota = modelo.obtenerMascota(Integer.parseInt(id));

			request.setAttribute("mascota", mascota);

			if (mascota != null) {
				request.setAttribute("mascota", mascota);
				// cargar Combo cliente
				request.setAttribute("listarMascota", modelo.listarMascota());
				request.setAttribute("listarCliente", modelo.listarClientes());
				String jsp = "/Mascota/fragments/formEditar.jsp";
				request.getRequestDispatcher(jsp).forward(request, response);

			} else {
				response.sendRedirect(request.getContextPath() + "/error404.jsp");
			}

		} catch (ServletException | IOException e) {
			Logger.getLogger(MascotaController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {

		try {
			Mascota mascota = new Mascota();
			mascota.setNombre_mascota(request.getParameter("nombre_mascota"));
			mascota.setEspecie(request.getParameter("especie"));
			mascota.setRaza(request.getParameter("raza"));
			mascota.setEdad(Integer.parseInt(request.getParameter("edad")));
			mascota.setSexo(request.getParameter("sexo"));

			mascota.setId_cliente(Integer.parseInt(request.getParameter("id_cliente")));

			int resultado = modelo.insertarMascota(mascota);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Mascota registrado exitosamente" : "Error al registrar");
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
			Mascota mascota = new Mascota();
			mascota.setId_mascota(Integer.parseInt(request.getParameter("id_mascota")));

			mascota.setNombre_mascota(request.getParameter("nombre_mascota"));
			mascota.setEspecie(request.getParameter("especie"));
			mascota.setRaza(request.getParameter("raza"));
			mascota.setEdad(Integer.parseInt(request.getParameter("edad")));
			mascota.setSexo(request.getParameter("sexo"));
			mascota.setId_cliente(Integer.parseInt(request.getParameter("id_cliente")));

			int resultado = modelo.modificarMascota(mascota);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Mascota modificado exitosamente" : "Error al modificar");
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

	// eliminar
	private void eliminar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			int id = Integer.parseInt(request.getParameter("id"));
			int resultado = modelo.eliminarMascota(id);

			String mensaje = resultado > 0 ? "Mascota eliminado con exito " : "error al eliminar";
			listar(request, response);
		} catch (Exception e) {
			Logger.getLogger(MascotaController.class.getName()).log(Level.SEVERE, null, e);
			request.getSession().setAttribute("mensaje", "Error:" + e.getMessage());
		}
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
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);

	}
}