<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #6c757d; /* Fondo secundario */
            color: #ffffff; /* Texto blanco */
        }

        .login-container {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            background-color: #343a40; /* Fondo oscuro */
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.75); /* Sombra */
            margin-top: 100px;
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-container form input[type="text"],
        .login-container form input[type="password"] {
            background-color: #454d55; /* Fondo gris oscuro */
            border: none;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 20px;
            color: #ffffff; /* Texto blanco */
        }

        .login-container form button[type="submit"] {
            background-color: #007bff; /* Botón azul */
            color: #ffffff; /* Texto blanco */
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
        }

        .login-container form button[type="submit"]:hover {
            background-color: #0056b3; /* Botón azul más oscuro al pasar el cursor */
        }
    </style>
</head>
<body>

<div class="container">
    <div class="login-container">
        <h2>Iniciar Sesión</h2>
        <form id="loginForm" method="post">
            <div class="form-group">
                <input type="text" class="form-control" id="username" name="username" placeholder="Usuario" required>
            </div>
            <div class="form-group">
                <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Ingresar</button>
        </form>
    </div>
</div>

<!-- Bootstrap JS y jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- jQuery Post JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- SweetAlert2 JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
$(document).ready(function() {
    $('#loginForm').submit(function(e) {
        e.preventDefault(); // Evitar el envío del formulario por defecto

        // Obtener los datos del formulario
        var usuario = $('#username').val();
        var password = $('#password').val();

        // Enviar los datos al servlet
        $.post('ControladorLogin', { username: usuario, password: password }, function(response) {
            if (response.trim() === "success") {
                // Mostrar Sweet Alert de bienvenida
                Swal.fire({
                    title: '¡Bienvenido!',
                    text: 'Has ingresado al sistema correctamente.',
                    icon: 'success'
                }).then((result) => {
                    // Redireccionar al usuario a la página de inicio
                    window.location.href = 'index.jsp';
                });
            } else {
                // Mostrar Sweet Alert de error
                Swal.fire({
                    title: 'Error',
                    text: 'Usuario y/o contraseña incorrectos.',
                    icon: 'error'
                });
            }
        });
    });
});
</script>

</body>
</html>
