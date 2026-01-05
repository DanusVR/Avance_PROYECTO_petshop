<!-- FORMULARIO -->
<form action="<%=request.getContextPath()%>/CategoriaController" method="post"
    onsubmit="return submitFormAjax(event, 'modalCategoria', '/CategoriaController?op=listar', 'validarCategoria')">
    <input type="hidden" name="op" value="insertar">

    <div class="mb-3">
        <label class="form-label">Nombre de Categoria:</label>
        <input type="text" id="nombreCat" name="nombreCat" class="form-control" required>
    </div>

    <button type="submit" class="btn btn-primary w-100 mb-2">Guardar</button>

    <button type="button" class="btn btn-secondary w-100" data-bs-dismiss="modal">Cancelar</button>

</form>