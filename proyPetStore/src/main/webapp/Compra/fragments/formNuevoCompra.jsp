<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ page
        import="java.util.List, java.util.ArrayList, com.proyPetStore.beans.Proveedor, com.proyPetStore.beans.Producto"
        %>

        <% //==================Preparar datos==================String url=request.getContextPath() + "/" ;
            List<Proveedor> listaProveedores = (List<Proveedor>) request.getAttribute("listarProveedor");
                if (listaProveedores == null) listaProveedores = new ArrayList<>();

                    // Lista de productos
                    List<Producto> listaProductos = (List<Producto>) request.getAttribute("listarProductos");
                            if (listaProductos == null) listaProductos = new ArrayList<>();

                                // Construir JSON de productos para usar en JS
                                StringBuilder sb = new StringBuilder("[");
                                for (int i = 0; i < listaProductos.size(); i++) { Producto p=listaProductos.get(i);
                                    String nombreClean=p.getNombre() !=null ? p.getNombre().replace("\"", ""
                                    ).replace("'", "" ) : "" ;
                                    sb.append(String.format(java.util.Locale.US,"{\"id\":%d,\"nombre\":\"%s\",\"precio\":%.2f}",
                                    p.getId_producto(), nombreClean, p.getPrecio_costo())); if (i <
                                    listaProductos.size() - 1) sb.append(","); } sb.append("]"); String
                                    jsonProductos=sb.toString(); %>

                                    <input type="hidden" id="dataProductos" value='<%=jsonProductos%>'>

                                    <!-- ================== Contenedor principal ================== -->
                                    <div class="container-fluid">
                                        <h3 class="text-center text-primary mb-4">
                                            <i class="bi bi-cart-plus"></i> Registrar Nueva Compra
                                        </h3>

                                        <div class="card shadow-sm">
                                            <div class="card-body">

                                                <!-- ================== Formulario ================== -->
                                                <form action="<%=request.getContextPath()%>/CompraController"
                                                    method="post" id="formCompra" onsubmit="handleCompraSubmit(event)">
                                                    <input type="hidden" name="op" value="insertar">
                                                    <input type="hidden" name="total" id="inputTotal" value="0.0">

                                                    <!-- ===== Seleccionar Proveedor ===== -->
                                                    <div class="mb-4">
                                                        <label class="form-label fw-bold">Proveedor</label>
                                                        <select name="id_proveedor" id="id_proveedor"
                                                            class="form-select form-select-lg" required>
                                                            <option value="">-- Seleccione un proveedor --</option>
                                                            <% for (Proveedor p : listaProveedores) { %>
                                                                <option value="<%=p.getIdProveedor()%>">
                                                                    <%=p.getNombre()%>
                                                                </option>
                                                                <% } %>
                                                        </select>
                                                    </div>

                                                    <!-- ===== Tabla Detalle de Productos ===== -->
                                                    <div class="mb-3">
                                                        <h5 class="fw-bold text-secondary">
                                                            <i class="bi bi-box-seam"></i> Detalle de Productos
                                                        </h5>
                                                        <table class="table table-bordered align-middle"
                                                            id="tablaDetalle">
                                                            <thead class="table-dark text-center">
                                                                <tr>
                                                                    <th>Producto</th>
                                                                    <th>Cantidad</th>
                                                                    <th>Precio Unitario (S/)</th>
                                                                    <th>Subtotal (S/)</th>
                                                                    <th>Acciones</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <!-- Filas dinámicas se agregarán con JS -->
                                                            </tbody>
                                                        </table>

                                                        <div class="text-end mb-3">
                                                            <strong>Total: S/ <span
                                                                    id="totalCompra">0.00</span></strong>
                                                        </div>

                                                        <button type="button" class="btn btn-success mb-3"
                                                            onclick="agregarFila()">
                                                            <i class="bi bi-plus-circle"></i> Agregar Producto
                                                        </button>
                                                    </div>

                                                    <!-- ===== Botones ===== -->
                                                    <div class="d-flex gap-2">
                                                        <button type="submit" class="btn btn-primary flex-fill">
                                                            <i class="bi bi-check-circle"></i> Registrar Compra
                                                        </button>
                                                        <button type="button" class="btn btn-secondary flex-fill"
                                                            data-bs-dismiss="modal">
                                                            <i class="bi bi-x-circle"></i> Cancelar
                                                        </button>
                                                    </div>

                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- ================== Scripts y estilos ================== -->
                                    <!-- Bootstrap Icons -->
                                    <link rel="stylesheet"
                                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

                                    <!-- Aquí puedes agregar tus scripts para agregar filas dinámicas, calcular subtotal y total -->
                                    <script>
                                        // Usar una funcion autoejecutable o scope local no funciona bien con la reinyeccion de scripts de inicio.jsp
                                        // Mejor definimos funciones en window o usamos var, y leemos los datos dentro de las funciones

                                        function obtenerProductosData() {
                                            try {
                                                return JSON.parse(document.getElementById('dataProductos').value);
                                            } catch (e) {
                                                console.error("Error parsing dataProductos", e);
                                                return [];
                                            }
                                        }

                                        function agregarFila() {
                                            const productosLista = obtenerProductosData();
                                            const tbody = document.querySelector('#tablaDetalle tbody');
                                            const row = document.createElement('tr');

                                            // Usar concatenación para evitar conflicto con JSP EL
                                            const options = productosLista.map(p => '<option value="' + p.id + '" data-precio="' + p.precio + '">' + p.nombre + '</option>').join('');

                                            row.innerHTML = '<td>' +
                                                '<select name="id_producto" class="form-select form-select-sm" onchange="actualizarPrecio(this)">' +
                                                '<option value="">-- Seleccione --</option>' +
                                                options +
                                                '</select>' +
                                                '</td>' +
                                                '<td><input type="number" name="cantidad" class="form-control form-control-sm" value="1" min="1" onchange="calcularTotal()"></td>' +
                                                '<td><input type="number" name="precio_unitario" class="form-control form-control-sm" value="0.00" step="0.01" onchange="calcularTotal()"></td>' +
                                                '<td class="subtotal">0.00</td>' +
                                                '<td><button type="button" class="btn btn-danger btn-sm" onclick="this.closest(\'tr\').remove(); calcularTotal();">Eliminar</button></td>';

                                            tbody.appendChild(row);
                                            calcularTotal();
                                        }

                                        function actualizarPrecio(select) {
                                            const option = select.options[select.selectedIndex];
                                            const precio = option.getAttribute('data-precio') || '0.00';
                                            const row = select.closest('tr');
                                            row.querySelector('input[name="precio_unitario"]').value = precio;
                                            calcularTotal();
                                        }

                                        function calcularTotal() {
                                            let total = 0;
                                            document.querySelectorAll('#tablaDetalle tbody tr').forEach(tr => {
                                                const cantidad = parseFloat(tr.querySelector('input[name="cantidad"]').value || 0);
                                                const precio = parseFloat(tr.querySelector('input[name="precio_unitario"]').value || 0);
                                                const subtotal = cantidad * precio;
                                                tr.querySelector('.subtotal').textContent = subtotal.toFixed(2);
                                                total += subtotal;
                                            });
                                            const totalSpan = document.getElementById('totalCompra');
                                            if (totalSpan) totalSpan.textContent = total.toFixed(2);
                                            const inputTotal = document.getElementById('inputTotal');
                                            if (inputTotal) inputTotal.value = total.toFixed(2);
                                        }

                                        function handleCompraSubmit(event) {
                                            event.preventDefault(); // Evitar submit tradicional

                                            if (!validarCompra()) return;

                                            const form = document.getElementById('formCompra');
                                            // Convertir FormData a URLSearchParams para enviar x-www-form-urlencoded
                                            // Esto evita problemas con @MultipartConfig no presente en el servlet
                                            const formData = new FormData(form);
                                            const params = new URLSearchParams();

                                            for (const pair of formData.entries()) {
                                                params.append(pair[0], pair[1]);
                                            }

                                            // Agregar op=insertarAjax
                                            params.set('op', 'insertarAjax');

                                            fetch(form.action, {
                                                method: 'POST',
                                                body: params // Envia como application/x-www-form-urlencoded
                                            })
                                                .then(response => {
                                                    const contentType = response.headers.get("content-type");
                                                    if (contentType && contentType.indexOf("application/json") !== -1) {
                                                        return response.json();
                                                    } else {
                                                        return response.text().then(text => {
                                                            throw new Error("Respuesta no es JSON: " + text.substring(0, 100) + "...");
                                                        });
                                                    }
                                                })
                                                .then(data => {
                                                    if (data.success) {
                                                        alert(data.mensaje);
                                                        // Cerrar modal
                                                        const modalEl = document.getElementById('modalCompra');
                                                        const modalInstance = bootstrap.Modal.getInstance(modalEl);
                                                        if (modalInstance) {
                                                            modalInstance.hide();
                                                        }
                                                        // Recargar lista
                                                        fetchFragment('/CompraController?op=listar');
                                                    } else {
                                                        alert('Error: ' + data.mensaje);
                                                    }
                                                })
                                                .catch(error => {
                                                    console.error('Error fetch:', error);
                                                    alert('Error al registrar la compra: ' + error.message);
                                                });
                                        }

                                        function validarCompra() {
                                            const proveedor = document.getElementById('id_proveedor').value;
                                            if (!proveedor) {
                                                alert('Por favor seleccione un proveedor');
                                                return false;
                                            }

                                            const filas = document.querySelectorAll('#tablaDetalle tbody tr');
                                            if (filas.length === 0) {
                                                alert('Debe agregar al menos un producto a la compra');
                                                return false;
                                            }

                                            // Validar que todos los productos estén seleccionados
                                            for (let tr of filas) {
                                                const producto = tr.querySelector('select[name="id_producto"]').value;
                                                if (!producto) {
                                                    alert('Debe seleccionar un producto en todas las filas');
                                                    return false;
                                                }
                                            }
                                            // Ensure hidden total is updated
                                            calcularTotal();
                                            return true;
                                        }

                                        document.querySelector('#tablaDetalle').addEventListener('input', calcularTotal);
                                    </script>