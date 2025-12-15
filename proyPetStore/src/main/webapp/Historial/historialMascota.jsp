<%@ page import="com.proyPetStore.beans.Historial_Medico" %>
<%@ page import="com.proyPetStore.beans.Mascota" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String url = request.getContextPath() + "/";
    List<Historial_Medico> listaHistorial = (List<Historial_Medico>) request.getAttribute("listaHistorial");
    Mascota mascota = (Mascota) request.getAttribute("mascota");
    String nombreMascota = mascota != null ? mascota.getNombre_mascota() : "";
    int idMascota = mascota != null ? mascota.getId_mascota() : 0;
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Historial Médico de <%= nombreMascota %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2 class="text-primary">📋 Historial Médico de <%= nombreMascota %></h2>
        <div>
            <button class="btn btn-success me-2" onclick="modalHistorial.abrir('nuevo', <%= idMascota %>)">
                ➕ Agregar Historial
            </button>
            <a href="<%= url %>MascotaController?op=listar" class="btn btn-secondary">← Volver a Mascotas</a>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-striped table-hover table-bordered align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Fecha</th>
                    <th>Descripción</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% if(listaHistorial != null && !listaHistorial.isEmpty()) {
                    for(Historial_Medico h : listaHistorial) { %>
                <tr>
                    <td><%= h.getId_historial() %></td>
                    <td><%= h.getFecha() %></td>
                    <td>
                        <%= h.getDescripcion() %>
                        <%-- Marca si fue generado automáticamente por un servicio --%>
                        <% if(h.getDescripcion() != null && h.getDescripcion().startsWith("Servicio:")) { %>
                            <span class="badge bg-info text-dark">Automático</span>
                        <% } %>
                    </td>
                    <td>
                        <button class="btn btn-warning btn-sm me-1"
                            onclick="modalHistorial.abrir('editar', <%= h.getId_historial() %>)">
                            ✏️ Editar
                        </button>
                        <a href="<%= url %>HistorialMedicoController?op=eliminar&id_historial=<%= h.getId_historial() %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('¿Seguro de eliminar este historial?');">
                           🗑️ Eliminar
                        </a>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="4" class="text-center text-muted">No hay historiales registrados para esta mascota.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

</div>

<!-- Modal para Nuevo / Editar Historial -->
<div class="modal fade" id="modalHistorial" tabindex="-1" aria-labelledby="modalHistorialLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="modalHistorialLabel">Gestión de Historial Médico</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <!-- Aquí se cargará formNuevo.jsp o formEditar.jsp dinámicamente -->
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script>
// Objeto para abrir modal y cargar formularios dinámicamente
const modalHistorial = {
    abrir: function(op, id = null) {
        let url = 'HistorialMedicoController?op=' + op;
        if (op === 'nuevo') url += '&id_mascota=' + id;
        if (id && op === 'editar') url += '&id_historial=' + id;

        fetch(url)
            .then(res => res.text())
            .then(html => {
                document.querySelector('#modalHistorial .modal-body').innerHTML = html;
                const modal = new bootstrap.Modal(document.getElementById('modalHistorial'));
                modal.show();
            })
            .catch(err => console.error("Error al abrir modal:", err));
    }
};
</script>

</body>
</html>
