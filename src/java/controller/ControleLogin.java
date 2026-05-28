package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ControleLogin", urlPatterns = {"/ControleLogin"})
public class ControleLogin extends HttpServlet {

    private static final String USUARIO_VALIDO = "admin";
    private static final String SENHA_VALIDA   = "admin";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String usuario = request.getParameter("txtUsuario");
        String senha   = request.getParameter("txtSenha");

        if (USUARIO_VALIDO.equals(usuario) && SENHA_VALIDA.equals(senha)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("usuarioLogado", usuario);
            session.setMaxInactiveInterval(30 * 60);
            response.sendRedirect("index.jsp");
        } else {
            response.sendRedirect("login.jsp?erro=1");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");
        if ("logout".equals(acao)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
        }
        response.sendRedirect("login.jsp");
    }
}
