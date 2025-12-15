<%@page import="com.proyPetStore.beans.Producto"%>
<%@page import="com.proyPetStore.beans.Categoria"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>

<%
List<Categoria> listarCategoria = (List<Categoria>) request.getAttribute("listarCategoria");
Producto producto = (Producto) request.getAttribute("producto");

if (producto == null) {
	producto = new Producto();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nuevo Producto</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="bg-light">

	<div class="container py-4">
		<h2 class="text-center mb-4">🛒 Registrar Nuevo Producto</h2>

		<div class="card shadow">
			<div class="card-body">
				<form action="<%=request.getContextPath()%>/ProductoController"
					method="post" onsubmit="return validarProducto()">
					<input type="hidden" name="op" value="insertar">

					<div class="mb-3">
						<label class="form-label">Nombre del Producto:</label> <input
							type="text" id="nombre" name="nombre" class="form-control"
							value="<%=producto.getNombre() != null ? producto.getNombre() : ""%>"
							required>
					</div>

					<div class="mb-3">
						<label class="form-label">Categoría:</label> <select
							name="id_categoria" id="id_categoria" class="form-control"
							required>
							<option value="">-- Seleccione una categoría --</option>
							<%
							if (listarCategoria != null && !listarCategoria.isEmpty()) {
								for (Categoria c : listarCategoria) {
									String selected = (producto.getId_categoria() == c.getId_categoria()) ? "selected" : "";
							%>
							<option value="<%=c.getId_categoria()%>" <%=selected%>><%=c.getNombreCat()%></option>
							<%
							}
							}
							%>
						</select>
					</div>

					<div class="mb-3">
						<label class="form-label">Descripción:</label>
						<textarea id="descripcion" name="descripcion" class="form-control"
							rows="3"><%=producto.getDescripcion() != null ? producto.getDescripcion() : ""%></textarea>
					</div>

					<div class="mb-3">
						<label class="form-label">Stock:</label> <input type="number"
							id="stock" name="stock" class="form-control" min="0"
							value="<%=producto.getStock()%>" required>
					</div>

					<div class="mb-3">
						<label class="form-label">Precio de Costo:</label> <input
							type="number" id="precio_costo" name="precio_costo"
							class="form-control" step="0.01" min="0"
							value="<%=producto.getPrecio_costo()%>" required>
					</div>

					<div class="mb-3">
						<label class="form-label">Precio de Venta:</label> <input
							type="number" id="precio_venta" name="precio_venta"
							class="form-control" step="0.01" min="0"
							value="<%=producto.getPrecio_venta()%>" required>
					</div>

					<div class="mb-3">
						<label class="form-label">Estado:</label> <select name="estado"
							id="estado" class="form-control" required>
							<option value="">-- Seleccione estado --</option>
							<option value="ACTIVO"
								<%="ACTIVO".equals(producto.getEstado()) ? "selected" : ""%>>Activo</option>
							<option value="INACTIVO"
								<%="INACTIVO".equals(producto.getEstado()) ? "selected" : ""%>>Inactivo</option>
						</select>
					</div>

					<div class="mb-3">
						<label class="form-label">Fecha de Registro:</label> <input
							type="date" id="fecha_registro" name="fecha_registro"
							class="form-control"
							value="<%=producto.getFecha_registro() != null
		? new java.text.SimpleDateFormat("yyyy-MM-dd").format(producto.getFecha_registro())
		: ""%>"
							required>
					</div>

					<button type="submit" class="btn btn-primary w-100">Guardar</button>
				</form>

				<br> <a
					href="<%=request.getContextPath()%>/ProductoController?op=listar"
					class="btn btn-secondary w-100">Volver a la Lista</a>
			</div>
		</div>
	</div>

	<script>
		function validarProducto() {
			let nombre = document.getElementById("nombre").value.trim();
			let categoria = document.getElementById("id_categoria").value;
			let stock = document.getElementById("stock").value;
			let precioCosto = document.getElementById("precio_costo").value;
			let precioVenta = document.getElementById("precio_venta").value;
			let estado = document.getElementById("estado").value;
			let fecha = document.getElementById("fecha_registro").value;

			if (nombre === "") {
				alert("El nombre es obligatorio");
				return false;
			}
			if (categoria === "") {
				alert("Seleccione una categoría");
				return false;
			}
			if (stock === "" || isNaN(stock) || parseInt(stock) < 0) {
				alert("Ingrese un stock válido");
				return false;
			}
			if (precioCosto === "" || isNaN(precioCosto)
					|| parseFloat(precioCosto) < 0) {
				alert("Ingrese un precio de costo válido");
				return false;
			}
			if (precioVenta === "" || isNaN(precioVenta)
					|| parseFloat(precioVenta) < 0) {
				alert("Ingrese un precio de venta válido");
				return false;
			}
			if (estado === "") {
				alert("Seleccione un estado");
				return false;
			}
			if (fecha === "") {
				alert("Seleccione una fecha de registro");
				return false;
			}

			return true;
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>




