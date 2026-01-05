<%@page import="com.proyPetStore.beans.Compras" %>
    <%@page import="java.util.List" %>
        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-primary">Gestion de Compras</h2>
                <button class="btn btn-success" onclick="modalCompra.abrir('nuevo')"> Nueva Compra</button>
            </div>

            <div class="card shadow">
                <div class="card-body">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                              
                                <th>Proveedor</th>
                                <th>Fecha</th>
                                <th>Total</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List<Compras> listaCompras = (List<Compras>) request.getAttribute("listarCompras");
                                    if(listaCompras != null){
                                    for(Compras c : listaCompras){
                                    %>
                                    <tr>
                                      
                                        <td>
                                            <%= c.getNombreProveedor() %>
                                        </td>
                                        <td>
                                            <%= c.getFecha_compra() %>
                                        </td>
                                        <td>S/ <%= c.getTotal() %>
                                        </td>
                                        <td>
                                            <%= c.getEstado() %>
                                        </td>
                                        <td>
                                            <button class="btn btn-warning btn-sm"
                                                onclick="modalCompra.abrir('ver', <%=c.getId_compra()%>)">Ver</button>
                                            <button
                                                onclick="eliminarRegistro('/CompraController?op=eliminar&id=<%=c.getId_compra()%>', '¿Seguro de anular esta compra?')"
                                                class="btn btn-danger btn-sm">Anular</button>
                                        </td>
                                    </tr>
                                    <% } } else { %>
                                        <tr>
                                            <td colspan="6" class="text-center text-muted py-3">No hay compras
                                                registradas.</td>
                                        </tr>
                                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Modal Compra -->
        <div class="modal fade" id="modalCompra" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header text-white" style="background-color: #ec8caa;">
                        <h5 class="modal-title" id="modalCompraLabel">Gestion de Compra</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                     
                    </div>
                </div>
            </div>
        </div>