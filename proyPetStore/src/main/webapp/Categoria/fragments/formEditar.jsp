<%@page import="com.proyPetStore.beans.Categoria" %>
	<% String url=request.getContextPath() + "/" ; Categoria categoria=(Categoria) request.getAttribute("categoria"); if
		(categoria==null) { categoria=new Categoria(); } %>
		<form action="<%=url%>CategoriaController" method="POST"
			onsubmit="return submitFormAjax(event, 'modalCategoria', '/CategoriaController?op=listar', 'validarCategoria')">
			<input type="hidden" name="op" value="modificar">
			<input type="hidden" name="id_categoria" value="<%=categoria.getId_categoria()%>">

			<div class="mb-3">
				<label class="form-label">Nombre de Categoría</label>
				<input type="text" name="nombreCat" id="nombreCat"
					value="<%=categoria.getNombreCat() != null ? categoria.getNombreCat() : ""%>" class="form-control"
					required>
			</div>

			<button type="submit" class="btn btn-primary w-100 mb-2">Guardar Cambios</button>
			<button type="button" class="btn btn-secondary w-100" data-bs-dismiss="modal">Cancelar</button>

		</form>