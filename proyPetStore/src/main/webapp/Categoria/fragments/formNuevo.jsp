<!-- FORMULARIO -->
<form action="<%=request.getContextPath()%>/CategoriaController?op=insertar" method="post"
    onsubmit="return validarCategoria()">

    <div class="mb-3">
        <label class="form-label">Nombre de Categoría:</label>
        <input type="text" id="nombreCat" name="nombreCat" class="form-control" required>
    </div>

    <button type="submit" class="btn btn-primary w-100 mb-2">Guardar</button>

    <button type="button" class="btn btn-secondary w-100" data-bs-dismiss="modal">Cancelar</button>

</form>