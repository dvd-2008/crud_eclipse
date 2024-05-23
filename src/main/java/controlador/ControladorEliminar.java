package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbconexion.Conexion;

@WebServlet("/ControladorEliminar")
public class ControladorEliminar extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Obtener el ID del usuario a eliminar
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            // Establecer conexión con la base de datos
            Conexion valor = new Conexion();
            Connection con = valor.getConexion();
            Statement stmt = con.createStatement();

            // Ejecutar la consulta para eliminar el usuario por su ID
            stmt.executeUpdate("DELETE FROM usuarios WHERE id = " + id);

            // Cerrar la conexión
            valor.cerrarConexion();

            // Redireccionar a index.jsp con un parámetro indicando que la eliminación fue exitosa
            response.sendRedirect("index.jsp?eliminacionExitosa=true");
        } catch (SQLException e) {
            // Manejo de excepciones
            e.printStackTrace();
            response.sendRedirect("index.jsp?eliminacionExitosa=false");
        }
    }
}
