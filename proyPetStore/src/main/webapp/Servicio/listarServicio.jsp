<%@page import="com.proyPetStore.beans.Servicio"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestión de Servicios</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

</head>
<body class="bg-light">

	<div class="container mt-5">

		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="text-primary">Gestión de Servicios</h2>

			<div class="d-flex justify-content-end mb-3">
				<button class="btn btn-success"
					onclick="modalServicio.abrir('nuevo')">➕ Nuevo Servicio</button>
			</div>
		</div>

		<div class="card shadow">
			<div class="card-body">

				<table class="table table-striped table-hover align-middle">
					<thead class="table-dark">
						<tr>
							<th>ID</th>
							<th>NOMBRE</th>
							<th>TIPO</th>
							<th>MASCOTA</th>							
							<th>DESCRIPCIÓN</th>
							<th>PRECIO</th>
							<th>ESTADO</th>
							<th>ACCIONES</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Servicio> listarServicio = (List<Servicio>) request.getAttribute("listarServicio");
						if (listarServicio != null && !listarServicio.isEmpty()) {
							for (Servicio s : listarServicio) {
						%>
						<tr>
							<td><%=s.getId_servicio()%></td>
							<td><%=s.getNombre()%></td>
							<td><%=s.getTipo()%></td>

							<!-- NUEVO: Mostrar nombre mascota -->
							<td><%=s.getNombreMascota() != null ? s.getNombreMascota() : "Sin mascota"%></td>

							<td><%=s.getDescripcion()%></td>
							<td>S/ <%=s.getPrecio()%></td>
							<td><span
								class="badge <%=s.getEstado().equals("Activo") ? "bg-success" : "bg-secondary"%>">
									<%=s.getEstado()%>
							</span></td>

							<td>
								<button
									onclick="modalServicio.abrir('editar', <%=s.getId_servicio()%>)"
									class="btn btn-warning btn-sm">Editar</button> <a
								href="<%=request.getContextPath()%>/ServicioController?op=eliminar&id=<%=s.getId_servicio()%>"
								class="btn btn-danger btn-sm"
								onclick="return confirm('¿Seguro de eliminar este servicio?')">
									Eliminar </a>
							</td>
						</tr>

						<%
						}
						} else {
						%>
						<tr>
							<td colspan="8" class="text-center text-muted py-3">No hay
								servicios registrados.</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>

			</div>
		</div>

	</div>

	<!-- Modal para Gestión de Servicio-->
	<div class="modal fade" id="modalServicio" tabindex="-1"
		aria-labelledby="modalServicioLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header bg-primary text-white">
					<h5 class="modal-title" id="modalServicioLabel">Gestión de
						Servicio</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<!-- Se cargará formNuevoServicio.jsp o formEditarServicio.jsp -->
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
        const modalServicio = {
            abrir: function(op, id = null) {
                let url = 'ServicioController?op=' + op;
                if (id) url += '&id=' + id;

                fetch(url)
                    .then(res => res.text())
                    .then(html => {
                        const modalBody = document.querySelector('#modalServicio .modal-body');
                        modalBody.innerHTML = html;

                        const modal = new bootstrap.Modal(document.getElementById('modalServicio'));
                        modal.show();
                    })
                    .catch(err => console.error("Error al abrir modal:", err));
            }
        };
    </script>

</body>
</html>




