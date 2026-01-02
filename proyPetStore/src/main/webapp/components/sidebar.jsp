<%
String url = request.getContextPath() + "/";
String rol = (String) session.getAttribute("rol");
%>

<div class="sidebar">
    <h4 class="text-center mb-4">
        <i class="fas fa-paw"></i><br>
        PetShop System
    </h4>

    <a href="<%=url%>InicioController">
        <i class="fas fa-home"></i> Dashboard
    </a>

    <a href="<%=url%>ClienteController?op=listar">
        <i class="fas fa-users"></i> Clientes
    </a>

    <a href="<%=url%>MascotaController?op=listar">
        <i class="fas fa-dog"></i> Mascotas
    </a>

    <a href="<%=url%>ProductoController?op=listar">
        <i class="fas fa-box-open"></i> Productos
    </a>

    <% if("ADMIN".equals(rol)) { %>
        <hr>
        <a href="<%=url%>EmpleadosController?op=listar">
            <i class="fas fa-user-tie"></i> Empleados
        </a>
        <a href="<%=url%>ServicioController?op=listar">
            <i class="fas fa-bath"></i> Servicios
        </a>
        <a href="<%=url%>ReporteController">
            <i class="fas fa-chart-line"></i> Reportes
        </a>
    <% } %>

    <hr>
    <a href="<%=url%>LoginController">
        <i class="fas fa-sign-out-alt"></i> Salir
    </a>
</div>
