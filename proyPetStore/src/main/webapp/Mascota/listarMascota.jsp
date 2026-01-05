<%@ page import="com.proyPetStore.beans.Mascota" %>
    <%@ page import="java.util.List" %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

            <% String url=request.getContextPath() + "/" ; List<Mascota> listarMascota = (List<Mascota>)
                    request.getAttribute("listarMascota");
                    %>

                    <!DOCTYPE html>
                    <html lang="es">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Gestión de Mascotas</title>

                        <!-- Bootstrap -->
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
                            rel="stylesheet">
                        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                            rel="stylesheet">
                    </head>

                    <body class="bg-light">

                        <div class="container mt-5">

                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h2>🐾 Lista de Mascotas</h2>
                                <button class="btn btn-success" onclick="modalMascota.abrir('nuevo')">➕ Nueva
                                    Mascota</button>
                            </div>

                            <table class="table table-striped table-hover align-middle">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>NOMBRE</th>
                                        <th>ESPECIE</th>
                                        <th>RAZA</th>
                                        <th>SEXO</th>
                                        <th>EDAD</th>
                                        <th>CLIENTE</th>
                                        <th>ACCIONES</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <% if (listarMascota !=null && !listarMascota.isEmpty()) { for (Mascota mascota :
                                        listarMascota) { %>
                                        <tr>
                                            <td>
                                                <%=mascota.getId_mascota()%>
                                            </td>
                                            <td>
                                                <%=mascota.getNombre_mascota()%>
                                            </td>
                                            <td>
                                                <%=mascota.getEspecie()%>
                                            </td>
                                            <td>
                                                <%=mascota.getRaza()%>
                                            </td>
                                            <td>
                                                <%=mascota.getSexo()%>
                                            </td>
                                            <td>
                                                <%=mascota.getEdad()%>
                                            </td>
                                            <td>
                                                <%=mascota.getNombre()%>
                                            </td>
                                            <td>
                                                <button class="btn btn-warning btn-sm"
                                                    onclick="modalMascota.abrir('editar', <%=mascota.getId_mascota()%>)">
                                                    ✏️ Editar
                                                </button>

                                                <button class="btn btn-info btn-sm"
                                                    onclick="modalHistorial.abrir(<%=mascota.getId_mascota()%>)">
                                                    🩺 Historial
                                                </button>

                                                <a class="btn btn-danger btn-sm"
                                                    href="<%=url%>MascotaController?op=eliminar&id=<%=mascota.getId_mascota()%>"
                                                    onclick="return confirm('¿Seguro de eliminar esta mascota?')">
                                                    🗑 Eliminar
                                                </a>
                                            </td>
                                        </tr>
                                        <% } } else { %>
                                            <tr>
                                                <td colspan="8" class="text-center text-muted">
                                                    No hay mascotas registradas
                                                </td>
                                            </tr>
                                            <% } %>
                                </tbody>
                            </table>
                        </div>

                        <!-- ================= MODAL MASCOTA ================= -->
                        <div class="modal fade" id="modalMascota" tabindex="-1">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header text-white" style="background-color: #ec8caa;">
                                        <h5 class="modal-title">Gestión de Mascota</h5>
                                        <button type="button" class="btn-close btn-close-white"
                                            data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Form Nuevo / Editar -->
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- ================= MODAL HISTORIAL ================= -->
                        <div class="modal fade" id="modalHistorial" tabindex="-1">
                            <div class="modal-dialog modal-xl">
                                <div class="modal-content">
                                    <div class="modal-header text-white" style="background-color: #ec8caa;">
                                        <h5 class="modal-title">🩺 Historial Médico</h5>
                                        <button type="button" class="btn-close btn-close-white"
                                            data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Historial cargado dinámicamente -->
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Bootstrap JS -->
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


                    </body>

                    </html>