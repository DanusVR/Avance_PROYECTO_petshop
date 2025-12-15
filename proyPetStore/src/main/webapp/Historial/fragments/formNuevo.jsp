<%@ page import="com.proyPetStore.beans.Mascota"%>
<%@ page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%
List<Mascota> listaMascotas = (List<Mascota>) request.getAttribute("listaMascotas");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nuevo Historial Médico</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="bg-light">

	<div class="container py-4">
		<h2 class="text-center mb-4">🩺 Registrar Nuevo Historial Médico</h2>

		<div class="card shadow col-md-6 mx-auto">
			<div class="card-body">
				<form
					action="<%=request.getContextPath()%>/HistorialMedicoController?op=insertar"
					method="post" onsubmit="return validarHistorial()">

					<!-- Mascota -->
					<div class="mb-3">
						<label class="form-label">Mascota:</label> <select
							name="id_mascota" class="form-select" required>
							<option value="">-- Seleccione una mascota --</option>
							<%
							if (listaMascotas != null) {
								for (Mascota m : listaMascotas) {
							%>
							<option value="<%=m.getId_mascota()%>">
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
						<label class="form-label">Fecha:</label> <input type="date"
							name="fecha" class="form-control" required>
					</div>

					<!-- Descripción -->
					<div class="mb-3">
						<label class="form-label">Descripción:</label>
						<textarea name="descripcion" class="form-control" rows="4"
							required></textarea>
					</div>

					<button type="submit" class="btn btn-primary w-100">💾
						Guardar</button>
				</form>

				<br> <a
					href="<%=request.getContextPath()%>/HistorialMedicoController?op=listar"
					class="btn btn-secondary w-100"> ← Volver a la Lista </a>

			</div>
		</div>
	</div>

	<!-- Validación simple -->
	<script>
		function validarHistorial() {
			let mascota = document.querySelector('select[name="id_mascota"]').value;
			let fecha = document.querySelector('input[name="fecha"]').value;
			let descripcion = document
					.querySelector('textarea[name="descripcion"]').value.trim();

			if (mascota === "") {
				alert("Seleccione una mascota.");
				return false;
			}
			if (fecha === "") {
				alert("Ingrese la fecha.");
				return false;
			}
			if (descripcion.length < 5) {
				alert("La descripción debe tener al menos 5 caracteres.");
				return false;
			}

			return true;
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
