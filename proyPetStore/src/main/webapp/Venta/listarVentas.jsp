<%@page import="com.proyPetStore.beans.Venta" %>
	<%@page import="java.util.List" %>
		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<title>Gestión de Ventas</title>
				<!-- Bootstrap -->
				<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
				<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
			</head>

			<body class="bg-light">

				<div class="container mt-5">

					<!-- Header -->
					<div class="d-flex justify-content-between align-items-center mb-4">
						<h2 class="text-primary">Gestión de Ventas</h2>
						<a href="<%=request.getContextPath()%>/VentaController?op=nuevo" class="btn btn-success"> ➕
							Nueva Venta </a>
					</div>

					<!-- Tabla de Ventas -->
					<table class="table table-striped table-hover align-middle">
						<thead class="table-dark">
							<tr>
								<th>ID</th>
								<th>Cliente</th>
								<th>Fecha</th>
								<th>Total</th>
								<th>Tipo de Pago</th>
								<th>Acciones</th>
							</tr>
						</thead>
						<tbody>
							<% List<Venta> listaVentas = (List<Venta>) request.getAttribute("listarVentas");
									if (listaVentas != null && !listaVentas.isEmpty()) {
									for (Venta v : listaVentas) {
									%>
									<tr>
										<td>
											<%=v.getId_venta()%>
										</td>
										<td>
											<%=v.getNombreCliente() !=null ? v.getNombreCliente() : "-" %>
										</td>
										<td>
											<%=v.getFecha() !=null ? v.getFecha() : "-" %>
										</td>
										<td>$<%=String.format("%.2f", v.getTotal())%>
										</td>
										<td>
											<%=v.getTipo_pago() !=null ? v.getTipo_pago() : "-" %>
										</td>
										<td>

											<button class="btn btn-primary btn-sm"
												onclick="modalReciboFunc.abrir(<%=v.getId_venta()%>)">
												Ver Recibo</button>
											<a href="<%=request.getContextPath()%>/VentaController?op=eliminar&id=<%=v.getId_venta()%>"
												class="btn btn-danger btn-sm"
												onclick="return confirm('¿Seguro de eliminar esta venta?')">
												🗑 Eliminar </a>
										</td>
									</tr>
									<% } } else { %>
										<tr>
											<td colspan="6" class="text-center text-muted py-3">No hay
												ventas registradas.</td>
										</tr>
										<% } %>
						</tbody>
					</table>
				</div>


				<!-- Modal Recibo -->
				<div class="modal fade" id="modalRecibo" tabindex="-1" aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header bg-primary text-white">
								<h5 class="modal-title">Recibo de Venta</h5>
								<button type="button" class="btn-close btn-close-white"
									data-bs-dismiss="modal"></button>
							</div>
							<div class="modal-body">Cargando
								recibo...</div>
						</div>
					</div>
				</div>

				<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

				<script>
					const modalReciboFunc = {
						abrir: function (idVenta) {
							let url = 'VentaController?op=verRecibo&idVenta=' + idVenta;

							fetch(url)
								.then(res => res.text())
								.then(html => {
									document.querySelector('#modalRecibo .modal-body').innerHTML = html;
									new bootstrap.Modal(document.getElementById('modalRecibo')).show();
								})
								.catch(err => console.error("Error Recibo:", err));
						}
					};

				</script>

			</body>

			</html>