<%@page import="com.proyPetStore.beans.Cita"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestión de Citas</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    rel="stylesheet">

</head>
<body class="bg-light">

<div class="container mt-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-primary">Gestión de Citas</h2>

        <button class="btn btn-success" onclick="modalCita.abrir('nuevo')">
            ➕ Nueva Cita
        </button>
    </div>

    <div class="card shadow">
        <div class="card-body">

            <table class="table table-striped table-hover align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>MASCOTA</th>
                        <th>SERVICIO</th>
                        <th>FECHA</th>
                        <th>HORA</th>
                        <th>ESTADO</th>
                        <th>OBSERVACIÓN</th>
                        <th>ACCIONES</th>
                    </tr>
                </thead>

                <tbody>
                <%
                List<Cita> lista = (List<Cita>) request.getAttribute("listarCita");

                if (lista != null && !lista.isEmpty()) {
                    for (Cita c : lista) {

                        String estado = c.getEstado();
                        String badgeColor = "bg-secondary";

                        if ("Pendiente".equalsIgnoreCase(estado)) badgeColor = "bg-info";
                        if ("Atendido".equalsIgnoreCase(estado)) badgeColor = "bg-success";
                        if ("Cancelado".equalsIgnoreCase(estado)) badgeColor = "bg-danger";
                %>

                <tr>
                    <td><%= c.getId_cita() %></td>
                    <td><%= c.getMascota() %></td>
                    <td><%= c.getServicio() %></td>
                    <td><%= c.getFecha() %></td>
                    <td><%= c.getHora() %></td>

                    <td><span class="badge <%=badgeColor%>"><%=estado%></span></td>

                    <td><%= c.getObservacion() == null ? "" : c.getObservacion() %></td>

                    <td>
                        <button 
                            onclick="modalCita.abrir('editar', <%=c.getId_cita()%>)"
                            class="btn btn-warning btn-sm">
                            Editar
                        </button>

                        <a href="<%=request.getContextPath()%>/CitaController?op=eliminar&id=<%=c.getId_cita()%>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('¿Seguro de eliminar esta cita?')">
                            Eliminar
                        </a>
                    </td>
                </tr>

                <% 
                    }
                } else { 
                %>

                <tr>
                    <td colspan="8" class="text-center text-muted py-3">
                        No hay citas registradas.
                    </td>
                </tr>

                <% } %>

                </tbody>
            </table>

        </div>
    </div>

</div>

<!-- Modal Contenedor -->
<div class="modal fade" id="modalCita" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 id="modalCitaLabel" class="modal-title">Gestión de Cita</h5>
                <button type="button" class="btn-close btn-close-white"
                    data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <!-- Aquí se carga el formulario -->
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const modalCita = {
        abrir(op, id = null) {
            let url = 'CitaController?op=' + op;
            if (id) url += '&id=' + id;

            fetch(url)
                .then(r => r.text())
                .then(html => {
                    document.querySelector('#modalCita .modal-body').innerHTML = html;
                    new bootstrap.Modal(document.getElementById('modalCita')).show();
                })
                .catch(e => console.error("Error:", e));
        }
    };
</script>

</body>
</html>
