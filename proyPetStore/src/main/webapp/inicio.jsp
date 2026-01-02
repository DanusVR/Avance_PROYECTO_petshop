<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%
String nombre = (String) session.getAttribute("nombreCompleto");
String rol = (String) session.getAttribute("rol");

if(nombre == null){
    response.sendRedirect(request.getContextPath() + "/LoginController");
    return;
}
String currentUrl = request.getRequestURI();
String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>PetShop Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- FontAwesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet"/>

<style>
body{
    margin:0;
    font-family:'Segoe UI', sans-serif;
    min-height:100vh;
    background: linear-gradient(135deg,#fdf0f6,#f8fbff,#fdf0f6);
}

/* ===== SIDEBAR ===== */
.sidebar{
    position:fixed;
    width:260px;
    height:100vh;
    background:rgba(236,140,170,0.85);
    backdrop-filter:blur(12px);
    padding:25px 20px;
    box-shadow:4px 0 25px rgba(0,0,0,.25);
    color:#fff;
    z-index:1000;
}
.logo{
    text-align:center;
    font-size:26px;
    font-weight:700;
    margin-bottom:40px;
}
.menu a{
    display:flex;
    align-items:center;
    gap:14px;
    padding:14px 18px;
    margin-bottom:12px;
    border-radius:16px;
    color:#fff;
    text-decoration:none;
    cursor:pointer;
    transition:.3s;
}
.menu a:hover,
.menu a.active{
    background:rgba(255,255,255,0.2);
}
.submenu{
    display:none;
    padding-left:25px;
}
.submenu a{
    font-size:.9rem;
    color:#fff;
    padding:8px 15px;
    display:block;
    border-radius:12px;
}
.submenu a:hover{
    background:rgba(255,255,255,0.15);
}

/* ===== TOPBAR ===== */
.topbar{
    margin-left:260px;    
    padding:18px 30px;
    background:rgba(255,255,255,0.7);
    backdrop-filter:blur(16px);
    border-radius:30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 10px 30px rgba(0,0,0,.12);
    margin-bottom:30px;
  
    z-index:2000;
    width: calc(100% - 260px); 
}
.user-menu button{
    border-radius:14px;
    font-weight:500;
}

/* ===== CONTENT ===== */
.content{
    margin-left:260px;
    padding:0 35px 35px;
}

/* ===== CARDS ===== */
.dashboard-card{
    background:rgba(255,255,255,.55);
    backdrop-filter:blur(18px);
    border-radius:25px;
    padding:30px 20px;
    text-align:center;
    box-shadow:0 15px 35px rgba(0,0,0,.15);
    transition:.4s;
    cursor:pointer;
}
.dashboard-card:hover{
    transform:translateY(-10px);
}
.dashboard-card:active{
    transform:scale(.96);
}
.dashboard-card i{
    font-size:3rem;
    margin-bottom:10px;
}
.dashboard-card h6{
    font-weight:600;
    color:#333;
}

/* ===== ANIM ===== */
.fade-enter{
    animation:fade .5s ease;
}
@keyframes fade{
    from{opacity:0; transform:translateY(25px)}
    to{opacity:1; transform:translateY(0)}
}
</style>
</head>

<body>


<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <div class="logo"><i class="fas fa-paw"></i> PETSHOP</div>
    <div class="menu">
        <a class="active"><i class="fas fa-chart-line"></i> Dashboard</a>

        <a id="menuClientes"><i class="fas fa-user"></i> Clientes</a>
        <div id="submenuClientes" class="submenu">
            <a onclick="fetchFragment('/ClienteController?op=nuevo')">➕ Nuevo</a>
            <a onclick="fetchFragment('/ClienteController?op=listar')">📋 Listar</a>
        </div>

        <a id="menuMascotas"><i class="fas fa-dog"></i> Mascotas</a>
        <div id="submenuMascotas" class="submenu">
            <a onclick="fetchFragment('/MascotaController?op=nuevo')">➕ Nueva</a>
            <a onclick="fetchFragment('/MascotaController?op=listar')">📋 Listar</a>
        </div>

        <a onclick="fetchFragment('/ProductoController?op=listar')">
            <i class="fas fa-box"></i> Productos
        </a>

        <% if("ADMIN".equals(rol)){ %>
        <a onclick="fetchFragment('/UsuarioController?op=listar')">
            <i class="fas fa-user-shield"></i> Usuarios
        </a>
        <% } %>

        <a href="<%=contextPath%>/LoginController?accion=logout">
            <i class="fas fa-door-open"></i> Salir
        </a>
    </div>
</div>
<!-- Navbar -->
<jsp:include page="/components/navbar.jsp" />
<!-- ===== TOPBAR ===== -->
<div class="topbar">
    <div>
        <strong>Hola, <%=nombre%></strong> 🐾
        <div class="text-muted small">Panel de control del PetShop</div>
    </div>


</div>

<!-- ===== CONTENT ===== -->
<div class="content">
    <div id="contenidoPrincipal" class="fade-enter">
        <div class="row g-4">
            <div class="col-md-3">
                <div class="dashboard-card" onclick="fetchFragment('/ClienteController?op=listar')">
                    <i class="fas fa-users text-danger"></i>
                    <h6>Clientes</h6>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card" onclick="fetchFragment('/MascotaController?op=listar')">
                    <i class="fas fa-dog text-success"></i>
                    <h6>Mascotas</h6>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dashboard-card" onclick="fetchFragment('/ProductoController?op=listar')">
                    <i class="fas fa-box-open text-primary"></i>
                    <h6>Productos</h6>
                </div>
            </div>
            <% if("ADMIN".equals(rol)){ %>
            <div class="col-md-3">
                <div class="dashboard-card" onclick="fetchFragment('/ServicioController?op=listar')">
                    <i class="fas fa-bath text-warning"></i>
                    <h6>Servicios</h6>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
const contextPath = '<%=contextPath%>';

function toggle(id){
    const el = document.getElementById(id);
    el.style.display = el.style.display === "block" ? "none" : "block";
}
document.getElementById("menuClientes").onclick = ()=>toggle("submenuClientes");
document.getElementById("menuMascotas").onclick = ()=>toggle("submenuMascotas");

function fetchFragment(url){
    const cont = document.getElementById("contenidoPrincipal");
    cont.classList.remove("fade-enter");
    fetch(contextPath + url)
        .then(r=>r.text())
        .then(html=>{
            cont.innerHTML = html;
            void cont.offsetWidth;
            cont.classList.add("fade-enter");
        })
        .catch(()=>{ cont.innerHTML="<div class='alert alert-danger'>Error</div>"; });
}
</script>

</body>
</html>
