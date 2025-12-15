<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nueva Categoría</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container py-4">

    <h2 class="text-center mb-4">🧍‍♂️ Registrar Nueva Categoría</h2>

    <!-- FORMULARIO -->
    <div class="card shadow">
        <div class="card-body">

            <form action="<%=request.getContextPath()%>/CategoriaController?op=insertar" 
                  method="post" onsubmit="return validarCategoria()">
                
                <div class="mb-3">
                    <label class="form-label">Nombre de Categoría:</label>
                    <input type="text" id="nombreCat" name="nombreCat" class="form-control" required>
                </div>

                <button type="submit" class="btn btn-primary w-100 mb-2">Guardar</button>

                <a href="<%=request.getContextPath()%>/CategoriaController?op=listar" 
                   class="btn btn-secondary w-100">Volver a la Lista</a>

            </form>

        </div>
    </div>

</div>

<!-- VALIDACIÓN JAVASCRIPT -->
<script>
function validarCategoria() {
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


