package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbconexion.Conexion;

@WebServlet("/ControladorEditar")
public class ControladorEditar extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ControladorEditar() {
        super();
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

            stmt.executeUpdate("UPDATE usuarios SET usuario = '" + usuario + "', password = '" + password + "' WHERE id = " + id);

            response.sendRedirect("index.jsp?edicionExitosa=true");

            valor.cerrarConexion();
        } catch (Exception e) {
            out.print(e + "");
        }
    }
}
