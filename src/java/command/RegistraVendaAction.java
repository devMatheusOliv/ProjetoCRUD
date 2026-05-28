/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package command;

import DAO.ProdutoDAO;
import DAO.VendaDAO;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ItemVenda;
import model.Produto;
import model.TipoPagamento;
import model.Venda;
import model.VendaBuilder;

/**
 *
 * @author mathe
 */
public class RegistraVendaAction implements ICommand {

    @Override
    public String executar(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String mensagem = "";
        VendaDAO vendaDAO = new VendaDAO();
        ProdutoDAO produtoDAO = new ProdutoDAO();
        try {
            String nomeTenis = request.getParameter("txtnometenis");
            String dataVenda = request.getParameter("txtdatavenda");
            String formaPagamento = request.getParameter("txtformapagamento");

            List<ItemVenda> itens = obterItensVenda(request, produtoDAO);
            int quantidadeTotal = calcularQuantidadeTotal(request);
            double precoUnitarioBase = obterPrecoUnitarioBase(request);

            decorator.Calcado pedido = decorarPedido(request, nomeTenis, quantidadeTotal, precoUnitarioBase);
            double valorFinal = pedido.Preco();
            String descricaoPedido = pedido.getDescricao();

            request.setAttribute("pedidoValorFinal", String.format("%.2f", valorFinal));
            request.setAttribute("pedidoDescricao", descricaoPedido);

            TipoPagamento pagamento = obterTipoPagamento(formaPagamento);
            
            String infoPagamento = "";
            if (pagamento.estaDisponivel()) {
                infoPagamento = pagamento.getDescricao();
            }
            request.setAttribute("infoPagamento", infoPagamento);

            String opcionaisTexto = obterOpcionaisTexto(request, quantidadeTotal);

            Venda venda = new VendaBuilder()
                    .comNomeTenis(nomeTenis)
                    .comDataVenda(dataVenda)
                    .comFormaPagamento(formaPagamento)
                    .comOpcionais(opcionaisTexto)
                    .comItens(itens)
                    .comValorFinal(valorFinal)
                    .constroi();

            vendaDAO.registrar(venda);
            request.setAttribute("venda", venda);
            mensagem = "Venda registrada com sucesso! ID: " + venda.getId();
            request.setAttribute("msg", mensagem);
            return "resultadoVenda.jsp";
        } catch (ClassNotFoundException | SQLException | NumberFormatException ex) {
            mensagem = "Erro ao registrar venda: " + ex.getMessage();
            request.setAttribute("msg", mensagem);
            return "resultadoVenda.jsp";
        }
    }

    private List<ItemVenda> obterItensVenda(HttpServletRequest request, ProdutoDAO produtoDAO) throws Exception {
        String[] idsProduto = request.getParameterValues("txtidproduto");
        String[] quantidades = request.getParameterValues("txtquantidade");
        String[] precos = request.getParameterValues("txtprecounitario");

        if (idsProduto == null || idsProduto.length == 0) {
            throw new Exception("Nenhum item informado para a venda.");
        }

        List<ItemVenda> itens = new ArrayList<>();
        for (int i = 0; i < idsProduto.length; i++) {
            int id = Integer.parseInt(idsProduto[i]);
            int qtd = Integer.parseInt(quantidades[i]);
            double preco = Double.parseDouble(precos[i]);
            String nome = obterNomeProduto(produtoDAO, id);

            ItemVenda item = new model.ItemVendaBuilder()
                    .comIdProduto(id)
                    .comQuantidade(qtd)
                    .comPrecoUnitario(preco)
                    .comNomeProduto(nome)
                    .constroi();
            itens.add(item);
        }
        return itens;
    }

    private String obterNomeProduto(ProdutoDAO produtoDAO, int idProduto) throws Exception {
        Produto busca = new model.ProdutoBuilder().comId(idProduto).constroi();
        Produto produto = produtoDAO.consultarById(busca);
        if (produto.getId() == 0) {
            return "Produto " + idProduto;
        }
        return produto.getDescricao();
    }

    private int calcularQuantidadeTotal(HttpServletRequest request) {
        String[] quantidades = request.getParameterValues("txtquantidade");
        int total = 0;
        if (quantidades == null) {
            return 0;
        }
        for (String qtd : quantidades) {
            total += Integer.parseInt(qtd);
        }
        return total;
    }

    private double obterPrecoUnitarioBase(HttpServletRequest request) {
        String[] precos = request.getParameterValues("txtprecounitario");
        if (precos == null || precos.length == 0) {
            return 0.0;
        }
        return Double.parseDouble(precos[precos.length - 1]);
    }

    private decorator.Calcado decorarPedido(HttpServletRequest request, String nomeTenis, int quantidadeTotal, double precoUnitarioBase) {
        decorator.Calcado pedido = new decorator.Tenis(nomeTenis, precoUnitarioBase * quantidadeTotal);
        if (aplicarDesconto(request, quantidadeTotal)) {
            pedido = new decorator.Desconto(pedido);
        }
        if ("on".equals(request.getParameter("opcionalMeia"))) {
            pedido = new decorator.Meia(pedido);
        }
        if ("on".equals(request.getParameter("opcionalEmbalagem"))) {
            pedido = new decorator.EmbalagemPresente(pedido);
        }
        return pedido;
    }

    private boolean aplicarDesconto(HttpServletRequest request, int quantidadeTotal) {
        if ("on".equals(request.getParameter("desconto2pares"))) {
            return true;
        }
        return quantidadeTotal >= 2;
    }

    private String obterOpcionaisTexto(HttpServletRequest request, int quantidadeTotal) {
        List<String> opcoes = new ArrayList<>();
        if (aplicarDesconto(request, quantidadeTotal)) {
            opcoes.add("Desconto 10%");
        }
        if ("on".equals(request.getParameter("opcionalMeia"))) {
            opcoes.add("Meia");
        }
        if ("on".equals(request.getParameter("opcionalEmbalagem"))) {
            opcoes.add("Embalagem");
        }
        if (opcoes.isEmpty()) {
            return "Nenhum";
        }
        return String.join(", ", opcoes);
    }

    private model.TipoPagamento obterTipoPagamento(String formaPagamento) {
        if ("pix".equalsIgnoreCase(formaPagamento)) {
            return new model.PagamentoPix();
        }
        return new model.PagamentoCartao();
    }
}
