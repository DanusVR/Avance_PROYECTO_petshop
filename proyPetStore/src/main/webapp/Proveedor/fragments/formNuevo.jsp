<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<h2 class="text-center mb-4">🧾 Registrar Nuevo Proveedor</h2>

<div class="card shadow">
    <div class="card-body">

        <form action="<%=request.getContextPath()%>/ProveedorController?op=insertar" method="post"
              onsubmit="return validarProveedor()">

            <div class="mb-3">
                <label class="form-label">RUC:</label>
                <input type="text" id="ruc" name="ruc" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Nombre:</label>
                <input type="text" id="nombre" name="nombre" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Teléfono:</label>
                <input type="text" id="telefono" name="telefono" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Correo:</label>
                <input type="email" id="correo" name="correo" class="form-control">
            </div>

            <div class="mb-3">
                <label class="form-label">Dirección:</label>
                <input type="text" id="direccion" name="direccion" class="form-control">
            </div>

            <div class="mb-3">
                <label class="form-label">Tipo:</label>
                <select name="tipo" id="tipo" class="form-control" required>
                    <option value="">-- Seleccione --</option>
                    <option value="medicina">Medicina</option>
                    <option value="comida">Comida</option>
                    <option value="accesorio">Accesorio</option>
                    <option value="varios">Varios</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary w-100">Guardar</button>
            <br><br>
            <button type="button" class="btn btn-secondary w-100" data-bs-dismiss="modal">Cancelar</button>

        </form>
    </div>
</div>

