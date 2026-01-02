<%@page import="com.proyPetStore.beans.Cliente"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestión de Clientes</title>


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

</head>
<body class="bg-light">

	<div class="container mt-5">

		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="text-primary">Gestión de Clientes</h2>

			<div class="d-flex justify-content-end mb-3">
            <button class="btn btn-success" onclick="modalCliente.abrir('nuevo')"> ➕ Nuevo Cliente </button>
        </div>
		</div>

		<div class="card shadow">
			<div class="card-body">

				<table class="table table-striped table-hover align-middle">
					<thead class="table-dark">
						<tr>
							<th>ID</th>
							<th>DNI</th>
							<th>NOMBRE</th>
							<th>APELLIDO</th>
							<th>TELÉFONO</th>
							<th>DIRECCIÓN</th>
							<th>ACCIONES</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Cliente> listarCliente = (List<Cliente>) request.getAttribute("listarCliente");
						if (listarCliente != null && !listarCliente.isEmpty()) {
							for (Cliente cliente : listarCliente) {
						%>
						<tr>
							<td><%=cliente.getId_cliente()%></td>
							<td><%=cliente.getDni()%></td>
							<td><%=cliente.getNombreC()%></td>
							<td><%=cliente.getApellido()%></td>
							<td><%=cliente.getTelefono()%></td>
							<td><%=cliente.getDireccion()%></td>
							<td class="acciones">
							<!--  -->
								<button
									onclick="modalCliente.abrir('editar', <%=cliente.getId_cliente()%>)"
									class="btn btn-warning btn-sm">Editar</button> 
									<a
								href="<%=request.getContextPath()%>/ClienteController?op=eliminar&id=<%=cliente.getId_cliente()%>"
								class="btn btn-danger btn-sm"
								onclick="return confirm('¿Seguro de eliminar este cliente?')">
									Eliminar </a>
							</td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="6" class="text-center text-muted py-3">No hay
								clientes registrados.</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>

			</div>
		</div>

	</div>
	<!-- Modal para Gestión de Cliente-->
	<div class="modal fade" id="modalCliente" tabindex="-1"
		aria-labelledby="modalClienteLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header bg-primary text-white">
					<h5 class="modal-title" id="modalClienteLabel">Gestión de
						Cliente</h5>
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
        const modalCliente = {
            abrir: function(op, id = null) {
                let url = 'ClienteController?op=' + op;
                if (id) url += '&id=' + id;

                fetch(url)
                    .then(res => res.text())
                    .then(html => {
                        const modalBody = document.querySelector('#modalCliente .modal-body');
                        modalBody.innerHTML = html;

                        const modal = new bootstrap.Modal(document.getElementById('modalCliente'));
                        modal.show();
                    })
                    .catch(err => console.error("Error al abrir modal:", err));
            }
        };
    </script>
</body>
</html>



