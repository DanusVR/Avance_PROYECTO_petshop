<%@page import="com.proyPetStore.beans.Cliente" %>
    <%@page import="java.util.List" %>
        <%@page import="com.proyPetStore.beans.Mascota" %>
            <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

                <% List<Cliente> listarCliente = (List<Cliente>) request.getAttribute("listarCliente");
                        Mascota mascota = (Mascota) request.getAttribute("mascota"); // Puede ser null
                        String especieSeleccionada = (mascota != null) ? mascota.getEspecie() : "";
                        String sexoSeleccionado = (mascota != null) ? mascota.getSexo() : "";
                        int clienteSeleccionado = (mascota != null) ? mascota.getId_cliente() : 0;
                        %>



                        <div class="container mt-4">
                            <h2 class="text-center mb-4">🐾 Agregar Nueva Mascota</h2>

                            <div class="card shadow-sm col-md-6 mx-auto">
                                <div class="card-body">
                                    <form action="<%=request.getContextPath()%>/MascotaController?op=insertar"
                                        method="post">
                                        <input type="hidden" name="op" value="insertar">

                                        <div class="mb-3">
                                            <label class="form-label">Nombre Mascota:</label>
                                            <input type="text" name="nombre_mascota" class="form-control" required>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Especie:</label>
                                            <select class="form-select" name="especie" required>
                                                <option value="">Seleccione una especie</option>
                                                <option value="Perro" <%="Perro" .equals(especieSeleccionada)
                                                    ? "selected" : "" %>>Perro</option>
                                                <option value="Gato" <%="Gato" .equals(especieSeleccionada) ? "selected"
                                                    : "" %>>Gato</option>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Raza:</label>
                                            <input type="text" name="raza" class="form-control" required>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Edad:</label>
                                            <input type="number" name="edad" min="0" class="form-control" required>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Sexo:</label>
                                            <select class="form-select" name="sexo" required>
                                                <option value="">Seleccione un sexo</option>
                                                <option value="Macho" <%="Macho" .equals(sexoSeleccionado) ? "selected"
                                                    : "" %>>Macho</option>
                                                <option value="Hembra" <%="Hembra" .equals(sexoSeleccionado)
                                                    ? "selected" : "" %>>Hembra</option>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label">Cliente:</label>
                                            <select name="id_cliente" class="form-select" required>
                                                <option value="">Seleccione un cliente</option>
                                                <% if (listarCliente !=null) { for (Cliente cliente : listarCliente) {
                                                    String selected=(cliente.getId_cliente()==clienteSeleccionado)
                                                    ? "selected" : "" ; %>
                                                    <option value="<%=cliente.getId_cliente()%>" <%=selected%>>
                                                        <%=cliente.getNombreC() + " " + cliente.getApellido()%>
                                                    </option>
                                                    <% } } %>
                                            </select>
                                        </div>

                                        <button type="submit" class="btn btn-success w-100 mb-2">💾 Guardar
                                            Mascota</button>
                                    </form>

                                    <button type="button" class="btn btn-secondary w-100"
                                        data-bs-dismiss="modal">Cancelar</button>
                                </div>
                            </div>
                        </div>