<%@page contentType="text/html; charset=UTF-8" language="java" %>
    <% String nombre=(String) session.getAttribute("nombreCompleto"); String rol=(String) session.getAttribute("rol");
        if(nombre==null){ response.sendRedirect(request.getContextPath() + "/LoginController" ); return; } String
        currentUrl=request.getRequestURI(); String contextPath=request.getContextPath(); %>

        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>PetShop Dashboard</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <!-- Bootstrap -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- FontAwesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />

            <style>
                body {
                    margin: 0;
                    font-family: 'Segoe UI', sans-serif;
                    min-height: 100vh;
                    background: linear-gradient(135deg, #fdf0f6, #f8fbff, #fdf0f6);
                }

                /* ===== SIDEBAR ===== */
                .sidebar {
                    position: fixed;
                    width: 260px;
                    height: 100vh;
                    background: rgba(236, 140, 170, 0.85);
                    backdrop-filter: blur(12px);
                    padding: 25px 20px;
                    box-shadow: 4px 0 25px rgba(0, 0, 0, .25);
                    color: #fff;
                    z-index: 1000;
                }

                .logo {
                    text-align: center;
                    font-size: 26px;
                    font-weight: 700;
                    margin-bottom: 40px;
                }

                .menu a {
                    display: flex;
                    align-items: center;
                    gap: 14px;
                    padding: 14px 18px;
                    margin-bottom: 12px;
                    border-radius: 16px;
                    color: #fff;
                    text-decoration: none;
                    cursor: pointer;
                    transition: .3s;
                }

                .menu a:hover,
                .menu a.active {
                    background: rgba(255, 255, 255, 0.2);
                }

                .submenu {
                    display: none;
                    padding-left: 25px;
                }

                .submenu a {
                    font-size: .9rem;
                    color: #fff;
                    padding: 8px 15px;
                    display: block;
                    border-radius: 12px;
                }

                .submenu a:hover {
                    background: rgba(255, 255, 255, 0.15);
                }

                /* ===== TOPBAR ===== */
                .topbar {
                    margin-left: 260px;
                    padding: 18px 30px;
                    background: rgba(255, 255, 255, 0.7);
                    backdrop-filter: blur(16px);
                    border-radius: 30px;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, .12);
                    margin-bottom: 30px;

                    z-index: 2000;
                    width: calc(100% - 260px);
                }

                .user-menu button {
                    border-radius: 14px;
                    font-weight: 500;
                }

                /* ===== CONTENT ===== */
                .content {
                    margin-left: 260px;
                    padding: 0 35px 35px;
                }

                /* ===== CARDS ===== */
                .dashboard-card {
                    background: rgba(255, 255, 255, .55);
                    backdrop-filter: blur(18px);
                    border-radius: 25px;
                    padding: 30px 20px;
                    text-align: center;
                    box-shadow: 0 15px 35px rgba(0, 0, 0, .15);
                    transition: .4s;
                    cursor: pointer;
                }

                .dashboard-card:hover {
                    transform: translateY(-10px);
                }

                .dashboard-card:active {
                    transform: scale(.96);
                }

                .dashboard-card i {
                    font-size: 3rem;
                    margin-bottom: 10px;
                }

                .dashboard-card h6 {
                    font-weight: 600;
                    color: #333;
                }

                /* ===== ANIM ===== */
                .fade-enter {
                    animation: fade .5s ease;
                }

                @keyframes fade {
                    from {
                        opacity: 0;
                        transform: translateY(25px)
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0)
                    }
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

                    <a onclick="fetchFragment('/ServicioController?op=listar')">
                        <i class="fas fa-bath"></i> Servicios
                    </a>

                    <a onclick="fetchFragment('/CitaController?op=listar')">
                        <i class="fas fa-calendar-check"></i> Citas
                    </a>

                    <% if("ADMIN".equals(rol)){ %>
                        <a onclick="fetchFragment('/UsuarioController?op=listar')">
                            <i class="fas fa-user-shield"></i> Usuarios
                        </a>
                        <% } %>

                            <a id="menuVentas"><i class="fas fa-shopping-cart"></i> Ventas</a>
                            <div id="submenuVentas" class="submenu">
                                <a onclick="fetchFragment('/VentaController?op=nuevo')">➕ Nueva Venta</a>
                                <a onclick="fetchFragment('/VentaController?op=listar')">📋 Listar Ventas</a>
                            </div>

                            <a onclick="fetchFragment('/ReporteController?op=listar')">
                                <i class="fas fa-chart-bar"></i> Reportes
                            </a>

                            <a onclick="fetchFragment('/CompraController?op=listar')">
                                <i class="fas fa-shopping-bag"></i> Compras
                            </a>

                            <a onclick="fetchFragment('/HistorialController?op=listar')">
                                <i class="fas fa-history"></i> Historial
                            </a>

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

                function toggle(id) {
                    const el = document.getElementById(id);
                    el.style.display = el.style.display === "block" ? "none" : "block";
                }
                document.getElementById("menuClientes").onclick = () => toggle("submenuClientes");
                document.getElementById("menuMascotas").onclick = () => toggle("submenuMascotas");
                document.getElementById("menuVentas").onclick = () => toggle("submenuVentas");

                function fetchFragment(url) {
                    const cont = document.getElementById("contenidoPrincipal");
                    cont.classList.remove("fade-enter");
                    fetch(contextPath + url)
                        .then(r => r.text())
                        .then(html => {
                            cont.innerHTML = html;
                            void cont.offsetWidth;
                            cont.classList.add("fade-enter");
                        })
                        .catch(() => { cont.innerHTML = "<div class='alert alert-danger'>Error</div>"; });
                }

                // Global Scope for Client Modal
                const modalCliente = {
                    abrir: function (op, id = null) {
                        let url = 'ClienteController?op=' + op;
                        if (id) url += '&id=' + id;

                        fetch(contextPath + '/' + url)
                            .then(res => res.text())
                            .then(html => {
                                const modalBody = document.querySelector('#modalCliente .modal-body');
                                modalBody.innerHTML = html;

                                const modal = new bootstrap.Modal(document.getElementById('modalCliente'));
                                modal.show();
                            })
                            .catch(err => console.error("Error al abrir modal:", err));
                    }
                };

                // Global Validation Functions
                function validarCliente() {
                    let nombre = document.getElementById("nombreC").value.trim();
                    let apellido = document.getElementById("apellido").value.trim();
                    let telefono = document.getElementById("telefono").value.trim();
                    let direccion = document.getElementById("direccion").value.trim();

                    if (nombre === "") {
                        alert("El nombre es obligatorio");
                        return false;
                    }
                    if (apellido === "") {
                        alert("El apellido es obligatorio");
                        return false;
                    }

                    if (telefono === "" || telefono.length < 6 || isNaN(telefono)) {
                        alert("Ingrese un teléfono válido (solo números, min 6 dígitos)");
                        return false;
                    }

                    if (direccion === "") {
                        alert("La dirección es obligatoria");
                        return false;
                    }

                    return true;
                }

                function validarEdicion() {
                    return validarCliente();
                }

                // --- MODAL MASCOTA ---
                const modalMascota = {
                    abrir: function (op, id = null) {
                        let url = 'MascotaController?op=' + op;
                        if (id) url += '&id=' + id;
                        fetch(contextPath + '/' + url).then(r => r.text()).then(html => {
                            document.querySelector('#modalMascota .modal-body').innerHTML = html;
                            new bootstrap.Modal(document.getElementById('modalMascota')).show();
                        }).catch(e => console.error(e));
                    }
                };

                // --- MODAL PRODUCTO ---
                const modalProducto = {
                    abrir: function (op, id = null) {
                        let url = 'ProductoController?op=' + op;
                        if (id) url += '&id=' + id;
                        fetch(contextPath + '/' + url).then(r => r.text()).then(html => {
                            document.querySelector('#modalProducto .modal-body').innerHTML = html;
                            new bootstrap.Modal(document.getElementById('modalProducto')).show();
                        }).catch(e => console.error(e));
                    }
                };

                function validarProducto() {
                    let nombre = document.getElementById("nombre").value.trim();
                    let categoria = document.getElementById("id_categoria").value;
                    let stock = document.getElementById("stock").value;
                    let precioCosto = document.getElementById("precio_costo").value;
                    let precioVenta = document.getElementById("precio_venta").value;
                    let estado = document.getElementById("estado").value;
                    let fecha = document.getElementById("fecha_registro").value;

                    if (nombre === "") { alert("El nombre es obligatorio"); return false; }
                    if (categoria === "") { alert("Seleccione una categoría"); return false; }
                    if (stock === "" || isNaN(stock) || parseInt(stock) < 0) { alert("Ingrese un stock válido"); return false; }
                    if (precioCosto === "" || isNaN(precioCosto) || parseFloat(precioCosto) < 0) { alert("Ingrese un precio de costo válido"); return false; }
                    if (precioVenta === "" || isNaN(precioVenta) || parseFloat(precioVenta) < 0) { alert("Ingrese un precio de venta válido"); return false; }
                    if (estado === "") { alert("Seleccione un estado"); return false; }
                    if (fecha === "") { alert("Seleccione una fecha de registro"); return false; }
                    return true;
                }

                // --- MODAL HISTORIAL ---
                const modalHistorial = {
                    abrir: function (arg1, arg2 = null) {
                        // Handle simple 'nuevo'/'editar' or direct idMascota call
                        let url = '';
                        if (typeof arg1 === 'number') {
                            // Called via modalHistorial.abrir(idMascota) from Mascota list
                            url = 'HistorialMedicoController?op=listarPorMascota&id_mascota=' + arg1;
                        } else {
                            // Called via 'nuevo'/'editar' from Historial list
                            let op = arg1;
                            let id = arg2;
                            url = 'HistorialMedicoController?op=' + op;
                            if (id && op === 'editar') url += '&id_historial=' + id;
                        }

                        fetch(contextPath + '/' + url).then(r => r.text()).then(html => {
                            document.querySelector('#modalHistorial .modal-body').innerHTML = html;
                            new bootstrap.Modal(document.getElementById('modalHistorial')).show();
                        }).catch(e => console.error(e));
                    }
                };

                function validarHistorial() {
                    let mascotaElement = document.querySelector('select[name="id_mascota"]');
                    let fechaElement = document.querySelector('input[name="fecha"]');
                    let descripcionElement = document.querySelector('textarea[name="descripcion"]');

                    // Check if elements exist before value (in case form structure varies)
                    if (!mascotaElement || !fechaElement || !descripcionElement) return true;

                    let mascota = mascotaElement.value;
                    let fecha = fechaElement.value;
                    let descripcion = descripcionElement.value.trim();

                    if (mascota === "") { alert("Seleccione una mascota."); return false; }
                    if (fecha === "") { alert("Ingrese la fecha."); return false; }
                    if (descripcion.length < 5) { alert("La descripción debe tener al menos 5 caracteres."); return false; }
                    return true;
                }

                // --- MODAL SERVICIO ---
                const modalServicio = {
                    abrir: function (op, id = null) {
                        let url = 'ServicioController?op=' + op;
                        if (id) url += '&id=' + id;
                        fetch(contextPath + '/' + url).then(r => r.text()).then(html => {
                            document.querySelector('#modalServicio .modal-body').innerHTML = html;
                            new bootstrap.Modal(document.getElementById('modalServicio')).show();
                        }).catch(e => console.error(e));
                    }
                };

                function validarServicio() {
                    let nombre = document.getElementById("nombre").value.trim();
                    let tipo = document.getElementById("tipo").value;
                    let mascota = document.getElementById("id_mascota").value;
                    let descripcion = document.getElementById("descripcion").value.trim();
                    let precio = document.getElementById("precio").value.trim();
                    let estado = document.getElementById("estado").value;

                    if (nombre === "") { alert("El nombre es obligatorio"); return false; }
                    if (tipo === "") { alert("Debe seleccionar un tipo de servicio"); return false; }
                    if (mascota === "") { alert("Debe seleccionar una mascota"); return false; }
                    if (descripcion === "") { alert("La descripción es obligatoria"); return false; }
                    if (precio === "" || isNaN(precio) || precio <= 0) { alert("Ingrese un precio válido mayor a 0"); return false; }
                    if (estado === "") { alert("Debe seleccionar un estado"); return false; }
                    return true;
                }

                // --- MODAL CITA ---
                const modalCita = {
                    abrir: function (op, id = null) {
                        let url = 'CitaController?op=' + op;
                        if (id) url += '&id=' + id;
                        fetch(contextPath + '/' + url).then(r => r.text()).then(html => {
                            document.querySelector('#modalCita .modal-body').innerHTML = html;
                            new bootstrap.Modal(document.getElementById('modalCita')).show();
                        }).catch(e => console.error(e));
                    }
                };

                function validarCita() {
                    let mascota = document.getElementById("mascota").value;
                    let servicio = document.getElementById("servicio").value;
                    let fecha = document.getElementById("fecha").value;
                    let hora = document.getElementById("hora").value;
                    let estado = document.getElementById("estado").value;

                    if (!mascota) { alert("Debe seleccionar una mascota."); return false; }
                    if (!servicio) { alert("Debe seleccionar un servicio."); return false; }
                    if (!fecha) { alert("Seleccione una fecha válida."); return false; }
                    if (!hora) { alert("Seleccione una hora válida."); return false; }
                    if (!estado) { alert("Debe seleccionar un estado."); return false; }
                    return true;
                }
            </script>

        </body>

        </html>
        ```