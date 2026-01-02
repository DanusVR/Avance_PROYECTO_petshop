<%@page import="com.proyPetStore.model.*"%>
<%@page import="com.proyPetStore.beans.*"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String idVentaStr = request.getParameter("idVenta");
    if (idVentaStr == null || idVentaStr.isEmpty()) {
        out.println("<h3 style='text-align:center;color:red;margin-top:50px;'>Error: No se recibió el ID de la venta.</h3>");
        return;
    }

    int idVenta = Integer.parseInt(idVentaStr);

    VentaModel vmodel = new VentaModel();
    DetalleVentaModel dmodel = new DetalleVentaModel();

    Venta venta = vmodel.obtenerVentaporId(idVenta);
    if (venta == null) {
        out.println("<h3 style='text-align:center;color:red;margin-top:50px;'>Error: No se encontró la venta con ID " + idVenta + ".</h3>");
        return;
    }

    List<Detalle_Venta> detalles = dmodel.listarPorVentaporid(idVenta);
%>

<div class="ticket mt-4">
    <h3 class="title text-center">🐾 PETSHOP - RECIBO</h3>
    <p class="text-center text-muted">Venta Nº: <b><%= venta.getId_venta() %></b></p>

    <hr>

    <p><b>Cliente:</b> <%= venta.getNombreCliente() != null ? venta.getNombreCliente() : "-" %></p>
    <p><b>Fecha:</b> <%= venta.getFecha() != null ? venta.getFecha() : "-" %></p>
    <p><b>Tipo de Pago:</b> <%= venta.getTipo_pago() != null ? venta.getTipo_pago() : "-" %></p>

    <hr>

    <table class="table table-bordered">
        <thead class="table-light">
            <tr>
                <th>Tipo</th>
                <th>Descripción</th>
                <th>Cant.</th>
                <th>Precio</th>
                <th>Sub.</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (detalles != null && !detalles.isEmpty()) {
                    for (Detalle_Venta d : detalles) {
                        String tipo = (d.getId_producto() != null && d.getId_producto() > 0) ? "Producto" : "Servicio";
                        String nombre = (d.getId_producto() != null && d.getId_producto() > 0) 
                                        ? d.getNombre_producto() 
                                        : d.getNombre_servicio();
                        int cantidad = d.getCantidad() != null ? d.getCantidad() : 0;
                        double precio = d.getPrecio() != null ? d.getPrecio() : 0.0;
                        double subtotal = d.getSubtotal() != null ? d.getSubtotal() : 0.0;
            %>
            <tr>
                <td><%= tipo %></td>
                <td><%= nombre %></td>
                <td class="text-right"><%= cantidad %></td>
                <td class="text-right">$<%= String.format("%.2f", precio) %></td>
                <td class="text-right">$<%= String.format("%.2f", subtotal) %></td>
            </tr>
            <% } 
                } else { %>
            <tr>
                <td colspan="5" class="text-center">No hay detalles para esta venta</td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <h4 class="text-end">Total: <span class="text-success">$<%= String.format("%.2f", venta.getTotal()) %></span></h4>

    <div class="text-center mt-3">
        <button class="btn btn-print px-4 py-2" onclick="window.print()">🖨 Imprimir</button>
    </div>
</div>

<style>
.ticket { 
    max-width: 600px; 
    margin: auto; 
    background: white;
    padding: 25px; 
    border-radius: 15px;
    box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
    font-family: 'Arial', sans-serif;
}
.table th, .table td { font-size: 14px; padding: 4px; }
.text-right { text-align: right; }
.btn-print { background: #5B8DEF; color: white; border-radius: 12px; font-weight: bold; }
.btn-print:hover { background: #4676db; }

/* Para imprimir solo el recibo */
@media print {
    body * { visibility: hidden; }
    .ticket, .ticket * { visibility: visible; }
    .ticket { position: absolute; left: 0; top: 0; width: 100%; }
}
</style>
