package DAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ItemVenda;
import model.Produto;
import model.ProdutoBuilder;
import model.Venda;
import model.VendaBuilder;
import util.FirebaseService;
import util.JsonUtil;

public class VendaDAO {

    private final FirebaseService firebaseService;
    private final ProdutoDAO produtoDAO;

    public VendaDAO() {
        this.firebaseService = new FirebaseService();
        this.produtoDAO = new ProdutoDAO();
    }

    public void registrar(Venda venda) throws ClassNotFoundException, SQLException {
        try {
            int proximoId = obterProximoIdVenda();
            venda.setId(proximoId);
            String json = vendaParaJson(venda);
            firebaseService.put("vendas/" + venda.getId(), json);
        } catch (Exception e) {
            throw new SQLException("Erro ao registrar venda: " + e.getMessage(), e);
        }
    }

    private void atualizarEstoqueProduto(ItemVenda item) throws Exception {
        Produto busca = new ProdutoBuilder().comId(item.getIdProduto()).constroi();
        Produto produto = produtoDAO.consultarById(busca);
        if (produto.getId() != 0) {
            int novoEstoque = produto.getQuantidadeEstoque() - item.getQuantidade();
            Produto produtoAtualizado = new ProdutoBuilder()
                    .comId(produto.getId())
                    .comDescricao(produto.getDescricao())
                    .comPreco(produto.getPreco())
                    .comFornecedor(produto.getFornecedor())
                    .comQuantidadeEstoque(novoEstoque)
                    .comCor(produto.getCor())
                    .comMarca(produto.getMarca())
                    .comTamanho(produto.getTamanho())
                    .comMaterial(produto.getMaterial())
                    .comAvaliacao(produto.getAvaliacao())
                    .constroi();
            produtoDAO.atualizar(produtoAtualizado);
        }
    }

    public Venda consultarById(Venda busca) throws ClassNotFoundException, SQLException {
        try {
            String json = firebaseService.get("vendas/" + busca.getId());
            if (json == null || json.trim().equals("null") || json.trim().isEmpty()) {
                return null;
            }
            return jsonParaVenda(json);
        } catch (Exception e) {
            throw new SQLException("Erro ao consultar venda: " + e.getMessage(), e);
        }
    }

    public List<Venda> consultarTodas() throws ClassNotFoundException, SQLException {
        List<Venda> listaVendas = new ArrayList<>();
        try {
            String jsonCompleto = firebaseService.get("vendas");
            if (jsonCompleto == null || jsonCompleto.trim().equals("null") || jsonCompleto.trim().isEmpty()) {
                return listaVendas;
            }

            List<String> blocos = extrairObjetosJson(jsonCompleto, "\"nomeTenis\"");
            for (String blocoJson : blocos) {
                try {
                    Venda v = jsonParaVenda(blocoJson);
                    if (v != null) {
                        listaVendas.add(v);
                    }
                } catch (Exception ex) {
                    System.out.println("Erro ao parsear venda: " + ex.getMessage());
                }
            }

            listaVendas.sort((v1, v2) -> Integer.compare(v2.getId(), v1.getId()));
        } catch (Exception e) {
            throw new SQLException("Erro ao listar vendas: " + e.getMessage(), e);
        }
        return listaVendas;
    }

    private List<String> extrairObjetosJson(String jsonCompleto, String campoFiltro) {
        List<String> list = new ArrayList<>();
        String json = jsonCompleto.trim();
        int profundidadeAlvo = json.startsWith("[") ? 1 : 2;
        int profundidade = 0;
        int inicio = -1;
        
        for (int i = 0; i < json.length(); i++) {
            char c = json.charAt(i);
            if (c == '{') {
                profundidade++;
                if (profundidade == profundidadeAlvo) {
                    inicio = i;
                }
            } else if (c == '}') {
                if (profundidade == profundidadeAlvo && inicio >= 0) {
                    String bloco = json.substring(inicio, i + 1);
                    if (bloco.contains(campoFiltro)) {
                        list.add(bloco);
                    }
                    inicio = -1;
                }
                profundidade--;
            }
        }
        return list;
    }

