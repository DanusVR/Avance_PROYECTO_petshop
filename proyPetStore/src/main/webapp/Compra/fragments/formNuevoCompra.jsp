<%@page import="java.util.ArrayList" %>
    <%@ page import="com.proyPetStore.beans.Proveedor" %>
        <%@ page import="java.util.List" %>
            <%@ page contentType="text/html; charset=UTF-8" language="java" %>


                <%@ page import="com.proyPetStore.beans.Producto" %>
                    <% String url=request.getContextPath() + "/" ; List<Proveedor> listaProveedores = (List<Proveedor>)
                            request.getAttribute("listarProveedor");
                            if (listaProveedores == null) listaProveedores = new ArrayList<>();

                                List<Producto> listaProductos = (List<Producto>)
                                        request.getAttribute("listarProductos");
                                        if (listaProductos == null) listaProductos = new ArrayList<>();
                                            %>

                                            <script>
                                                window.listaProductos = [
    <% for (Producto prod : listaProductos) { %>
                                                    { id: "<%=prod.getId_producto()%>", nombre: "<%=prod.getNombre()%>", precio: "<%=prod.getPrecio_costo()%>" },
    <% } %>
    ];
                                            </script>

                                            <div class="container-fluid">
                                                <h3 class="text-center text-primary mb-4"><i
                                                        class="bi bi-cart-plus"></i> Registrar Nueva
                                                    Compra</h3>

                                                <div class="card shadow-sm">
                                                    <div class="card-body">

                                                        <!-- Formulario -->
                                                        <form action="<%=url%>CompraController" method="post"
                                                            id="formCompra" onsubmit="return validarCompra()">
                                                            <input type="hidden" name="op" value="insertar">

                                                            <!-- Seleccionar Proveedor -->
                                                            <div class="mb-4">
                                                                <label class="form-label fw-bold">Proveedor</label>
                                                                <select name="id_proveedor" id="id_proveedor"
                                                                    class="form-select form-select-lg" required>
                                                                    <option value="">-- Seleccione un proveedor --
                                                                    </option>
                                                                    <% for(Proveedor p : listaProveedores){ %>
                                                                        <option value="<%=p.getIdProveedor()%>">
                                                                            <%=p.getNombre()%>
                                                                        </option>
                                                                        <% } %>
                                                                </select>
                                                            </div>

                                                            <!-- Tabla Detalle de Productos -->
                                                            <div class="mb-3">
                                                                <h5 class="fw-bold text-secondary"><i
                                                                        class="bi bi-box-seam"></i> Detalle de
                                                                    Productos</h5>
                                                                <table class="table table-bordered align-middle"
                                                                    id="tablaDetalle">
                                                                    <thead class="table-dark text-center">
                                                                        <tr>
                                                                            <th>Producto</th>
                                                                            <th>Cantidad</th>
                                                                            <th>Precio Unitario (S/)</th>
                                                                            <th>Subtotal (S/)</th>
                                                                            <th>Acciones</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <!-- Filas dinámicas -->
                                                                    </tbody>
                                                                </table>
                                                                <div class="text-end mb-3">
                                                                    <strong>Total: S/ <span
                                                                            id="totalCompra">0.00</span></strong>
                                                                </div>
                                                                <button type="button" class="btn btn-success mb-3"
                                                                    onclick="agregarFila()">
                                                                    <i class="bi bi-plus-circle"></i> Agregar Producto
                                                                </button>
                                                            </div>

                                                            <!-- Botones -->
                                                            <div class="d-flex gap-2">
                                                                <button type="submit"
                                                                    class="btn btn-primary flex-fill"><i
                                                                        class="bi bi-check-circle"></i> Registrar
                                                                    Compra</button>
                                                                <button type="button"
                                                                    class="btn btn-secondary flex-fill"
                                                                    data-bs-dismiss="modal"><i
                                                                        class="bi bi-x-circle"></i> Cancelar</button>
                                                            </div>

                                                        </form>

                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Scripts dinámicos para filas y cálculos -->


                                            <!-- Bootstrap Icons -->
                                            <link rel="stylesheet"
                                                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">