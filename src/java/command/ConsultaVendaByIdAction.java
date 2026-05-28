/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package command;

import DAO.VendaDAO;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Venda;

/**
 *
 * @author mathe
 */
public class ConsultaVendaByIdAction implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        VendaDAO vendaDAO = new VendaDAO();
        try {
            int id = Integer.parseInt(request.getParameter("txtidvenda"));
            Venda vendaBusca = new model.VendaBuilder()
                    .comId(id)
                    .constroi();
            Venda venda = vendaDAO.consultarById(vendaBusca);
            
            if (venda == null) {
                request.setAttribute("msg", "Venda nao encontrada para o ID: " + id);
                return "resultadoVenda.jsp";
            }
            
            request.setAttribute("venda", venda);
            return "resultadoConsultaVendaId.jsp";
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            request.setAttribute("msg", "Erro ao consultar venda: " + ex.getMessage());
            return "resultadoVenda.jsp";
        }
    }
}
