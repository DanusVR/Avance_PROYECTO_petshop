<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%
String nombre = (String) session.getAttribute("nombreCompleto");
String rol = (String) session.getAttribute("rol");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>PetShop Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet"/>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { margin:0; font-family: Arial,sans-serif; background-color: #f8f9fa; }
        /* SIDEBAR */
        .sidebar {
            width: 250px;
            background-color: #ffeef4;
            padding: 20px;
            position: fixed;
            height: 100%;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .logo { font-size: 26px; font-weight:bold; color:#c23852; margin-bottom:30px; text-align:center; }
        .menu a { display:block; padding:10px; margin-bottom:8px; color:#b5475d; text-decoration:none; border-radius:5px; transition:0.3s; cursor:pointer; }
        .menu a:hover, .menu a.active { background-color: #ffdbe6; }
        .submenu { display:none; padding-left:15px; }
        .submenu a { font-size:14px; padding:8px; }

        /* CONTENIDO */
        .content { margin-left:270px; padding:25px; }
        .header { margin-bottom:20px; }
        .card { border-radius:15px; transition: transform 0.3s; }
        .card:hover { transform: translateY(-5px); box-shadow:0 8px 15px rgba(0,0,0,.2); }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <div class="logo">🐾 PETSHOP</div>
    <div class="menu">
        <a id="menuDashboard" class="active">📊 Dashboard</a>

        <!-- CLIENTES -->
        <a id="menuClientes">👤 Clientes</a>
        <div id="submenuClientes" class="submenu">
            <a id="btnNuevoCliente">➕ Nuevo Cliente</a>
            <a id="btnListarClientes">📋 Listar Clientes</a>
        </div>

        <!-- MASCOTAS -->
        <a id="menuMascotas">🐶 Mascotas</a>
        <div id="submenuMascotas" class="submenu">
            <a id="btnNuevaMascota">➕ Nueva Mascota</a>
            <a id="btnListarMascotas">📋 Listar Mascotas</a>
        </div>

        <a id="menuProductos">📦 Productos</a>
        <% if("ADMIN".equals(rol)) { %>
        <a id="menuServicios">🛁 Servicios</a>
        <% } %>
        <a id="menuVentas">💰 Ventas</a>
    </div>
</div>

<!-- CONTENIDO -->
<div class="content">
    <div class="header">
        <h3>Bienvenido, <%=nombre%> 🐾</h3>
        <p>Seleccione una opción del menú</p>
    </div>

    <div id="contenidoPrincipal" class="bg-white p-3 rounded shadow-sm">
        <!-- DASHBOARD INICIAL -->
        <div class="row g-3">
            <div class="col-md-3">
                <div class="card text-center p-3 shadow-sm">
                    <i class="fas fa-users fa-2x mb-2"></i>
                    <h5>Clientes</h5>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center p-3 shadow-sm">
                    <i class="fas fa-dog fa-2x mb-2"></i>
                    <h5>Mascotas</h5>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center p-3 shadow-sm">
                    <i class="fas fa-box-open fa-2x mb-2"></i>
                    <h5>Productos</h5>
                </div>
            </div>
            <% if("ADMIN".equals(rol)) { %>
            <div class="col-md-3">
                <div class="card text-center p-3 shadow-sm">
                    <i class="fas fa-bath fa-2x mb-2"></i>
                    <h5>Servicios</h5>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>

<!-- Bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const contextPath = '<%= request.getContextPath() %>';

    function toggle(id) {
        const el = document.getElementById(id);
        el.style.display = (el.style.display === "block") ? "none" : "block";
    }

    // Submenus
    document.getElementById("menuClientes").onclick = () => toggle("submenuClientes");
    document.getElementById("menuMascotas").onclick = () => toggle("submenuMascotas");

    // Cargar Dashboard inicial
    document.getElementById("menuDashboard").onclick = () => {
        setActive(this);
        document.getElementById("contenidoPrincipal").innerHTML = `
            <div class="row g-3">
                <div class="col-md-3">
                    <div class="card text-center p-3 shadow-sm">
                        <i class="fas fa-users fa-2x mb-2"></i>
                        <h5>Clientes</h5>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center p-3 shadow-sm">
                        <i class="fas fa-dog fa-2x mb-2"></i>
                        <h5>Mascotas</h5>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-center p-3 shadow-sm">
                        <i class="fas fa-box-open fa-2x mb-2"></i>
                        <h5>Productos</h5>
                    </div>
                </div>
                <% if("ADMIN".equals(rol)) { %>
                <div class="col-md-3">
                    <div class="card text-center p-3 shadow-sm">
                        <i class="fas fa-bath fa-2x mb-2"></i>
                        <h5>Servicios</h5>
                    </div>
                </div>
                <% } %>
            </div>
        `;
    };

    // Función para cargar contenido dinámico vía fetch (Clientes, Mascotas, etc.)
    document.getElementById("btnNuevoCliente").onclick = () => fetchFragment("/ClienteController?op=nuevo");
    document.getElementById("btnListarClientes").onclick = () => fetchFragment("/ClienteController?op=listar");
    document.getElementById("btnNuevaMascota").onclick = () => fetchFragment("/MascotaController?op=nuevo");
    document.getElementById("btnListarMascotas").onclick = () => fetchFragment("/MascotaController?op=listar");

    function fetchFragment(url) {
        fetch(contextPath + url)
            .then(res => res.text())
            .then(html => {
                document.getElementById("contenidoPrincipal").innerHTML = html;
            })
            .catch(() => {
                document.getElementById("contenidoPrincipal").innerHTML =
                    "<div class='alert alert-danger'>Error al cargar contenido</div>";
            });
    }

    // Resaltar menú activo
    function setActive(el) {
        document.querySelectorAll('.menu a').forEach(a => a.classList.remove('active'));
        el.classList.add('active');
    }
</script>
</body>
</html>
