<%@page import="java.util.List" %>
    <%@page import="com.proyPetStore.beans.Venta" %>
        <%@page import="java.text.SimpleDateFormat" %>
            <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

                <% List<Venta> lista = (List<Venta>) request.getAttribute("listaVentas");
                        String fInicio = (String) request.getAttribute("fechaInicio");
                        String fFin = (String) request.getAttribute("fechaFin");

                        if(fInicio == null) fInicio = "";
                        if(fFin == null) fFin = "";
                        %>

                        <div class="container-fluid">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h2 class="text-secondary"><i class="fas fa-chart-bar"></i> Reporte de Ventas</h2>
                            </div>

                            <!-- Filter Card -->
                            <div class="card shadow-sm mb-4 border-0">
                                <div class="card-body">
                                    <h5 class="card-title mb-3 text-muted">Filtros de Búsqueda</h5>
                                    <div class="row g-3 align-items-end">
                                        <div class="col-md-4">
                                            <label for="fechaInicio" class="form-label">Fecha Inicio</label>
                                            <input type="date" id="fechaInicio" class="form-control"
                                                value="<%=fInicio%>">
                                        </div>
                                        <div class="col-md-4">
                                            <label for="fechaFin" class="form-label">Fecha Fin</label>
                                            <input type="date" id="fechaFin" class="form-control" value="<%=fFin%>">
                                        </div>
                                        <div class="col-md-4">
                                            <button class="btn btn-primary w-100" onclick="buscarReporte()">
                                                <i class="fas fa-search"></i> Filtrar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Results Table -->
                            <div class="card shadow border-0">
                                <div class="card-body p-0">
                                    <div class="table-responsive">
                                        <table class="table table-hover table-striped align-middle mb-0">
                                            <thead class="bg-light">
                                                <tr>
                                                    <th scope="col" class="ps-4">ID</th>
                                                    <th scope="col">Fecha</th>
                                                    <th scope="col">Cliente</th>
                                                    <th scope="col">Vendedor</th>
                                                    <th scope="col">Tipo Pago</th>
                                                    <th scope="col" class="text-end pe-4">Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% if (lista !=null && !lista.isEmpty()) { double granTotal=0;
                                                    SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy HH:mm"); for
                                                    (Venta v : lista) { granTotal +=v.getTotal(); %>
                                                    <tr>
                                                        <td class="ps-4 fw-bold">#<%= v.getId_venta() %>
                                                        </td>
                                                        <td>
                                                            <%= v.getFecha() %>
                                                        </td>
                                                        <td>
                                                            <%= v.getNombreCliente() %>
                                                        </td>
                                                        <td>
                                                            <%= v.getNombreUsuario() %>
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-secondary">
                                                                <%= v.getTipo_pago() %>
                                                            </span>
                                                        </td>
                                                        <td class="text-end pe-4 fw-bold text-success">S/ <%=
                                                                String.format("%.2f", v.getTotal()) %>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                                        <!-- Summary Row -->
                                                        <tr class="table-active">
                                                            <td colspan="5" class="text-end fw-bold">TOTAL VENTAS:</td>
                                                            <td class="text-end pe-4 fw-bold fs-5 text-primary">S/ <%=
                                                                    String.format("%.2f", granTotal) %>
                                                            </td>
                                                        </tr>
                                                        <% } else { %>
                                                            <tr>
                                                                <td colspan="6" class="text-center py-5 text-muted">
                                                                    <i class="fas fa-info-circle fa-2x mb-3"></i><br>
                                                                    <% if(fInicio.isEmpty() && fFin.isEmpty()){ %>
                                                                        Seleccione un rango de fechas para generar el
                                                                        reporte.
                                                                        <% } else { %>
                                                                            No se encontraron ventas en el rango
                                                                            seleccionado.
                                                                            <% } %>
                                                                </td>
                                                            </tr>
                                                            <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <script>
                            function buscarReporte() {
                                const fInicio = document.getElementById("fechaInicio").value;
                                const fFin = document.getElementById("fechaFin").value;

                                if (fInicio === "" || fFin === "") {
                                    alert("Por favor seleccione ambas fechas");
                                    return;
                                }

                                if (fInicio > fFin) {
                                    alert("La fecha de inicio no puede ser mayor a la fecha fin");
                                    return;
                                }

                                // Use fetchFragment from inicio.jsp context
                                fetchFragment('/ReporteController?op=filtrar&fechaInicio=' + fInicio + '&fechaFin=' + fFin);
                            }
                        </script>