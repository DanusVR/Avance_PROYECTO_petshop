<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ page import="com.proyPetStore.beans.Compras, com.proyPetStore.beans.CompraDetalle" %>
        <% Compras compra=(Compras) request.getAttribute("compra"); %>
            <div class="container-fluid">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="bi bi-eye"></i> Detalle de Compra #<%= (compra !=null) ?
                                compra.getId_compra() : "" %>
                        </h5>
                    </div>
                    <div class="card-body">
                        <% if (compra !=null) { %>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <strong>Proveedor:</strong>
                                    <%= compra.getNombreProveedor() %>
                                </div>
                                <div class="col-md-6">
                                    <strong>Fecha Compra:</strong>
                                    <%= compra.getFecha_compra() %>
                                </div>
                                <div class="col-md-6">
                                    <strong>Estado:</strong>
                                    <span class="badge <%= " activo".equalsIgnoreCase(compra.getEstado()) ? "bg-success"
                                        : "bg-danger" %>">
                                        <%= compra.getEstado() %>
                                    </span>
                                </div>
                                <div class="col-md-6">
                                    <strong>Total:</strong> S/ <%= String.format("%.2f", compra.getTotal()) %>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-bordered table-striped align-middle">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Producto</th>
                                            <th class="text-center">Cantidad</th>
                                            <th class="text-end">Precio Unit.</th>
                                            <th class="text-end">Subtotal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (compra.getDetalles() !=null) { %>
                                            <% for (CompraDetalle d : compra.getDetalles()) { %>
                                                <tr>
                                                    <td>
                                                        <%= d.getNombreProducto() %>
                                                    </td>
                                                    <td class="text-center">
                                                        <%= d.getCantidad() %>
                                                    </td>
                                                    <td class="text-end">S/ <%= String.format("%.2f",
                                                            d.getPrecio_unitario()) %>
                                                    </td>
                                                    <td class="text-end">S/ <%= String.format("%.2f", d.getSubtotal())
                                                            %>
                                                    </td>
                                                </tr>
                                                <% } %>
                                                    <% } else { %>
                                                        <tr>
                                                            <td colspan="4" class="text-center text-muted">No hay
                                                                detalles disponibles</td>
                                                        </tr>
                                                        <% } %>
                                    </tbody>
                                    <tfoot class="table-light">
                                        <tr>
                                            <th colspan="3" class="text-end">Total General:</th>
                                            <th class="text-end">S/ <%= String.format("%.2f", compra.getTotal()) %>
                                            </th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>

                            <% } else { %>
                                <div class="alert alert-warning text-center">
                                    <i class="bi bi-exclamation-triangle"></i> No se encontró información de la compra.
                                </div>
                                <% } %>

                                    <div class="text-end mt-3">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                            <i class="bi bi-x-circle"></i> Cerrar
                                        </button>
                                    </div>
                    </div>
                </div>
            </div>