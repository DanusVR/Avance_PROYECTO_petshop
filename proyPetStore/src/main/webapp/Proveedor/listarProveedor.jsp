<%@page import="com.proyPetStore.beans.Proveedor"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Proveedores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">

    <div class="d-flex justify-content-between mb-4">
        <h2 class="text-primary">Gestión de Proveedores</h2>
        <button class="btn btn-success" onclick="modalProveedor.abrir('nuevo')">➕ Nuevo Proveedor</button>
    </div>

    <div class="card shadow">
        <div class="card-body">
            <table class="table table-striped table-hover align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>RUC</th>
                        <th>NOMBRE</th>
                        <th>TELÉFONO</th>
                        <th>CORREO</th>
                        <th>DIRECCIÓN</th>
                        <th>TIPO</th>
                        <th>ACCIONES</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<Proveedor> lista = (List<Proveedor>) request.getAttribute("listarProveedor");
                    if (lista != null && !lista.isEmpty()) {
                        for (Proveedor p : lista) {
                %>
                    <tr>
                        <td><%=p.getIdProveedor()%></td>
                        <td><%=p.getRuc()%></td>
                        <td><%=p.getNombre()%></td>
                        <td><%=p.getTelefono()%></td>
                        <td><%=p.getCorreo()%></td>
                        <td><%=p.getDireccion()%></td>
                        <td><%=p.getTipo()%></td>
                        <td>
                            <button class="btn btn-warning btn-sm"
                                onclick="modalProveedor.abrir('editar', <%=p.getIdProveedor()%>)">Editar</button>
                            <a href="<%=request.getContextPath()%>/ProveedorController?op=eliminar&id=<%=p.getIdProveedor()%>"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Eliminar proveedor?')">Eliminar</a>
                        </td>
                    </tr>
                <% } } else { %>
                    <tr>
                        <td colspan="8" class="text-center text-muted py-3">No hay proveedores registrados.</td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal para Proveedor -->
<div class="modal fade" id="modalProveedor" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Gestión Proveedor</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <!-- Aquí se cargará dinámicamente formNuevo.jsp o formEditar.jsp -->
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
var modalProveedor = {
    abrir: function(accion, id=0){
        var url = "ProveedorController?op=" + (accion === 'nuevo' ? 'nuevo' : 'editar&id=' + id);
        $.get(url, function(data){
            $('#modalProveedor .modal-body').html(data);
            var modal = new bootstrap.Modal(document.getElementById('modalProveedor'));
            modal.show();
        });
    }
};
</script>

</body>
</html>
