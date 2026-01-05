<%@page import="com.proyPetStore.beans.Producto" %>
	<%@page import="com.proyPetStore.beans.Categoria" %>
		<%@page import="java.util.List" %>
			<%@ page contentType="text/html; charset=UTF-8" language="java" %>

				<% List<Categoria> listarCategoria = (List<Categoria>) request.getAttribute("listarCategoria");
						Producto producto = (Producto) request.getAttribute("producto");

						if (producto == null) {
						producto = new Producto();
						}
						%>



						<div class="container py-4">
							<h2 class="text-center mb-4">🛒 Registrar Nuevo Producto</h2>

							<div class="card shadow">
								<div class="card-body">
									<form action="<%=request.getContextPath()%>/ProductoController" method="post"
										onsubmit="return submitFormAjax(event, 'modalProducto', '/ProductoController?op=listar', 'validarProducto')">
										<input type="hidden" name="op" value="insertar">

										<div class="mb-3">
											<label class="form-label">Nombre del Producto:</label> <input type="text"
												id="nombre" name="nombre" class="form-control"
												value="<%=producto.getNombre() != null ? producto.getNombre() : ""%>"
												required>
										</div>

										<div class="mb-3">
											<label class="form-label">Categoría:</label> <select name="id_categoria"
												id="id_categoria" class="form-control" required>
												<option value="">-- Seleccione una categoría --</option>
												<% if (listarCategoria !=null && !listarCategoria.isEmpty()) { for
													(Categoria c : listarCategoria) { String
													selected=(producto.getId_categoria()==c.getId_categoria())
													? "selected" : "" ; %>
													<option value="<%=c.getId_categoria()%>" <%=selected%>>
														<%=c.getNombreCat()%>
													</option>
													<% } } %>
											</select>
										</div>

										<div class="mb-3">
											<label class="form-label">Descripción:</label>
											<textarea id="descripcion" name="descripcion" class="form-control"
												rows="3"><%=producto.getDescripcion() != null ? producto.getDescripcion() : ""%></textarea>
										</div>

										<div class="mb-3">
											<label class="form-label">Stock:</label> <input type="number" id="stock"
												name="stock" class="form-control" min="0"
												value="<%=producto.getStock()%>" required>
										</div>

										<div class="mb-3">
											<label class="form-label">Precio de Costo:</label> <input type="number"
												id="precio_costo" name="precio_costo" class="form-control" step="0.01"
												min="0" value="<%=producto.getPrecio_costo()%>" required>
										</div>

										<div class="mb-3">
											<label class="form-label">Precio de Venta:</label> <input type="number"
												id="precio_venta" name="precio_venta" class="form-control" step="0.01"
												min="0" value="<%=producto.getPrecio_venta()%>" required>
										</div>

										<div class="mb-3">
											<label class="form-label">Estado:</label> <select name="estado" id="estado"
												class="form-control" required>
												<option value="">-- Seleccione estado --</option>
												<option value="ACTIVO" <%="ACTIVO" .equals(producto.getEstado())
													? "selected" : "" %>>Activo</option>
												<option value="INACTIVO" <%="INACTIVO" .equals(producto.getEstado())
													? "selected" : "" %>>Inactivo</option>
											</select>
										</div>

										<div class="mb-3">
											<label class="form-label">Fecha de Registro:</label> <input type="date"
												id="fecha_registro" name="fecha_registro" class="form-control"
												value='<%=producto.getFecha_registro() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(producto.getFecha_registro()) : "" %>'
												required>
										</div>

										<button type="submit" class="btn btn-primary w-100">Guardar</button>
									</form>

									<br> <button type="button" class="btn btn-secondary w-100"
										data-bs-dismiss="modal">Cancelar</button>
								</div>
							</div>
						</div>