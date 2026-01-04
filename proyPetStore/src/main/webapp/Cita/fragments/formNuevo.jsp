<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ page import="com.proyPetStore.beans.Mascota" %>
        <%@ page import="com.proyPetStore.beans.Servicio" %>
            <%@ page import="java.util.List" %>



                <div class="container py-3">

                    <h4 class="text-center mb-3">📅 Registrar Nueva Cita</h4>

                    <form action="<%=request.getContextPath()%>/CitaController" method="POST"
                        onsubmit="return validarCita()">
                        <input type="hidden" name="op" value="insertar">

                        <!-- MASCOTA -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Mascota:</label>
                            <select name="id_mascota" id="mascota" class="form-select" required>
                                <option value="">Seleccione...</option>

                                <% List<Mascota> mascotas = (List<Mascota>) request.getAttribute("listaMascotas");
                                        if (mascotas != null) {
                                        for (Mascota m : mascotas) {
                                        %>
                                        <option value="<%= m.getId_mascota() %>">
                                            <%= m.getNombre_mascota() %>
                                        </option>
                                        <% } } %>

                            </select>
                        </div>

                        <!-- SERVICIO -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Servicio:</label>
                            <select name="id_servicio" id="servicio" class="form-select" required>
                                <option value="">Seleccione...</option>

                                <% List<Servicio> servicios = (List<Servicio>) request.getAttribute("listaServicios");
                                        if (servicios != null) {
                                        for (Servicio s : servicios) {
                                        %>
                                        <option value="<%= s.getId_servicio() %>">
                                            <%= s.getNombre() %>
                                        </option>
                                        <% } } %>

                            </select>
                        </div>

                        <!-- FECHA -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Fecha:</label>
                            <input type="date" name="fecha" id="fecha" class="form-control" required>
                        </div>

                        <!-- HORA -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Hora:</label>
                            <input type="time" name="hora" id="hora" class="form-control" required>
                        </div>

                        <!-- ESTADO -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Estado:</label>
                            <select name="estado" id="estado" class="form-select" required>
                                <option value="">Seleccione...</option>
                                <option value="Pendiente">Pendiente</option>
                                <option value="Atendido">Atendida</option>
                                <option value="Cancelado">Cancelada</option>
                            </select>
                        </div>

                        <!-- OBSERVACIÓN -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">Observación (opcional):</label>
                            <textarea name="observacion" class="form-control" rows="2"
                                placeholder="Ingrese una observación"></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary w-100 mb-2">💾 Guardar Cita</button>

                    </form>

                </div>