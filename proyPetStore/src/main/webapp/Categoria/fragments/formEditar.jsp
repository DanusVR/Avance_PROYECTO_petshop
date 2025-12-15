<%@page import="com.proyPetStore.beans.Categoria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String url = request.getContextPath() + "/";
Categoria categoria = (Categoria) request.getAttribute("categoria");

if (categoria == null) {
	categoria = new Categoria();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editar Categoría</title>

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

</head>
<body class="bg-light">

	<div class="container py-4">

		<h2 class="text-center mb-4">✏️ Editar Categoría</h2>

		<div class="card shadow">
			<div class="card-body">

				<form action="<%=url%>CategoriaController" method="POST" onsubmit="return validarEdicion()">
					<input type="hidden" name="op" value="modificar">
					<input type="hidden" name="id_categoria" value="<%=categoria.getId_categoria()%>">

					<div class="mb-3">
						<label class="form-label">Nombre de Categoría</label>
						<input type="text" name="nombreCat" id="nombreCat"
							value="<%=categoria.getNombreCat() != null ? categoria.getNombreCat() : ""%>"
							class="form-control" required>
					</div>

					<button type="submit" class="btn btn-primary w-100 mb-2">Guardar Cambios</button>
					<a href="<%=url%>CategoriaController?op=listar" class="btn btn-secondary w-100">Cancelar</a>

				</form>

			</div>
		</div>

	</div>

	<!-- VALIDACIÓN JS -->
	<script>
		function validarEdicion() {
			let nombreCat = document.getElementById("nombreCat").value.trim();		
			if (nombreCat === "") {
				alert("El nombre de la categoría es obligatorio");
				return false;
			}	
			return true;
		}
	</script>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

