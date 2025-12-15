<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nuevo Cliente</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container py-4">

    <h2 class="text-center mb-4">🧍‍♂️ Registrar Nuevo Cliente</h2>

    <!-- FORMULARIO -->
    <div class="card shadow">
        <div class="card-body">

            <form action="<%=request.getContextPath()%>/ClienteController?op=insertar" 
                  method="post" onsubmit="return validarCliente()">
                
                 <div class="mb-3">
                    <label class="form-label">Dni:</label>
                    <input type="text" id="dni" name="dni" class="form-control" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" required>
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
            <a href="<%=request.getContextPath()%>/ClienteController?op=listar" 
               class="btn btn-secondary w-100">
                Volver a la Lista
            </a>

        </div>
    </div>

</div>

<!-- VALIDACIÓN JAVASCRIPT -->
<script>
function validarCliente() {
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
        alert("Ingrese un teléfono válido (solo números, min 6 dígitos)");
        return false;
    }

    if (direccion === "") {
        alert("La dirección es obligatoria");
        return false;
    }

    return true;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