    public int consultarEstoque(int idProduto) throws ClassNotFoundException, SQLException {
        try {
            Produto busca = new ProdutoBuilder().comId(idProduto).constroi();
            Produto produto = produtoDAO.consultarById(busca);
            return produto.getQuantidadeEstoque();
        } catch (Exception e) {
            throw new SQLException("Erro ao consultar estoque: " + e.getMessage(), e);
        }
    }

    private int obterProximoIdVenda() throws Exception {
        List<Venda> vendas = consultarTodas();
        int maxId = 0;
        for (Venda v : vendas) {
            if (v.getId() > maxId) {
                maxId = v.getId();
            }
        }
        return maxId + 1;
    }

    private String vendaParaJson(Venda venda) {
        StringBuilder itensJson = new StringBuilder();
        itensJson.append("[");
        List<ItemVenda> itens = venda.getItens();
        if (itens != null) {
            for (int i = 0; i < itens.size(); i++) {
                itensJson.append(itemVendaParaJson(itens.get(i)));
                if (i < itens.size() - 1) {
                    itensJson.append(",");
                }
            }
        }
        itensJson.append("]");

        return String.format(
            "{\"id\":%d,\"nomeTenis\":\"%s\",\"dataVenda\":\"%s\",\"formaPagamento\":\"%s\",\"opcionais\":\"%s\",\"valorFinal\":%s,\"itens\":%s}",
            venda.getId(),
            JsonUtil.escaparJson(venda.getNomeTenis()),
            venda.getDataVenda(),
            JsonUtil.escaparJson(venda.getFormaPagamento()),
            JsonUtil.escaparJson(venda.getOpcionais()),
            String.valueOf(venda.getValorFinal()),
            itensJson.toString()
        );
    }

    private String itemVendaParaJson(ItemVenda item) {
        return String.format(
            "{\"id\":%d,\"idVenda\":%d,\"idProduto\":%d,\"quantidade\":%d,\"precoUnitario\":%s,\"nomeProduto\":\"%s\"}",
            item.getId(),
            item.getIdVenda(),
            item.getIdProduto(),
            item.getQuantidade(),
            String.valueOf(item.getPrecoUnitario()),
            JsonUtil.escaparJson(item.getNomeProduto())
        );
    }

    private Venda jsonParaVenda(String json) {
        int id = JsonUtil.extrairCampoInt(json, "id");
        String nomeTenis = JsonUtil.extrairCampoString(json, "nomeTenis");
        String dataVenda = JsonUtil.extrairCampoString(json, "dataVenda");
        String formaPagamento = JsonUtil.extrairCampoString(json, "formaPagamento");
        String opcionais = JsonUtil.extrairCampoString(json, "opcionais");
        double valorFinal = JsonUtil.extrairCampoDouble(json, "valorFinal");

        List<ItemVenda> itens = new ArrayList<>();
        int indexItens = json.indexOf("\"itens\"");
        if (indexItens != -1) {
            int inicioArray = json.indexOf("[", indexItens);
            int fimArray = json.indexOf("]", indexItens);
            if (inicioArray != -1 && fimArray != -1 && fimArray > inicioArray) {
                String arrayItens = json.substring(inicioArray, fimArray + 1);
                List<String> blocosItens = extrairObjetosJson(arrayItens, "\"idProduto\"");
                for (String blocoItem : blocosItens) {
                    itens.add(jsonParaItemVenda(blocoItem));
                }
            }
        }

        return new VendaBuilder()
                .comId(id)
                .comNomeTenis(nomeTenis)
                .comDataVenda(dataVenda)
                .comFormaPagamento(formaPagamento)
                .comOpcionais(opcionais)
                .comValorFinal(valorFinal)
                .comItens(itens)
                .constroi();
    }

    private ItemVenda jsonParaItemVenda(String json) {
        int id = JsonUtil.extrairCampoInt(json, "id");
        int idVenda = JsonUtil.extrairCampoInt(json, "idVenda");
        int idProduto = JsonUtil.extrairCampoInt(json, "idProduto");
        int quantidade = JsonUtil.extrairCampoInt(json, "quantidade");
        double precoUnitario = JsonUtil.extrairCampoDouble(json, "precoUnitario");
        String nomeProduto = JsonUtil.extrairCampoString(json, "nomeProduto");

        return new ItemVenda(id, idVenda, idProduto, quantidade, precoUnitario, nomeProduto);
    }
}
