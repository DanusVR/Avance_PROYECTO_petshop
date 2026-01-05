<%@page import="com.proyPetStore.beans.Cliente" %>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


		<% String url=request.getContextPath() + "/" ; Cliente cliente=(Cliente) request.getAttribute("cliente"); if
			(cliente==null) { cliente=new Cliente(); } %>
			<h2 class="text-center mb-4">✏️ Editar Cliente</h2>

			<div class="card shadow">
				<div class="card-body">

					<form action="<%=url%>ClienteController" method="POST"
						onsubmit="return submitFormAjax(event, 'modalCliente', '/ClienteController?op=listar', 'validarEdicion')">
						<input type="hidden" name="op" value="modificar"> <input type="hidden" name="id_cliente"
							value="<%=cliente.getId_cliente()%>">


						<div class="mb-3">
							<label class="form-label">Dni del Cliente</label> <input type="text" name="dni" id="dni"
								value="<%=cliente.getDni() != null ? cliente.getDni() : ""%>" class="form-control"
								required>
						</div>



						<div class="mb-3">
							<label class="form-label">Nombre del Cliente</label> <input type="text" name="nombreC"
								id="nombreC" value="<%=cliente.getNombreC()!= null ? cliente.getNombreC() : ""%>"
								class="form-control" required>
						</div>
						<div class="mb-3">
							<label class="form-label">Apellido del Cliente</label> <input type="text" name="apellido"
								id="apellido" value="<%=cliente.getApellido() != null ? cliente.getApellido() : ""%>"
								class="form-control" required>
						</div>


						<div class="mb-3">
							<label class="form-label">Teléfono</label> <input type="text" name="telefono" id="telefono"
								value="<%=cliente.getTelefono() != null ? cliente.getTelefono() : ""%>"
								class="form-control" required>
						</div>

						<!-- Dirección -->
						<div class="mb-3">
							<label class="form-label">Dirección</label> <input type="text" name="direccion"
								id="direccion" value="<%=cliente.getDireccion() != null ? cliente.getDireccion() : ""%>"
								class="form-control" required>
						</div>

						<button type="submit" class="btn btn-primary w-100 mb-2">Guardar
							Cambios</button>

						<button type="button" class="btn btn-secondary w-100" data-bs-dismiss="modal">
							Cancelar
						</button>

					</form>

				</div>
			</div>