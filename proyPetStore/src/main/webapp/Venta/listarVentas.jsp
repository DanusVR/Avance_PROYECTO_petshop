<%@page import="com.proyPetStore.beans.Venta"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Gestión de Ventas</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container mt-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-primary">Gestión de Ventas</h2>
        <div class="d-flex justify-content-end mb-3">
            <a href="<%=request.getContextPath()%>/VentaController?accion=nuevo" class="btn btn-success">➕ Nueva Venta</a>
        </div>
    </div>

    <div class="card shadow">
        <div class="card-body">

            <table class="table table-striped table-hover align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Cliente</th>
                        <th>Fecha</th>
                        <th>Total</th>
                        <th>Tipo Pago</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Venta> listarVentas = (List<Venta>) request.getAttribute("listarVentas");
                        if (listarVentas != null && !listarVentas.isEmpty()) {
                            for (Venta v : listarVentas) {
                    %>
                    <tr>
                        <td><%=v.getId_venta()%></td>
                        <td><%=v.getNombreCliente() != null ? v.getNombreCliente() : "-" %></td>
                        <td><%=v.getFecha()%></td>
                        <td>$<%=String.format("%.2f", v.getTotal())%></td>
                        <td><%=v.getTipo_pago()%></td>
                        <td class="acciones">
                            <button class="btn btn-primary btn-sm" 
                                onclick="modalReciboFunc.abrir(<%=v.getId_venta()%>)">
                                Ver Recibo
                            </button>
                            <a href="<%=request.getContextPath()%>/VentaController?accion=eliminar&id=<%=v.getId_venta()%>" 
                               class="btn btn-danger btn-sm" 
                               onclick="return confirm('¿Seguro de eliminar esta venta?')">Eliminar</a> 
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" class="text-center text-muted py-3">No hay ventas registradas.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

        </div>
    </div>

</div>

<!-- Modal Recibo -->
<div class="modal fade" id="modalRecibo" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Recibo de Venta</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <!-- Aquí se cargará dinámicamente Recibo.jsp -->
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
const modalReciboFunc = {
    abrir: function(idVenta) {
        let url = '<%=request.getContextPath()%>/VentaController?accion=verRecibo&idVenta=' + idVenta;

        fetch(url)
            .then(res => res.text())
            .then(html => {
                document.querySelector('#modalRecibo .modal-body').innerHTML = html;
                const modal = new bootstrap.Modal(document.getElementById('modalRecibo'));
                modal.show();
            })
            .catch(err => console.error("Error al cargar recibo:", err));
    }
};
</script>

</body>
</html>
