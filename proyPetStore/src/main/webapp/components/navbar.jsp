<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String currentUrl = request.getRequestURI();
String contextPath = request.getContextPath();
String nombreUsuario = (String) session.getAttribute("nombreCompleto");
String rol = (String) session.getAttribute("rol");
boolean esAdmin = "ADMIN".equals(rol);

if(nombreUsuario == null) {
    response.sendRedirect(contextPath + "/LoginController");
    return;
}
%>
<nav class="navbar navbar-expand-lg navbar-dark navbar-rosa">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%=contextPath%>/inicio.jsp">
            
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
            data-bs-target="#navbarNav" aria-controls="navbarNav" 
            aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Contenido colapsable -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto"> <!-- ms-auto empuja a la derecha -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" 
                        role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-circle"></i> <%=nombreUsuario%>
                        <% if(esAdmin) { %>
                            <span class="badge bg-warning text-dark">Admin</span>
                        <% } %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li>
                            <h6 class="dropdown-header">
                                <i class="fas fa-user"></i> <%=nombreUsuario%>
                            </h6>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item" href="#">
                                <i class="fas fa-user-edit"></i> Mi Perfil
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="#">
                                <i class="fas fa-key"></i> Cambiar Contraseña
                            </a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item text-danger" href="<%=contextPath%>/LoginController?accion=logout">
                                <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<style>
/* Navbar rosa fuerte que combina con tu sidebar */
.navbar-rosa {
    background: rgba(236,140,170,0.85);
    box-shadow: 0 2px 6px rgba(0,0,0,0.1); 
    border-bottom: none;
}

/* Links */
.nav-link {
    transition: all 0.3s;
    color: #fff !important;
}

.nav-link.active {
    background-color: rgba(255, 255, 255, 0.2);
    border-radius: 8px;
}

.nav-link:hover {
    background-color: rgba(255, 255, 255, 0.15);
    border-radius: 8px;
}

/* Dropdown */
.dropdown-menu {
    box-shadow: 0 4px 10px rgba(0,0,0,.15);
    border-radius: 8px;
}

/* Badge admin */
.badge {
    font-size: 0.7rem;
    vertical-align: middle;
}

/* Navbar brand */
.navbar-brand {
    font-weight: bold;
    font-size: 1.4rem;
    color: #fff !important;
}
</style>




