/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package command;

import DAO.ProdutoDAO;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Produto;

/**
 *
 * @author mathe
 */
public class ConsultaTodosProdutoAction implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ProdutoDAO produtoDAO = new ProdutoDAO();
        try {
            List<Produto> listaProdutos = produtoDAO.consultarTodos();
            request.setAttribute("listaProdutos", listaProdutos);
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
        return "resultadoConsultaTodos.jsp";
    }
}
