<%@page import="com.proyPetStore.beans.Producto" %>
    <%@page import="java.util.List" %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Gestión de Productos</title>

                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

            </head>

            <body class="bg-light">

                <div class="container mt-5">

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="text-primary">Gestión de Productos</h2>

                        <div class="d-flex justify-content-end mb-3">
                            <button class="btn btn-success" onclick="modalProducto.abrir('nuevo')">➕ Nuevo
                                Producto</button>
                        </div>
                    </div>

                    <div class="card shadow">
                        <div class="card-body">

                            <table class="table table-striped table-hover align-middle">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>NOMBRE</th>
                                        <th>CATEGORÍA</th>
                                        <th>DESCRIPCIÓN</th>
                                        <th>STOCK</th>
                                        <th>PRECIO COSTO</th>
                                        <th>PRECIO VENTA</th>
                                        <th>ESTADO</th>
                                        <th>ACCIONES</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Producto> listarProducto = (List<Producto>)
                                            request.getAttribute("listarProducto");
                                            if (listarProducto != null && !listarProducto.isEmpty()) {
                                            for (Producto p : listarProducto) {
                                            %>
                                            <tr>
                                                <td>
                                                    <%=p.getId_producto()%>
                                                </td>
                                                <td>
                                                    <%=p.getNombre()%>
                                                </td>
                                                <td>
                                                    <%=p.getNombreCat()%>
                                                </td>
                                                <td>
                                                    <%=p.getDescripcion()%>
                                                </td>
                                                <td>
                                                    <%=p.getStock()%>
                                                </td>

                                                <td>S/ <%=String.format("%.2f", p.getPrecio_costo())%>
                                                </td>
                                                <td>S/ <%=String.format("%.2f", p.getPrecio_venta())%>
                                                </td>

                                                <td>
                                                    <span class="badge <%= p.getEstado().equals(" Activo")
                                                        ? "bg-success" : "bg-secondary" %>">
                                                        <%=p.getEstado()%>
                                                    </span>

                                                </td>

                                                <td class="acciones">

                                                    <button
                                                        onclick="modalProducto.abrir('editar', <%=p.getId_producto()%>)"
                                                        class="btn btn-warning btn-sm">✏ Editar</button>

                                                    <a href="<%=request.getContextPath()%>/ProductoController?op=eliminar&id=<%=p.getId_producto()%>"
                                                        class="btn btn-danger btn-sm"
                                                        onclick="return confirm('¿Seguro de eliminar este producto?')">
                                                        🗑 Eliminar
                                                    </a>
                                                </td>
                                            </tr>
                                            <% } } else { %>
                                                <tr>
                                                    <td colspan="9" class="text-center text-muted py-3">No hay productos
                                                        registrados.</td>
                                                </tr>
                                                <% } %>
                                </tbody>
                            </table>

                        </div>
                    </div>

                </div>

                <!-- Modal para gestión de producto -->
                <div class="modal fade" id="modalProducto" tabindex="-1" aria-labelledby="modalProductoLabel"
                    aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title" id="modalProductoLabel">Gestión de Producto</h5>
                                <button type="button" class="btn-close btn-close-white"
                                    data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <!-- Se carga dinámicamente formNuevo.jsp o formEditar.jsp -->
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Toast para mensajes -->
                <% String mensaje=(String) session.getAttribute("mensaje"); if (mensaje !=null) {
                    session.removeAttribute("mensaje"); %>
                    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
                        <div id="toastMensaje" class="toast align-items-center text-bg-<%= mensaje.contains(" Error")
                            ? "danger" : "success" %> border-0" role="alert">
                            <div class="d-flex">
                                <div class="toast-body">
                                    <%= mensaje %>
                                </div>
                                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                                    data-bs-dismiss="toast"></button>
                            </div>
                        </div>
                    </div>
                    <% } %>

                        <!-- Bootstrap JS -->
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>



            </body>

            </html>