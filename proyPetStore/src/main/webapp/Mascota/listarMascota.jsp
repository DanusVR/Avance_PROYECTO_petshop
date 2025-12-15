<%@ page import="com.proyPetStore.beans.Mascota"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String url = request.getContextPath() + "/";
List<Mascota> listarMascota = (List<Mascota>) request.getAttribute("listarMascota");
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Gestión de Mascotas</title>



<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>

<body class="bg-light">

	<div class="container mt-5">

		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="text-center mb-4">🐾 Lista de Mascotas</h2>

			<div class="d-flex justify-content-end mb-3">
				<button class="btn btn-success"
					onclick="modalMascota.abrir('nuevo')">➕ Nueva Mascota</button>
			</div>
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
				<%
				if (listarMascota != null && !listarMascota.isEmpty()) {
					for (Mascota mascota : listarMascota) {
				%>
				<tr>
					<td><%=mascota.getId_mascota()%></td>
					<td><%=mascota.getNombre_mascota()%></td>
					<td><%=mascota.getEspecie()%></td>
					<td><%=mascota.getRaza()%></td>
					<td><%=mascota.getSexo()%></td>
					<td><%=mascota.getEdad()%></td>
					<td><%=mascota.getNombre()%></td>

					<td class="acciones">

						<button
							onclick="modalMascota.abrir('editar', <%=mascota.getId_mascota()%>)"
							class="btn btn-warning btn-sm">Editar</button>							
					 <a	href="<%=request.getContextPath()%>/HistorialMedicoController?op=listarPorMascota&id_mascota=<%=mascota.getId_mascota()%>"
						class="btn btn-info btn-sm"> 🩺 Ver historial </a>
					 <a	href="<%=request.getContextPath()%>/MascotaController?op=eliminar&id=<%=mascota.getId_mascota()%>"
						class="btn btn-danger btn-sm"
						onclick="return confirm('¿Seguro de eliminar esta mascota?')">
							Eliminar </a>
					</td>
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="8" class="text-muted text-center">No hay mascotas
						registradas</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>

	</div>

	<!-- Modal para Nuevo / Editar -->
	<div class="modal fade" id="modalMascota" tabindex="-1"
		aria-labelledby="modalMascotaLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header bg-primary text-white">
					<h5 class="modal-title" id="modalMascotaLabel">Gestión de
						Mascota</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<!-- Aquí se cargará formNuevo.jsp o formEditar.jsp -->
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<!-- JS para cargar dinámicamente los formularios -->
	<script>
        const modalMascota = {
            abrir: function(op, id = null) {
                let url = 'MascotaController?op=' + op;
                if (id) url += '&id=' + id;

                fetch(url)
                    .then(res => res.text())
                    .then(html => {
                        document.querySelector('#modalMascota .modal-body').innerHTML = html;

                        const modal = new bootstrap.Modal(document.getElementById('modalMascota'));
                        modal.show();
                    })
                    .catch(err => console.error("Error al abrir modal:", err));
            }
        };
    </script>

</body>
</html>



