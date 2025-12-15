<%@page import="com.proyPetStore.beans.Categoria"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestión de Categoria</title>


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

</head>
<body class="bg-light">

	<div class="container mt-5">

		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="text-primary">Gestión de Categoria</h2>

			<div class="d-flex justify-content-end mb-3">
            <button class="btn btn-success" onclick="modalCategoria.abrir('nuevo')"> ➕ Nuevo Categoria </button>
        </div>
		</div>

		<div class="card shadow">
			<div class="card-body">

				<table class="table table-striped table-hover align-middle">
					<thead class="table-dark">
						<tr>
							<th>ID</th>							
							<th>CATEGORIA</th>							
							<th>ACCIONES</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Categoria> listarCategoria = (List<Categoria>) request.getAttribute("listarCategoria");
						if (listarCategoria != null && !listarCategoria.isEmpty()) {
							for (Categoria cat : listarCategoria) {
						%>
						<tr>
							<td><%=cat.getId_categoria()%></td>							
							<td><%=cat.getNombreCat()%></td>
							
							<td class="acciones">
								<button
									onclick="modalCategoria.abrir('editar', <%=cat.getId_categoria()%>)"
									class="btn btn-warning btn-sm">Editar</button> <a
								href="<%=request.getContextPath()%>/CategoriaController?op=eliminar&id=<%=cat.getId_categoria()%>"
								class="btn btn-danger btn-sm"
								onclick="return confirm('¿Seguro de eliminar este categoria?')">
									Eliminar </a>
							</td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="6" class="text-center text-muted py-3">No hay
								categoria registrados.</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>

			</div>
		</div>

	</div>
	<!-- Modal para Gestión de Mascota -->
	<div class="modal fade" id="modalCategoria" tabindex="-1"
		aria-labelledby="modalCategoriaLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header bg-primary text-white">
					<h5 class="modal-title" id="modalCategoriaLabel">Gestión de
						Categoria</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- Aquí se cargará dinámicamente formNuevo.jsp o formEditar.jsp -->
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        const modalCategoria = {
            abrir: function(op, id = null) {
                let url = 'CategoriaController?op=' + op;
                if (id) url += '&id=' + id;

                fetch(url)
                    .then(res => res.text())
                    .then(html => {
                        const modalBody = document.querySelector('#modalCategoria .modal-body');
                        modalBody.innerHTML = html;

                        const modal = new bootstrap.Modal(document.getElementById('modalCategoria'));
                        modal.show();
                    })
                    .catch(err => console.error("Error al abrir modal:", err));
            }
        };
    </script>
</body>
</html>



