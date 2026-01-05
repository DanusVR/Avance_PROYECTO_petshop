<%@page import="com.proyPetStore.beans.Cliente" %>
	<%@page import="java.util.List" %>
		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<title>Gestión de Clientes</title>


				<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

			</head>

			<body class="bg-light">

				<div class="container mt-5">

					<div class="d-flex justify-content-between align-items-center mb-4">
						<h2 class="text-primary">Gestión de Clientes</h2>

						<div class="d-flex justify-content-end mb-3">
							<button class="btn btn-success" onclick="modalCliente.abrir('nuevo')"> ➕ Nuevo Cliente
							</button>
						</div>
					</div>

					<div class="card shadow">
						<div class="card-body">

							<table class="table table-striped table-hover align-middle">
								<thead class="table-dark">
									<tr>
										<th>ID</th>
										<th>DNI</th>
										<th>NOMBRE</th>
										<th>APELLIDO</th>
										<th>TELÉFONO</th>
										<th>DIRECCIÓN</th>
										<th>ACCIONES</th>
									</tr>
								</thead>
								<tbody>
									<% List<Cliente> listarCliente = (List<Cliente>)
											request.getAttribute("listarCliente");
											if (listarCliente != null && !listarCliente.isEmpty()) {
											for (Cliente cliente : listarCliente) {
											%>
											<tr>
												<td>
													<%=cliente.getId_cliente()%>
												</td>
												<td>
													<%=cliente.getDni()%>
												</td>
												<td>
													<%=cliente.getNombreC()%>
												</td>
												<td>
													<%=cliente.getApellido()%>
												</td>
												<td>
													<%=cliente.getTelefono()%>
												</td>
												<td>
													<%=cliente.getDireccion()%>
												</td>
												<td class="acciones">
													<!--  -->
													<button
														onclick="modalCliente.abrir('editar', <%=cliente.getId_cliente()%>)"
														class="btn btn-warning btn-sm">Editar</button>
													<button
														onclick="eliminarRegistro('/ClienteController?op=eliminar&id=<%=cliente.getId_cliente()%>')"
														class="btn btn-danger btn-sm">
														Eliminar </button>
												</td>
											</tr>
											<% } } else { %>
												<tr>
													<td colspan="6" class="text-center text-muted py-3">No hay
														clientes registrados.</td>
												</tr>
												<% } %>
								</tbody>
							</table>

						</div>
					</div>

				</div>
				<!-- Modal para Gestión de Cliente-->
				<div class="modal fade" id="modalCliente" tabindex="-1" aria-labelledby="modalClienteLabel"
					aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header text-white" style="background-color: #ec8caa;">
								<h5 class="modal-title" id="modalClienteLabel">Gestión de
									Cliente</h5>
								<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<!-- Aquí se cargará dinámicamente formNuevo.jsp o formEditar.jsp -->
							</div>
						</div>
					</div>
				</div>

				<!-- Bootstrap JS -->
				<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

			</body>

			</html>