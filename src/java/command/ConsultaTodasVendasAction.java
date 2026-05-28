/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package command;

import DAO.VendaDAO;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Venda;

/**
 *
 * @author mathe
 */
public class ConsultaTodasVendasAction implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        VendaDAO vendaDAO = new VendaDAO();
        try {
            List<Venda> listaVendas = vendaDAO.consultarTodas();
            request.setAttribute("listaVendas", listaVendas);
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            System.out.println("ERRO: " + ex.getMessage());
        }
        return "resultadoConsultaTodasVendas.jsp";
    }
}
