<%@page import="com.proyPetStore.beans.Cliente" %>
	<%@page import="java.util.List" %>
		<%@page import="com.proyPetStore.beans.Mascota" %>
			<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

				<% String url=request.getContextPath() + "/" ; Mascota mascota=(Mascota)
					request.getAttribute("mascota"); List<Cliente> listarCliente = (List<Cliente>)
						request.getAttribute("listarCliente");

						if (mascota == null) {
						mascota = new Mascota();
						}
						%>



						<div class="container mt-5">
							<h2 class="mb-4 text-primary">🐾 Editar Mascota</h2>

							<div class="card shadow-sm">
								<div class="card-body">
									<form action="<%=url%>MascotaController" method="POST">
										<input type="hidden" name="op" value="modificar"> <input type="hidden"
											name="id_mascota" value="<%=mascota.getId_mascota()%>">

										<div class="mb-3">
											<label for="nombre_mascota" class="form-label">Nombre:</label> <input
												type="text" class="form-control" name="nombre_mascota"
												id="nombre_mascota"
												value="<%=mascota.getNombre_mascota() != null ? mascota.getNombre_mascota() : ""%>"
												required>
										</div>

										<div class="mb-3">
											<label for="especie" class="form-label">Especie:</label> <select
												class="form-select" name="especie" id="especie" required>
												<option value="" disabled selected>Seleccione una
													especie</option>
												<option value="Perro" <%="Perro" .equals(mascota.getEspecie())
													? "selected" : "" %>>Perro</option>
												<option value="Gato" <%="Gato" .equals(mascota.getEspecie())
													? "selected" : "" %>>Gato</option>
											</select>
										</div>


										<div class="mb-3">
											<label for="raza" class="form-label">Raza:</label> <input type="text"
												class="form-control" name="raza" id="raza"
												value="<%=mascota.getRaza() != null ? mascota.getRaza() : ""%>">
										</div>

										<div class="mb-3">
											<label for="edad" class="form-label">Edad:</label> <input type="number"
												class="form-control" name="edad" id="edad" min="0"
												value="<%=mascota.getEdad()%>" required>
										</div>

										<% String sexoSeleccionado=mascota.getSexo() !=null ? mascota.getSexo() : "" ;
											%>
											<div class="mb-3">
												<label class="form-label">Sexo:</label> <select class="form-select"
													name="sexo" required>
													<option value="">Seleccione un sexo</option>
													<option value="Macho" <%="Macho" .equals(sexoSeleccionado)
														? "selected" : "" %>>Macho</option>
													<option value="Hembra" <%="Hembra" .equals(sexoSeleccionado)
														? "selected" : "" %>>Hembra</option>
												</select>
											</div>

											<div class="mb-3">
												<label for="id_cliente" class="form-label">Cliente:</label> <select
													name="id_cliente" id="id_cliente" class="form-select" required>
													<option value="">Seleccione un cliente</option>
													<% if (listarCliente !=null) { for (Cliente cliente : listarCliente)
														{ String
														selected=(cliente.getId_cliente()==mascota.getId_cliente())
														? "selected" : "" ; %>
														<option value="<%=cliente.getId_cliente()%>" <%=selected%>>
															<%=cliente.getNombreC() + " " + cliente.getApellido()%>
														</option>
														<% } } %>
												</select>
											</div>

											<div class="d-flex justify-content-between">
												<button type="submit" class="btn btn-success">💾 Guardar
													Cambios</button>
												<button type="button" class="btn btn-secondary"
													onclick="window.location.href='<%=url%>MascotaController?op=listar'">←
													Volver a Lista</button>
											</div>
									</form>
								</div>
							</div>
						</div>



						</html>