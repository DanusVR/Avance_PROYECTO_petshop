<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.proyPetStore.beans.Mascota" %>
<%@ page import="java.util.List" %>

<%
    List<Mascota> listaMascotas = (List<Mascota>) request.getAttribute("listaMascotas");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nuevo Servicio</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container py-4">

    <h2 class="text-center mb-4">🛠️ Registrar Nuevo Servicio</h2>

    <!-- FORMULARIO -->
    <div class="card shadow">
        <div class="card-body">

            <form action="<%=request.getContextPath()%>/ServicioController?op=insertar"
                  method="post" onsubmit="return validarServicio()">

                <!-- NOMBRE -->
                <div class="mb-3">
                    <label class="form-label">Nombre del Servicio:</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" required>
                </div>

                <!-- TIPO -->
                <div class="mb-3">
                    <label class="form-label">Tipo:</label>
                    <select id="tipo" name="tipo" class="form-control" required>
                        <option value="">Seleccione...</option>
                        <option value="Baño">Baño</option>
                        <option value="Peluquería">Peluquería</option>
                        <option value="Vacuna">Vacuna</option>
                        <option value="Consulta">Consulta</option>
                        <option value="Otro">Otro</option>
                    </select>
                </div>

                <!-- MASCOTA -->
                <div class="mb-3">
                    <label class="form-label">Mascota asociada:</label>
                    <select id="id_mascota" name="id_mascota" class="form-control" required>
                        <option value="">Seleccione una mascota...</option>

                        <% if (listaMascotas != null) {
                               for (Mascota m : listaMascotas) { %>
                                   <option value="<%=m.getId_mascota()%>">
                                       <%= m.getNombre() %> — <%= m.getEspecie() %>
                                   </option>
                        <%     }
                           }
                        %>
                    </select>
                </div>

                <!-- DESCRIPCIÓN -->
                <div class="mb-3">
                    <label class="form-label">Descripción:</label>
                    <textarea id="descripcion" name="descripcion"
                              class="form-control" rows="3" required></textarea>
                </div>

                <!-- PRECIO -->
                <div class="mb-3">
                    <label class="form-label">Precio (S/):</label>
                    <input type="number" step="0.01" id="precio" name="precio"
                           class="form-control" required>
                </div>

                <!-- ESTADO -->
                <div class="mb-3">
                    <label class="form-label">Estado:</label>
                    <select id="estado" name="estado" class="form-control" required>
                        <option value="">Seleccione...</option>
                        <option value="Activo">Activo</option>
                        <option value="Inactivo">Inactivo</option>
                    </select>
                </div>

                <!-- BOTÓN -->
                <button type="submit" class="btn btn-primary w-100">Guardar</button>
            </form>

            <br>
            <a href="<%=request.getContextPath()%>/ServicioController?op=listar"
               class="btn btn-secondary w-100">
                Volver a la Lista
            </a>

        </div>
    </div>

</div>

<!-- VALIDACIÓN JAVASCRIPT -->
<script>
function validarServicio() {
    let nombre = document.getElementById("nombre").value.trim();
    let tipo = document.getElementById("tipo").value;
    let mascota = document.getElementById("id_mascota").value;
    let descripcion = document.getElementById("descripcion").value.trim();
    let precio = document.getElementById("precio").value.trim();
    let estado = document.getElementById("estado").value;

    if (nombre === "") {
        alert("El nombre es obligatorio");
        return false;
    }
    if (tipo === "") {
        alert("Debe seleccionar un tipo de servicio");
        return false;
    }
    if (mascota === "") {
        alert("Debe seleccionar una mascota");
        return false;
    }
    if (descripcion === "") {
        alert("La descripción es obligatoria");
        return false;
    }
    if (precio === "" || isNaN(precio) || precio <= 0) {
        alert("Ingrese un precio válido mayor a 0");
        return false;
    }
    if (estado === "") {
        alert("Debe seleccionar un estado");
        return false;
    }

    return true;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
