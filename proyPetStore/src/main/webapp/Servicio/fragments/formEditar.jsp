<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.proyPetStore.beans.Servicio" %>
        <%@ page import="com.proyPetStore.beans.Mascota" %>
            <%@ page import="java.util.List" %>

                <% String url=request.getContextPath() + "/" ; Servicio servicio=(Servicio)
                    request.getAttribute("servicio"); List<Mascota> listaMascotas = (List<Mascota>)
                        request.getAttribute("listaMascotas");

                        if (servicio == null) {
                        servicio = new Servicio();
                        }
                        %>



                        <div class="container py-4">

                            <h2 class="text-center mb-4">✏️ Editar Servicio</h2>

                            <div class="card shadow">
                                <div class="card-body">

                                    <form action="<%=url%>ServicioController" method="POST"
                                        onsubmit="return validarServicio()">

                                        <input type="hidden" name="op" value="modificar">
                                        <input type="hidden" name="id_servicio" value="<%=servicio.getId_servicio()%>">

                                        <!-- NOMBRE -->
                                        <div class="mb-3">
                                            <label class="form-label">Nombre del Servicio</label>
                                            <input type="text" name="nombre" id="nombre"
                                                value="<%=servicio.getNombre() != null ? servicio.getNombre() : ""%>"
                                                class="form-control" required>
                                        </div>

                                        <!-- TIPO -->
                                        <div class="mb-3">
                                            <label class="form-label">Tipo</label>
                                            <select name="tipo" id="tipo" class="form-control" required>
                                                <option value="">Seleccione...</option>
                                                <option value="Baño" <%="Baño" .equals(servicio.getTipo()) ? "selected"
                                                    : "" %>>Baño</option>
                                                <option value="Peluquería" <%="Peluquería" .equals(servicio.getTipo())
                                                    ? "selected" : "" %>>Peluquería</option>
                                                <option value="Vacuna" <%="Vacuna" .equals(servicio.getTipo())
                                                    ? "selected" : "" %>>Vacuna</option>
                                                <option value="Consulta" <%="Consulta" .equals(servicio.getTipo())
                                                    ? "selected" : "" %>>Consulta</option>
                                                <option value="Otro" <%="Otro" .equals(servicio.getTipo()) ? "selected"
                                                    : "" %>>Otro</option>
                                            </select>
                                        </div>

                                        <!-- MASCOTA (NUEVO) -->
                                        <div class="mb-3">
                                            <label class="form-label">Mascota</label>
                                            <select name="id_mascota" id="id_mascota" class="form-control" required>

                                                <option value="">Seleccione una mascota...</option>

                                                <% if (listaMascotas !=null) { for (Mascota m : listaMascotas) { %>

                                                    <option value="<%=m.getId_mascota()%>"
                                                        <%=m.getId_mascota()==servicio.getId_mascota() ? "selected" : ""
                                                        %>>
                                                        <%=m.getNombre()%> - <%=m.getEspecie()%>
                                                    </option>

                                                    <% } } %>

                                            </select>
                                        </div>

                                        <!-- DESCRIPCIÓN -->
                                        <div class="mb-3">
                                            <label class="form-label">Descripción</label>
                                            <textarea name="descripcion" id="descripcion" class="form-control" rows="3"
                                                required><%=servicio.getDescripcion()%></textarea>
                                        </div>

                                        <!-- PRECIO -->
                                        <div class="mb-3">
                                            <label class="form-label">Precio (S/.)</label>
                                            <input type="number" step="0.01" name="precio" id="precio"
                                                value="<%=servicio.getPrecio()%>" class="form-control" required>
                                        </div>

                                        <!-- ESTADO -->
                                        <div class="mb-3">
                                            <label class="form-label">Estado</label>
                                            <select name="estado" id="estado" class="form-control" required>
                                                <option value="">Seleccione...</option>
                                                <option value="Activo" <%="Activo" .equals(servicio.getEstado())
                                                    ? "selected" : "" %>>Activo</option>
                                                <option value="Inactivo" <%="Inactivo" .equals(servicio.getEstado())
                                                    ? "selected" : "" %>>Inactivo</option>
                                            </select>
                                        </div>

                                        <button type="submit" class="btn btn-primary w-100 mb-2">Guardar
                                            Cambios</button>

                                        <button type="button" class="btn btn-secondary w-100"
                                            data-bs-dismiss="modal">Cancelar</button>

                                    </form>

                                </div>
                            </div>

                        </div>

                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>