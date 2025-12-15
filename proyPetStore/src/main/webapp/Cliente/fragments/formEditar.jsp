<%@page import="com.proyPetStore.beans.Cliente"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
String url = request.getContextPath() + "/";
Cliente cliente = (Cliente) request.getAttribute("cliente");

if (cliente == null) {
	cliente = new Cliente();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editar Cliente</title>

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

</head>
<body class="bg-light">

	<div class="container py-4">

		<h2 class="text-center mb-4">✏️ Editar Cliente</h2>

		<div class="card shadow">
			<div class="card-body">

				<form action="<%=url%>ClienteController" method="POST"
					onsubmit="return validarEdicion()">
					<input type="hidden" name="op" value="modificar"> <input
						type="hidden" name="id_cliente"
						value="<%=cliente.getId_cliente()%>">


					<div class="mb-3">
						<label class="form-label">Dni del Cliente</label> <input
							type="text" name="dni" id="dni"
							value="<%=cliente.getDni() != null ? cliente.getDni() : ""%>"
							class="form-control" required>
					</div>



					<div class="mb-3">
						<label class="form-label">Nombre del Cliente</label> <input
							type="text" name="nombre" id="nombre"
							value="<%=cliente.getNombreC()!= null ? cliente.getNombreC() : ""%>"
							class="form-control" required>
					</div>
					<div class="mb-3">
						<label class="form-label">Apellido del Cliente</label> <input
							type="text" name="apellido" id="apellido"
							value="<%=cliente.getApellido() != null ? cliente.getApellido() : ""%>"
							class="form-control" required>
					</div>


					<div class="mb-3">
						<label class="form-label">Teléfono</label> <input type="text"
							name="telefono" id="telefono"
							value="<%=cliente.getTelefono() != null ? cliente.getTelefono() : ""%>"
							class="form-control" required>
					</div>

					<!-- Dirección -->
					<div class="mb-3">
						<label class="form-label">Dirección</label> <input type="text"
							name="direccion" id="direccion"
							value="<%=cliente.getDireccion() != null ? cliente.getDireccion() : ""%>"
							class="form-control" required>
					</div>

					<button type="submit" class="btn btn-primary w-100 mb-2">Guardar
						Cambios</button>

					<a href="<%=url%>ClienteController?op=listar"
						class="btn btn-secondary w-100"> Cancelar </a>

				</form>

			</div>
		</div>

	</div>

	<!-- VALIDACIÓN JS -->
	<script>
		function validarEdicion() {
			let nombre = document.getElementById("nombre").value.trim();
			let apellido = document.getElementById("apellido").value.trim();
			let telefono = document.getElementById("telefono").value.trim();
			let direccion = document.getElementById("direccion").value.trim();

			if (nombre === "") {
				alert("El nombre es obligatorio");
				return false;
			}
			if (apellido === "") {
				alert("El apellido es obligatorio");
				return false;
			}

			if (telefono === "" || telefono.length < 6 || isNaN(telefono)) {
				alert("Ingrese un teléfono válido (solo números, mínimo 6 dígitos)");
				return false;
			}

			if (direccion === "") {
				alert("La dirección es obligatoria");
				return false;
			}

			return true;
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
