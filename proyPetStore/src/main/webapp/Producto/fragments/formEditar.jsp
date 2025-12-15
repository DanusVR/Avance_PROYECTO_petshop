<%@page import="com.proyPetStore.beans.Categoria"%>
<%@page import="java.util.List"%>
<%@page import="com.proyPetStore.beans.Producto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String url = request.getContextPath() + "/";
Producto producto = (Producto) request.getAttribute("producto");
List<Categoria> listarCategoria = (List<Categoria>) request.getAttribute("listarCategoria");
if (producto == null) {
    producto = new Producto();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editar Producto</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container py-4">

    <h2 class="text-center mb-4">✏️ Editar Producto</h2>

    <div class="card shadow">
        <div class="card-body">

            <form action="<%=url%>ProductoController" method="POST" onsubmit="return validarEdicion()">

                <input type="hidden" name="op" value="modificar">
                <input type="hidden" name="id_producto" value="<%=producto.getId_producto()%>">

                <div class="mb-3">
                    <label class="form-label">Nombre del Producto</label>
                    <input type="text" name="nombre" id="nombre"
                        value="<%=producto.getNombre() != null ? producto.getNombre() : ""%>"
                        class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Categoría:</label>
                    <select name="id_categoria" id="id_categoria" class="form-control" required>
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
                    <label class="form-label">Descripción</label>
                    <textarea name="descripcion" id="descripcion" class="form-control" rows="3"><%=producto.getDescripcion() != null ? producto.getDescripcion() : ""%></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Stock</label>
                    <input type="number" name="stock" id="stock"
                        value="<%=producto.getStock()%>" class="form-control" min="0" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Precio de Costo</label>
                    <input type="number" name="precio_costo" id="precio_costo"
                        value="<%=producto.getPrecio_costo()%>" class="form-control" step="0.01" min="0" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Precio de Venta</label>
                    <input type="number" name="precio_venta" id="precio_venta"
                        value="<%=producto.getPrecio_venta()%>" class="form-control" step="0.01" min="0" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Estado</label>
                    <select name="estado" id="estado" class="form-control" required>
                        <option value="">-- Seleccione estado --</option>
                        <option value="Activo" <%= "Activo".equals(producto.getEstado()) ? "selected" : "" %>>Activo</option>
                        <option value="Inactivo" <%= "Inactivo".equals(producto.getEstado()) ? "selected" : "" %>>Inactivo</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Fecha de Registro</label>
                    <input type="date" name="fecha_registro" id="fecha_registro"
                        value="<%=producto.getFecha_registro() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(producto.getFecha_registro()) : ""%>"
                        class="form-control" required>
                </div>

                <button type="submit" class="btn btn-primary w-100 mb-2">Guardar Cambios</button>
                <a href="<%=url%>ProductoController?op=listar" class="btn btn-secondary w-100">Cancelar</a>

            </form>

        </div>
    </div>

</div>

<!-- VALIDACIÓN JS -->
<script>
function validarEdicion() {
    let nombre = document.getElementById("nombre").value.trim();
    let categoria = document.getElementById("id_categoria").value.trim();
    let stock = document.getElementById("stock").value;
    let precioCosto = document.getElementById("precio_costo").value;
    let precioVenta = document.getElementById("precio_venta").value;
    let estado = document.getElementById("estado").value;
    let fecha = document.getElementById("fecha_registro").value;

    if (nombre === "") { alert("El nombre del producto es obligatorio"); return false; }
    if (categoria === "") { alert("La categoría es obligatoria"); return false; }
    if (stock === "" || isNaN(stock) || parseInt(stock) < 0) { alert("Ingrese un stock válido"); return false; }
    if (precioCosto === "" || isNaN(precioCosto) || parseFloat(precioCosto) < 0) { alert("Ingrese un precio de costo válido"); return false; }
    if (precioVenta === "" || isNaN(precioVenta) || parseFloat(precioVenta) < 0) { alert("Ingrese un precio de venta válido"); return false; }
    if (estado === "") { alert("Seleccione un estado"); return false; }
    if (fecha === "") { alert("Seleccione una fecha de registro"); return false; }

    return true;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

