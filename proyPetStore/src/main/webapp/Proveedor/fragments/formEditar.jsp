<%@page import="com.proyPetStore.beans.Proveedor"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String url = request.getContextPath() + "/";
    Proveedor proveedor = (Proveedor) request.getAttribute("proveedor");
    if (proveedor == null) { proveedor = new Proveedor(); }
%>

<h2 class="text-center mb-4">✏️ Editar Proveedor</h2>

<div class="card shadow">
    <div class="card-body">

        <form action="<%=url%>ProveedorController" method="POST" onsubmit="return validarEdicionProveedor()">
            <input type="hidden" name="op" value="modificar">
            <input type="hidden" name="id_proveedor" value="<%=proveedor.getIdProveedor()%>">

            <div class="mb-3">
                <label class="form-label">RUC:</label>
                <input type="text" name="ruc" id="ruc"
                       value="<%=proveedor.getRuc() != null ? proveedor.getRuc() : ""%>"
                       class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Nombre:</label>
                <input type="text" name="nombre" id="nombre"
                       value="<%=proveedor.getNombre() != null ? proveedor.getNombre() : ""%>"
                       class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Teléfono:</label>
                <input type="text" name="telefono" id="telefono"
                       value="<%=proveedor.getTelefono() != null ? proveedor.getTelefono() : ""%>"
                       class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Correo:</label>
                <input type="email" name="correo" id="correo"
                       value="<%=proveedor.getCorreo() != null ? proveedor.getCorreo() : ""%>"
                       class="form-control">
            </div>

            <div class="mb-3">
                <label class="form-label">Dirección:</label>
                <input type="text" name="direccion" id="direccion"
                       value="<%=proveedor.getDireccion() != null ? proveedor.getDireccion() : ""%>"
                       class="form-control">
            </div>

            <div class="mb-3">
                <label class="form-label">Tipo:</label>
                <select name="tipo" id="tipo" class="form-control" required>
                    <option value="">-- Seleccione --</option>
                    <option value="medicina" <%= "medicina".equals(proveedor.getTipo()) ? "selected" : "" %>>Medicina</option>
                    <option value="comida" <%= "comida".equals(proveedor.getTipo()) ? "selected" : "" %>>Comida</option>
                    <option value="accesorio" <%= "accesorio".equals(proveedor.getTipo()) ? "selected" : "" %>>Accesorio</option>
                    <option value="varios" <%= "varios".equals(proveedor.getTipo()) ? "selected" : "" %>>Varios</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary w-100 mb-2">Guardar Cambios</button>
            <button type="button" class="btn btn-secondary w-100" data-bs-dismiss="modal">Cancelar</button>

        </form>
    </div>
</div>

