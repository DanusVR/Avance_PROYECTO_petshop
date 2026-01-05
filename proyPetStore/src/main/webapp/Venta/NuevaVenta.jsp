<%@page import="com.proyPetStore.beans.*" %>
	<%@page import="java.util.List" %>
		<%@ page contentType="text/html; charset=UTF-8" %>
			<!DOCTYPE html>
			<html>

			<head>
				<title>Nueva Venta</title>
				<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
				<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
					rel="stylesheet">
				<style>
					body {
						background: #f5f7fa;
					}

					.card {
						border-radius: 18px;
						border: none;
						box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.07);
					}

					.title {
						font-weight: 700;
						color: #444;
					}

					.btn-pet {
						background: #5B8DEF;
						color: white;
						border-radius: 12px;
						font-weight: bold;
					}

					.btn-pet:hover {
						background: #4676db;
						color: white;
					}

					.table thead {
						background: #5B8DEF;
						color: white;
					}
				</style>
			</head>

			<body>
				<div class="container py-4">
					<h2 class="title mb-4">
						<i class="bi bi-receipt-cutoff"></i> Nueva Venta
					</h2>

					<div class="card p-4">

						<!-- Mensaje de error -->
						<% String error=(String) request.getAttribute("error"); if (error !=null) { %>
							<div class="alert alert-danger">
								<%=error%>
							</div>
							<% } %>

								<!-- FORM: Agregar Ítem -->
								<form action="VentaController" method="post" onsubmit="submitVentaForm(event)">
									<input type="hidden" name="op" value="agregar">

									<div class="row g-3">

										<!-- Cliente -->
										<div class="col-md-6">
											<label class="form-label fw-bold">Cliente</label> <select
												class="form-select" name="id_Cliente">
												<% List<Cliente> clientes = (List<Cliente>)
														request.getAttribute("clientes");
														if (clientes != null) {
														for (Cliente c : clientes) {
														%>
														<option value="<%=c.getId_cliente()%>">
															<%=c.getNombreC()%>
														</option>
														<% } } %>
											</select>
										</div>

										<!-- Tipo -->
										<div class="col-md-4">
											<label class="form-label fw-bold">Tipo</label> <select name="tipo" id="tipo"
												class="form-select" onchange="mostrarCampos()">
												<option value="producto">Producto</option>
												<option value="servicio">Servicio</option>
											</select>
										</div>

										<!-- Productos -->
										<div class="col-md-4" id="divProd">
											<label class="form-label fw-bold">Producto</label> <select
												name="id_Producto" class="form-select">
												<% List<Producto> productos = (List<Producto>)
														request.getAttribute("productos");
														if (productos != null) {
														for (Producto p : productos) {
														%>
														<option value="<%=p.getId_producto()%>">
															<%=p.getNombre()%>
																– $<%=String.format("%.2f", p.getPrecio_venta())%>
														</option>
														<% } } %>
											</select>
										</div>

										<div class="col-md-2" id="divCant">
											<label class="form-label fw-bold">Cantidad</label> <input type="number"
												class="form-control" name="cantidad" value="1" min="1">
										</div>

										<!-- Servicios -->
										<div class="col-md-6" id="divServ" style="display: none;">
											<label class="form-label fw-bold">Servicio</label> <select
												name="id_Servicio" class="form-select">
												<% List<Servicio> servicios = (List<Servicio>)
														request.getAttribute("servicios");
														if (servicios != null) {
														for (Servicio s : servicios) {
														%>
														<option value="<%=s.getId_servicio()%>">
															<%=s.getNombre()%>
																– $<%=String.format("%.2f", s.getPrecio())%>
														</option>
														<% } } %>
											</select>
										</div>

										<div class="col-md-12 mt-3">
											<button class="btn btn-pet px-4">
												<i class="bi bi-plus-circle"></i> Agregar Ítem
											</button>
										</div>
									</div>
								</form>

								<hr class="my-4">

								<!-- Detalle de Venta -->
								<h5 class="title">
									<i class="bi bi-basket"></i> Detalle de Venta
								</h5>
								<div class="table-responsive mt-3">
									<table class="table table-bordered align-middle">
										<thead>
											<tr>
												<th>Tipo</th>
												<th>Descripción</th>
												<th>Cant.</th>
												<th>Precio</th>
												<th>Subtotal</th>
											</tr>
										</thead>
										<tbody>
											<% List<Detalle_Venta> lista = (List<Detalle_Venta>)
													request.getAttribute("detalle");
													if (lista != null) {
													for (Detalle_Venta d : lista) {
													%>
													<tr>
														<td>
															<%=d.getId_producto() !=null && d.getId_producto()> 0 ?
																"Producto" : "Servicio"%>
														</td>
														<td>
															<%=d.getId_producto() !=null && d.getId_producto()> 0 ?
																d.getNombre_producto() : d.getNombre_servicio()%>
														</td>
														<td>
															<%=d.getCantidad() !=null ? d.getCantidad() : 0%>
														</td>
														<td>$<%=d.getPrecio() !=null ? String.format("%.2f",
																d.getPrecio()) : "0.00" %>
														</td>
														<td>$<%=d.getSubtotal() !=null ? String.format("%.2f",
																d.getSubtotal()) : "0.00" %>
														</td>
													</tr>
													<% } } %>
										</tbody>

									</table>
								</div>

								<!-- Formulario Registrar Venta -->
								<form action="VentaController" method="post" onsubmit="submitVentaForm(event)">
									<input type="hidden" name="op" value="registrar"> <input type="hidden"
										name="id_Cliente" value="<%=request.getParameter(" id_Cliente") !=null ?
										request.getParameter("id_Cliente") : "" %>">

									<div class="row g-3 mt-3">
										<div class="col-md-6">
											<label class="form-label fw-bold">Tipo de Pago</label> <select
												name="tipo_pago" class="form-select" required>
												<option value="Efectivo">Efectivo</option>
												<option value="Yape">Yape</option>
												<option value="Plin">Plin</option>
											</select>
										</div>
										<div class="col-md-6">
											<label class="form-label fw-bold">Monto Pagado</label> <input type="number"
												step="0.01" name="monto_pagado" class="form-control" required>
										</div>
									</div>

									<div class="text-end mt-3">
										<h4>
											Total: <span class="text-success fw-bold">$<%=String.format("%.2f",
													request.getAttribute("total"))%></span>
										</h4>
									</div>

									<button class="btn btn-success btn-lg mt-2">
										<i class="bi bi-check-circle"></i> Registrar Venta
									</button>
								</form>
					</div>
				</div>

				<script>
					function mostrarCampos() {
						const tipo = document.getElementById("tipo").value;
						const divProd = document.getElementById("divProd");
						if (divProd) divProd.style.display = tipo === "producto" ? "block" : "none";

						const divCant = document.getElementById("divCant");
						if (divCant) divCant.style.display = tipo === "producto" ? "block" : "none";

						const divServ = document.getElementById("divServ");
						if (divServ) divServ.style.display = tipo === "servicio" ? "block" : "none";
					}

					function submitVentaForm(event) {
						event.preventDefault();
						const form = event.target;
						const formData = new FormData(form);
						const params = new URLSearchParams();
						for (const pair of formData.entries()) {
							params.append(pair[0], pair[1]);
						}

						fetch(form.action, {
							method: 'POST',
							body: params,
							headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
						})
							.then(response => response.text())
							.then(html => {
								const cont = document.getElementById("contenidoPrincipal");
								cont.innerHTML = html;
								// Re-execute scripts logic if needed, or simply calling functionality
								// Since the response is the full JSP fragment, scripts inside it need to run 
								// for showing/hiding fields again.
								// Extract and run scripts
								const scripts = cont.querySelectorAll("script");
								scripts.forEach(oldScript => {
									const newScript = document.createElement("script");
									newScript.text = oldScript.innerHTML;
									oldScript.parentNode.replaceChild(newScript, oldScript);
								});
								// Trigger onload manually
								mostrarCampos();
							})
							.catch(err => console.error("Error:", err));
					}

					// Initial call
					mostrarCampos();
				</script>


			</body>

			</html>