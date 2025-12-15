<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard PetShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { min-height: 100vh; display: flex; background: #f4f6f9; }
        .sidebar { width: 250px; background-color: #d63384; color: white; flex-shrink: 0; padding-top: 20px; }
        .sidebar .menu a { color: white; text-decoration: none; display: block; padding: 10px 20px; margin-bottom: 2px; border-radius: 5px; }
        .sidebar .menu a:hover, .sidebar .menu a.active { background-color: #a51c65; }
        .main-content { flex-grow: 1; padding: 20px; }
        .card-dashboard { cursor: pointer; transition: transform 0.1s; }
        .card-dashboard:hover { transform: scale(1.03); }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h3 class="text-center mb-4">PETSHOP</h3>
    <div class="menu">
        <a href="#" onclick="cargarPagina('dashboardHome.jsp')" class="active"><i class="fa-solid fa-house"></i> Dashboard</a>

        <a href="#ventasSubmenu" data-bs-toggle="collapse"><i class="fa-solid fa-receipt"></i> Ventas</a>
        <div class="collapse ps-3" id="ventasSubmenu">
            <a href="#" onclick="cargarPagina('Venta/NuevaVenta.jsp')">Nueva Venta</a>
            <a href="#" onclick="cargarPagina('Venta/listarVentas.jsp')">Listar Ventas</a>
        </div>

        <a href="#productosSubmenu" data-bs-toggle="collapse"><i class="fa-solid fa-box"></i> Productos</a>
        <div class="collapse ps-3" id="productosSubmenu">
            <a href="#" onclick="cargarPagina('Producto/listarProducto.jsp')">Lista de productos</a>
            <a href="#" onclick="cargarPagina('Producto/formAgregarProducto.jsp')">Agregar productos</a>
        </div>

        <a href="#clientesSubmenu" data-bs-toggle="collapse"><i class="fa-solid fa-user"></i> Clientes</a>
        <div class="collapse ps-3" id="clientesSubmenu">
            <a href="#" onclick="cargarPagina('Cliente/listarClientes.jsp')">Listar clientes</a>
            <a href="#" onclick="cargarPagina('Cliente/formAgregarCliente.jsp')">Agregar cliente</a>
        </div>

        <a href="#configSubmenu" data-bs-toggle="collapse"><i class="fa-solid fa-gear"></i> Configuración</a>
        <div class="collapse ps-3" id="configSubmenu">
            <a href="#" onclick="cargarPagina('config.jsp')">Opciones</a>
        </div>
    </div>
</div>

<!-- Main content -->
<div class="main-content" id="contenidoCentral">
    <!--<jsp:include page="dashboardHome.jsp" />-->
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function cargarPagina(pagina) {
    const contenido = document.getElementById('contenidoCentral');
    fetch(pagina)
        .then(response => response.text())
        .then(html => {
            contenido.innerHTML = html;
            if(window.inicializarGraficos) inicializarGraficos(); // para Chart.js
        })
        .catch(err => console.error('Error al cargar la página: ', err));
}

function aplicarFiltro(texto) {
    const contenido = document.getElementById('contenidoCentral');
    fetch('dashboardHome.jsp?filtro=' + encodeURIComponent(texto))
        .then(response => response.text())
        .then(html => {
            contenido.innerHTML = html;
            if(window.inicializarGraficos) inicializarGraficos();
        });
}
</script>
</body>
</html>
