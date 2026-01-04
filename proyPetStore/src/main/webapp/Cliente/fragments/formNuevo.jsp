<%@ page contentType="text/html; charset=UTF-8" language="java" %>

    <h2 class="text-center mb-4">🧍‍♂️ Registrar Nuevo Cliente</h2>

    <div class="card shadow">
        <div class="card-body">

            <form action="<%=request.getContextPath()%>/ClienteController?op=insertar" method="post"
                onsubmit="return validarCliente()">

                <div class="mb-3">
                    <label class="form-label">Dni:</label>
                    <input type="text" id="dni" name="dni" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Nombre:</label>
                    <input type="text" id="nombreC" name="nombreC" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Apellido:</label>
                    <input type="text" id="apellido" name="apellido" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Teléfono:</label>
                    <input type="text" id="telefono" name="telefono" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Dirección:</label>
                    <input type="text" id="direccion" name="direccion" class="form-control" required>
                </div>

                <button type="submit" class="btn btn-primary w-100">Guardar</button>
            </form>

            <br>
            <button type="button" class="btn btn-secondary w-100" data-bs-dismiss="modal">
                Cancelar
            </button>

        </div>
    </div>