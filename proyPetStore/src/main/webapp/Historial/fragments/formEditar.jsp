<%@ page import="com.proyPetStore.beans.Historial_Medico"%>
<%@ page import="com.proyPetStore.beans.Mascota"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String url = request.getContextPath() + "/";
Historial_Medico historial = (Historial_Medico) request.getAttribute("historial");
List<Mascota> listaMascotas = (List<Mascota>) request.getAttribute("listaMascotas");

if (historial == null) {
	historial = new Historial_Medico();
}
boolean esEditar = historial.getId_historial() > 0;
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title><%=esEditar ? "Editar Historial Médico" : "Nuevo Historial Médico"%></title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="bg-light">

	<div class="container py-4">
		<div class="card shadow">
			<div class="card-body">

				<h4 class="text-primary mb-4 text-center">
					<%=esEditar ? "Editar Historial Médico" : "Nuevo Historial Médico"%>
				</h4>

				<form action="<%=url%>HistorialMedicoController" method="POST"
					onsubmit="return validarHistorial()">
					<input type="hidden" name="op"
						value="<%=esEditar ? "modificar" : "insertar"%>">
					<%
					if (esEditar) {
					%>
					<input type="hidden" name="id_historial"
						value="<%=historial.getId_historial()%>">
					<%
					}
					%>

					<!-- Mascota -->
					<div class="mb-3">
						<label for="id_mascota" class="form-label">Mascota:</label> <select
							name="id_mascota" id="id_mascota" class="form-select" required>
							<option value="">--Seleccione una mascota--</option>
							<%
							if (listaMascotas != null) {
								for (Mascota m : listaMascotas) {
									String selected = (historial.getId_mascota() == m.getId_mascota()) ? "selected" : "";
							%>
							<option value="<%=m.getId_mascota()%>" <%=selected%>>
								<%=m.getNombre_mascota()%>
							</option>
							<%
							}
							}
							%>
						</select>
					</div>

					<!-- Fecha -->
					<div class="mb-3">
						<label for="fecha" class="form-label">Fecha:</label> <input
							type="date" name="fecha" id="fecha" class="form-control"
							value="<%=historial.getFecha() != null ? historial.getFecha() : ""%>"
							required>
					</div>

					<!-- Descripción -->
					<div class="mb-3">
						<label for="descripcion" class="form-label">Descripción:</label>
						<textarea name="descripcion" id="descripcion" class="form-control"
							rows="4" required><%=historial.getDescripcion() != null ? historial.getDescripcion() : ""%></textarea>
					</div>

					<div class="d-flex gap-2">
						<button type="submit" class="btn btn-success w-50">
							<%=esEditar ? "💾 Actualizar" : "💾 Guardar"%>
						</button>
						<a href="<%=url%>HistorialMedicoController?op=listar"
							class="btn btn-secondary w-50"> ← Cancelar </a>
					</div>
				</form>

			</div>
		</div>
	</div>

	<!-- VALIDACIÓN JAVASCRIPT -->
	<script>
		function validarHistorial() {
			let mascota = document.getElementById("id_mascota").value;
			let fecha = document.getElementById("fecha").value.trim();
			let descripcion = document.getElementById("descripcion").value
					.trim();

			if (mascota === "") {
				alert("Seleccione una mascota.");
				return false;
			}
			if (fecha === "") {
				alert("Ingrese la fecha del historial.");
				return false;
			}
			if (descripcion === "") {
				alert("Ingrese la descripción del historial.");
				return false;
			}
			return true;
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
