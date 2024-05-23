package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbconexion.Conexion;

@WebServlet("/ControladorLogin")
public class ControladorLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        // Obtener los datos del formulario
        String usuario = request.getParameter("username");
        String password = request.getParameter("password");

        // Consultar la base de datos para verificar las credenciales
        try {
            Conexion valor = new Conexion();
            Connection con = valor.getConexion();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM usuarios WHERE usuario=? AND password=?");
            ps.setString(1, usuario);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Las credenciales son válidas, enviar respuesta de éxito al cliente
                out.write("success");
            } else {
                // Las credenciales son inválidas, enviar respuesta de error al cliente
                out.write("error");
            }

            valor.cerrarConexion();
        } catch (Exception e) {
            out.print(e);
        }
    }
}
