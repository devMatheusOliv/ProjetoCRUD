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
public class CadastraProdutoAction implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String msg = "";
        ProdutoDAO produtoDAO = new ProdutoDAO();
        try {
            Produto produto = new model.ProdutoBuilder()
                    .comId(Integer.parseInt(request.getParameter("txtid")))
                    .comDescricao(request.getParameter("txtdescricao"))
                    .comPreco(Double.parseDouble(request.getParameter("txtpreco")))
                    .comFornecedor(request.getParameter("txtfornecedor"))
                    .comQuantidadeEstoque(Integer.parseInt(request.getParameter("txtQuantidadeEstoque")))
                    .comCor(request.getParameter("txtcor"))
                    .comMarca(request.getParameter("txtmarca"))
                    .comTamanho(request.getParameter("txttamanho"))
                    .comMaterial(request.getParameter("txtmaterial"))
                    .comAvaliacao(Double.parseDouble(request.getParameter("txtavaliacao")))
                    .constroi();
            produtoDAO.cadastrar(produto);
            msg = "Cadastrado com sucesso.";
            System.out.println("Cadastrado com sucesso.");
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            msg = "Erro ao cadastrar.";
        }
        request.setAttribute("msg", msg);
        return "resultadocadastrar.jsp";
    }
}
