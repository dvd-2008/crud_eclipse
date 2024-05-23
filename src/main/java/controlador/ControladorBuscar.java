package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbconexion.Conexion;

@WebServlet("/ControladorBuscar")
public class ControladorBuscar extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Obtener el tipo de búsqueda y el parámetro de búsqueda
        String tipoBusqueda = request.getParameter("tipoBusqueda");
        String parametro = request.getParameter("parametro");

        try {
            // Establecer conexión con la base de datos
            Conexion valor = new Conexion();
            Connection con = valor.getConexion();
            Statement stmt = con.createStatement();

            // Realizar la búsqueda según el tipo especificado
            String query = "";
            if (tipoBusqueda.equals("id")) {
                // Búsqueda por ID
                query = "SELECT * FROM usuarios WHERE id = " + parametro;
            } else if (tipoBusqueda.equals("nombre")) {
                // Búsqueda por nombre de usuario
                query = "SELECT * FROM usuarios WHERE usuario LIKE '%" + parametro + "%'";
            }

            // Ejecutar la consulta
            ResultSet rs = stmt.executeQuery(query);

            // Construir el HTML de la tabla con los resultados de la búsqueda
            StringBuilder tableHTML = new StringBuilder();
            tableHTML.append("<table class=\"table table-dark table-striped\">");
            tableHTML.append("<thead>");
            tableHTML.append("<tr>");
            tableHTML.append("<th>ID</th>");
            tableHTML.append("<th>Usuario</th>");
            tableHTML.append("<th>Contraseña</th>");
            tableHTML.append("</tr>");
            tableHTML.append("</thead>");
            tableHTML.append("<tbody>");
            while (rs.next()) {
                tableHTML.append("<tr>");
                tableHTML.append("<td>").append(rs.getInt("id")).append("</td>");
                tableHTML.append("<td>").append(rs.getString("usuario")).append("</td>");
                tableHTML.append("<td>").append(rs.getString("password")).append("</td>");
                tableHTML.append("</tr>");
            }
            tableHTML.append("</tbody>");
            tableHTML.append("</table>");

            // Escribir el HTML de la tabla en la respuesta
            out.println(tableHTML.toString());

            // Cerrar la conexión
            valor.cerrarConexion();
        } catch (SQLException e) {
            // Manejo de excepciones
            e.printStackTrace();
            response.sendRedirect("index.jsp?busquedaError=true");
        }
    }
}
