<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet" %>
<%@ page import="dbconexion.Conexion" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Usuarios</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <style>
        /* Personalización de los elementos */
        #formContainer {
            border: 2px solid #6c757d; /* Borde color secondary */
            border-radius: 5px;
            padding: 20px;
        }

        #tablaUsuarios {
            border: 2px solid #6c757d; /* Borde color secondary */
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">REGISTRO DE USUARIOS</h1>
        <br>
        <br>
        <div class="row">
            <div class="col-md-6">
                <div id="formContainer">
                    <form id="usuarioForm" action="ControlUsuario" method="post">
                        <div class="form-group">
                            <label for="id">ID</label>
                            <input type="text" class="form-control" id="id" name="id" value="0" >
                        </div>
                        <div class="form-group">
                            <label for="usuario">Usuario</label>
                            <input type="text" class="form-control" id="usuario" name="usuario" required placeholder="Ingrese su Usuario">
                        </div>
                        <div class="form-group">
                            <label for="password">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="password" required placeholder="Ingrese su Contraseña">
                        </div>
                        <div class="btn-group">
                            <button type="submit" class="btn btn-secondary">Registrar</button>
                        </div>
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-secondary" id="editarUsuario">Editar</button>
                        </div>
                        <div class="btn-group">
                            <button type="button" class="btn btn-danger" id="eliminarUsuario">Eliminar</button>
                        </div>
                        <div class="btn-group">
                            <button type="button" class="btn btn-dark" id="nuevoUsuario">Nuevo</button>
                        </div>
                         <div class="btn-group">
                            <button type="button" class="btn btn-dark" id="BuscarUsuario">Buscar</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-md-6">
                <table id="tablaUsuarios" class="table table-dark table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Usuario</th>
                            <th>Contraseña</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Los resultados de la búsqueda se cargarán aquí -->
                        <%
                            try {
                                // Código para obtener y mostrar los usuarios registrados
                                Conexion valor = new Conexion();
                                Connection con = valor.getConexion();
                                Statement stmt = con.createStatement();
                                ResultSet rs = stmt.executeQuery("select * from usuarios");
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("usuario") %></td>
                            <td><%= rs.getString("password") %></td>
                        </tr>
                        <%
                                }
                                valor.cerrarConexion();
                            } catch (Exception e) {
                                out.print(e + "");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

<!-- Bootstrap JS y jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- SweetAlert2 JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    $(document).ready(function() {
        $('#tablaUsuarios tr').click(function() {
            var id = $(this).find('td:eq(0)').text();
            var usuario = $(this).find('td:eq(1)').text();
            var password = $(this).find('td:eq(2)').text();
            
            $('#id').val(id);
            $('#usuario').val(usuario);
            $('#password').val(password);
        });

        $('#editarUsuario').click(function() {
            $('#usuarioForm').attr('action', 'ControladorEditar');
            $('#usuarioForm').submit();
        });

        $('#eliminarUsuario').click(function() {
            // Mostrar un Sweet Alert de confirmación antes de eliminar
            Swal.fire({
                title: '¿Estás seguro?',
                text: 'Esta acción eliminará el usuario seleccionado.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Sí, eliminarlo',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    $('#usuarioForm').attr('action', 'ControladorEliminar');
                    $('#usuarioForm').submit();
                }
            });
        });

        // Buscar usuario
        $('#BuscarUsuario').click(function() {
            var tipoBusqueda = $('#tipoBusqueda').val();
            var parametro = $('#parametro').val();
            
            $.post('ControladorBuscar', { tipoBusqueda: tipoBusqueda, parametro: parametro }, function(response) {
                $('#tablaUsuarios tbody').html(response);
            });
        });
      
        // Verificar si el registro fue exitoso solo una vez
        var urlParams = new URLSearchParams(window.location.search);
        var registroExitoso = urlParams.get("registroExitoso");
        if (registroExitoso === "true") {
            Swal.fire(
                '¡Registro exitoso!',
                'El usuario se ha registrado correctamente.',
                'success'
            );
            // Eliminar el parámetro registroExitoso de la URL
            var newUrl = window.location.href.split('?')[0];
            window.history.replaceState({}, document.title, newUrl);
        }

        // Verificar si la edición fue exitosa
        var edicionExitosa = urlParams.get("edicionExitosa");
        if (edicionExitosa === "true") {
            Swal.fire(
                '¡Edición exitosa!',
                'El usuario se ha editado correctamente.',
                'success'
            ).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'index.jsp';
                }
            });
            // Eliminar el parámetro edicionExitosa de la URL
            var newUrl = window.location.href.split('?')[0];
            window.history.replaceState({}, document.title, newUrl);
        }
    });
</script>
</body>
</html>
