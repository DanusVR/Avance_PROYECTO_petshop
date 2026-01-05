<%@page import="com.proyPetStore.beans.Usuario" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ page import="java.util.List" %>

            <!DOCTYPE html>
            <html>

            <head>
                <% String url=request.getContextPath() + "/" ; %>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
                        rel="stylesheet"
                        integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
                        crossorigin="anonymous">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <meta charset="UTF-8">
                    <title>Gestión de Usuarios</title>
            </head>

            <body>


                <div class="container mt-4">
                    <h2 class="mb-4">
                        <i class="fas fa-user-shield"></i> Gestión de Usuarios
                    </h2>

                    <!-- Mensajes de sesión -->
                    <% String mensaje=(String) session.getAttribute("mensaje"); if (mensaje !=null) { %>
                        <div class="alert alert-info alert-dismissible fade show" role="alert">
                            <i class="fas fa-info-circle"></i>
                            <%=mensaje%>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                        <% session.removeAttribute("mensaje"); } %>

                            <!-- Botón Nuevo Usuario -->
                            <button class="btn btn-primary mb-3" onclick="modalUsuario.abrir('nuevo')">
                                <i class="fas fa-plus"></i> Nuevo Usuario
                            </button>

                            <!-- Tabla de Usuarios -->
                            <div class="table-responsive">
                                <table class="table table-striped table-hover table-bordered">
                                    <thead class="table-dark">
                                        <tr>
                                            <th><i class="fas fa-hashtag"></i> ID</th>
                                            <th><i class="fas fa-user"></i> Usuario</th>
                                            <th><i class="fas fa-id-card"></i> Nombre Completo</th>
                                            <th><i class="fas fa-envelope"></i> Email</th>
                                            <th><i class="fas fa-shield-alt"></i> Rol</th>
                                            <th><i class="fas fa-toggle-on"></i> Estado</th>
                                            <th class="text-center"><i class="fas fa-cog"></i> Operaciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% List<Usuario> listaUsuarios = (List<Usuario>)
                                                request.getAttribute("listaUsuarios");
                                                if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                                                for (Usuario usuario : listaUsuarios) {
                                                String badgeEstado = "ACTIVO".equals(usuario.getEstado()) ? "bg-success"
                                                : "bg-danger";
                                                String badgeRol = "ADMIN".equals(usuario.getRol()) ? "bg-warning  text-dark" : "bg-secondary";
                                                %>
                                                <tr>
                                                    <td><code><%=usuario.getIdUsuario()%></code></td>
                                                    <td><strong>
                                                            <%=usuario.getNombreUsuario()%>
                                                        </strong></td>
                                                    <td>
                                                        <%=usuario.getNombreCompleto()%>
                                                    </td>
                                                    <td>
                                                        <%=usuario.getEmail() !=null ? usuario.getEmail() : "-" %>
                                                    </td>
                                                    <td>
                                                        <span class="badge <%=badgeRol%>">
                                                            <%=usuario.getRol()%>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="badge <%=badgeEstado%>">
                                                            <%=usuario.getEstado()%>
                                                        </span>
                                                    </td>
                                                    <td class="text-center">
                                                        <div class="btn-group" role="group">
                                                            <button class="btn btn-warning btn-sm"
                                                                onclick="modalUsuario.abrir('editar', <%=usuario.getIdUsuario()%>)"
                                                                title="Modificar usuario">
                                                                <i class="fas fa-edit"></i>
                                                            </button>
                                                            <button class="btn btn-info btn-sm"
                                                                onclick="modalUsuario.abrir('cambiarPassword', <%=usuario.getIdUsuario()%>)"
                                                                title="Cambiar contraseña">
                                                                <i class="fas fa-key"></i>
                                                            </button>
                                                            <button class="btn btn-danger btn-sm"
                                                                onclick="eliminar(<%=usuario.getIdUsuario()%>)"
                                                                title="Eliminar usuario">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <% } } else { %>
                                                    <tr>
                                                        <td colspan="7" class="text-center text-muted">
                                                            <i class="fas fa-inbox"></i> No hay usuarios registrados
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
                </div>

                <!-- Modal Universal para Usuarios -->
                <div class="modal fade" id="modalUsuario" tabindex="-1" aria-hidden="true" data-bs-backdrop="static"
                    data-bs-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered modal-lg">
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title" id="modalUsuarioLabel">
                                    <i class="fas fa-user-edit"></i> Usuario
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                    id="btnCerrarModal"></button>
                            </div>
                            <div class="modal-body">
                                <div id="loadingSpinner" class="text-center py-4">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="visually-hidden">Cargando...</span>
                                    </div>
                                    <p class="mt-2 text-muted">Cargando formulario...</p>
                                </div>

                                <div id="mensajeModal" class="alert d-none" role="alert"></div>
                                <div id="contenidoModal" style="display: none;"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
                    crossorigin="anonymous"></script>

                <script>
                    function eliminar(id) {
                        if (confirm('¿Está seguro de eliminar este usuario? Esta acción no se puede deshacer.')) {
                            window.location.href = '<%=url%>UsuarioController?op=eliminar&id=' + id;
                        }
                    }
                </script>

            </body>

            </html>