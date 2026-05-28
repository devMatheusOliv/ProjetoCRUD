/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package command;

import DAO.ProdutoDAO;
import DAO.VendaDAO;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Produto;

/**
 *
 * @author mathe
 */
public class ConsultaEstoqueAction implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        VendaDAO vendaDAO = new VendaDAO();
        ProdutoDAO produtoDAO = new ProdutoDAO();
        try {
            int idProduto = Integer.parseInt(request.getParameter("txtidprodutoestoque"));
            int estoque = vendaDAO.consultarEstoque(idProduto);
            Produto busca = new model.ProdutoBuilder()
                    .comId(idProduto)
                    .constroi();
            Produto produto = produtoDAO.consultarById(busca);

            request.setAttribute("estoqueDisponivel", estoque);
            request.setAttribute("idProdutoConsultado", idProduto);
            
            String descricaoProduto = "Desconhecido";
            if (produto != null && produto.getId() != 0) {
                descricaoProduto = produto.getDescricao();
            }
            request.setAttribute("descricaoProduto", descricaoProduto);

            return "resultadoEstoque.jsp";
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            request.setAttribute("msg", "Erro ao consultar estoque: " + ex.getMessage());
            return "resultadoVenda.jsp";
        }
    }
}
