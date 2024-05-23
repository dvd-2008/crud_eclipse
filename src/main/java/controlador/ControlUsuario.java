package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbconexion.Conexion;

@WebServlet("/ControlUsuario")
public class ControlUsuario extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String REGISTRO_EXITOSO = "registroExitoso";

    public ControlUsuario() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        int id = Integer.parseInt(request.getParameter("id"));
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        try {
            Conexion valor = new Conexion();
            Connection con = valor.getConexion();
            Statement stmt = con.createStatement();

            if (id == 0) {
                // Si el ID es 0, es un nuevo registro
                stmt.executeUpdate(
                        "INSERT INTO usuarios (usuario, password) VALUES ('" + usuario + "','" + password + "')");
                request.setAttribute(REGISTRO_EXITOSO, true);
            } else {
                // Si el ID no es 0, es una actualización
                stmt.executeUpdate("UPDATE usuarios SET usuario = '" + usuario + "', password = '" + password + "' WHERE id = " + id);
            }

            // Redireccionar a index.jsp con el parámetro REGISTRO_EXITOSO
            request.setAttribute(REGISTRO_EXITOSO, true);
            response.sendRedirect("index.jsp?" + REGISTRO_EXITOSO + "=true");

            valor.cerrarConexion();
        } catch (Exception e) {
            out.print(e + "");
        }
    }
}
