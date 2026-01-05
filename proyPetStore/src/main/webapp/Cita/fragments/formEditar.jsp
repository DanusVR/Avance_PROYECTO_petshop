<%@ page contentType="text/html; charset=UTF-8" language="java" %>
	<%@ page import="com.proyPetStore.beans.Cita" %>
		<%@ page import="com.proyPetStore.beans.Mascota" %>
			<%@ page import="com.proyPetStore.beans.Servicio" %>
				<%@ page import="java.util.List" %>

					<% String url=request.getContextPath() + "/" ; Cita cita=(Cita) request.getAttribute("cita"); if
						(cita==null) { cita=new Cita(); } List<Mascota> mascotas = (List<Mascota>)
							request.getAttribute("listaMascotas");
							List<Servicio> servicios = (List<Servicio>) request.getAttribute("listaServicios");
									%>



									<div class="container py-3">
										<h3 class="mb-4 text-primary">✏️ Editar Cita</h3>

										<form action="<%=url%>CitaController" method="POST"
											onsubmit="return submitFormAjax(event, 'modalCita', '/CitaController?op=listar', 'validarCita')">
											<input type="hidden" name="op" value="modificar"> <input type="hidden"
												name="id_cita" value="<%=cita.getId_cita()%>">

											<!-- MASCOTA -->
											<div class="mb-3">
												<label class="form-label">Mascota</label> <select name="id_mascota"
													id="mascota" class="form-control" required>
													<option value="">Seleccione...</option>
													<% if (mascotas !=null) { for (Mascota m : mascotas) { %>
														<option value="<%=m.getId_mascota()%>"
															<%=(cita.getId_mascota()==m.getId_mascota()) ? "selected"
															: "" %>>
															<%=m.getNombre_mascota()%>
														</option>
														<% } } %>
												</select>
											</div>

											<!-- SERVICIO -->
											<div class="mb-3">
												<label class="form-label">Servicio</label> <select name="id_servicio"
													id="servicio" class="form-control" required>
													<option value="">Seleccione...</option>
													<% if (servicios !=null) { for (Servicio s : servicios) { %>
														<option value="<%=s.getId_servicio()%>"
															<%=(cita.getId_servicio()==s.getId_servicio()) ? "selected"
															: "" %>>
															<%=s.getNombre()%>
														</option>
														<% } } %>
												</select>
											</div>

											<!-- FECHA -->
											<div class="mb-3">
												<label class="form-label">Fecha</label> <input type="date" name="fecha"
													id="fecha"
													value="<%=cita.getFecha() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(cita.getFecha()) : "" %>"
												class="form-control" required>
											</div>

											<!-- HORA -->
											<div class="mb-3">
												<label class="form-label">Hora</label> <input type="time" name="hora"
													id="hora" value="<%=cita.getHora() != null ? cita.getHora() : ""%>"
													class="form-control" required>
											</div>

											<!-- ESTADO -->
											<div class="mb-3">
												<label class="form-label">Estado</label> <select name="estado"
													id="estado" class="form-control" required>
													<option value="">Seleccione...</option>
													<option value="Pendiente" <%="Pendiente" .equals(cita.getEstado())
														? "selected" : "" %>>Pendiente</option>
													<option value="Atendido" <%="Atendido" .equals(cita.getEstado())
														? "selected" : "" %>>Atendido</option>
													<option value="Cancelado" <%="Cancelado" .equals(cita.getEstado())
														? "selected" : "" %>>Cancelado</option>
												</select>
											</div>

											<!-- OBSERVACIÓN -->
											<div class="mb-3">
												<label class="form-label">Observación</label>
												<textarea name="observacion" id="observacion" class="form-control"
													rows="3"
													placeholder="Escribe una observación..."><%=cita.getObservacion() != null ? cita.getObservacion() : ""%></textarea>
											</div>

											<!-- BOTONES -->
											<button type="submit" class="btn btn-primary w-100 mb-2">💾
												Guardar cambios</button>
											<button type="button" class="btn btn-secondary w-100"
												data-bs-dismiss="modal">Cancelar</button>

										</form>

										</html>