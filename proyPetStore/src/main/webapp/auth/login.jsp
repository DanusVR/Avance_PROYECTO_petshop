<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
String url = request.getContextPath() + "/";
%>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PetShop System | Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
/* Fondo */
body{
    min-height:100vh;
    background:url('https://images.unsplash.com/photo-1592194996308-7b43878e84a6?auto=format&fit=crop&w=1470&q=80')
    no-repeat center center fixed;
    background-size:cover;
    display:flex;
    align-items:center;
    justify-content:center;
    font-family:'Segoe UI', sans-serif;
    position:relative;
}

/* Overlay suave */
body::before{
    content:"";
    position:absolute;
    inset:0;
    background:rgba(0,0,0,0.35);
    backdrop-filter:blur(2px);
}

/* Card */
.login-card{
    position:relative;
    z-index:1;
    width:100%;
    max-width:420px;
    background:rgba(255,255,255,0.22);
    backdrop-filter:blur(16px);
    border-radius:22px;
    padding:45px 40px;
    box-shadow:0 20px 45px rgba(0,0,0,0.35);
    color:#fff;
    animation:fadeUp .9s ease forwards;
}

@keyframes fadeUp{
    from{opacity:0; transform:translateY(40px);}
    to{opacity:1; transform:translateY(0);}
}

/* Logo */
.login-logo{
    text-align:center;
    margin-bottom:30px;
}
.login-logo i{
    font-size:3.2rem;
    color:#ff6fae;
}
.login-logo h4{
    margin-top:10px;
    font-weight:700;
}
.login-logo span{
    font-size:.9rem;
    opacity:.9;
}

/* Inputs */
.input-group{
    background:rgba(255,255,255,0.28);
    border-radius:16px;
    overflow:hidden;
    margin-bottom:18px;
    transition:.3s;
}
.input-group:focus-within{
    background:rgba(255,255,255,0.45);
    box-shadow:0 0 0 2px rgba(255,111,174,0.6);
}

.input-group-text{
    background:transparent;
    border:none;
    color:#fff;
    padding-left:18px;
}

.form-control{
    background:transparent;
    border:none;
    color:#fff;
    padding:14px 12px;
}
.form-control::placeholder{
    color:rgba(255,255,255,.85);
}
.form-control:focus{
    box-shadow:none;
    background:transparent;
    color:#fff;
}

/* Toggle */
.toggle-password{
    background:transparent;
    border:none;
    color:#fff;
    padding-right:18px;
    cursor:pointer;
}

/* Botón */
.btn-login{
    margin-top:10px;
    background:linear-gradient(135deg,#ff6fae,#ffc1dc);
    border:none;
    border-radius:16px;
    padding:14px;
    font-weight:600;
    color:#fff;
    transition:.3s;
}
.btn-login:hover{
    transform:translateY(-3px);
    box-shadow:0 12px 25px rgba(255,79,154,.6);
}

/* Footer */
.footer{
    position:absolute;
    bottom:20px;
    color:#fff;
    opacity:.85;
    font-size:.85rem;
    z-index:1;
}
</style>
</head>

<body>

<div class="login-card">

    <div class="login-logo">
        <i class="fas fa-paw"></i>
        <h4>PetShop System</h4>
        <span>Bienvenido nuevamente 🐶</span>
    </div>

    <%
    String error = (String) request.getAttribute("error");
    if (error != null) {
    %>
    <div class="alert alert-danger text-center py-2">
        <i class="fas fa-circle-exclamation"></i> <%= error %>
    </div>
    <% } %>

    <form action="<%=url%>LoginController" method="POST">
        <input type="hidden" name="accion" value="login">

        <div class="input-group">
            <span class="input-group-text">
                <i class="fas fa-user"></i>
            </span>
            <input type="text" class="form-control"
                   name="usuario" placeholder="Usuario" required autofocus>
        </div>

        <div class="input-group">
            <span class="input-group-text">
                <i class="fas fa-lock"></i>
            </span>
            <input type="password" class="form-control"
                   name="password" id="password"
                   placeholder="Contraseña" required>
            <span class="input-group-text toggle-password" id="togglePassword">
                <i class="fas fa-eye"></i>
            </span>
        </div>

        <button type="submit" class="btn btn-login w-100">
            <i class="fas fa-heart"></i> Entrar
        </button>
    </form>
</div>

<div class="footer">
    © 2025 PetShop System
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.getElementById('togglePassword').addEventListener('click',function(){
    const p=document.getElementById('password');
    const i=this.querySelector('i');
    if(p.type==='password'){
        p.type='text';
        i.classList.replace('fa-eye','fa-eye-slash');
    }else{
        p.type='password';
        i.classList.replace('fa-eye-slash','fa-eye');
    }
});
</script>

</body>
</html>
