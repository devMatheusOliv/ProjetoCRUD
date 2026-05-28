/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package command;

import DAO.ProdutoDAO;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Produto;

/**
 *
 * @author mathe
 */
public class ConsultaByIdProdutoAction implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
        ProdutoDAO produtoDAO = new ProdutoDAO();
        try {
            int id = Integer.parseInt(request.getParameter("txtid"));
            Produto busca = new model.ProdutoBuilder()
                    .comId(id)
                    .constroi();
            Produto produto = produtoDAO.consultarById(busca);
            request.setAttribute("produto", produto);
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            msg = "Erro ao consultar";
            request.setAttribute("msg", msg);
        }
        return "resultadoConsultaId.jsp";
    }
}
