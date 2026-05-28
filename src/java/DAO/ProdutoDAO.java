package DAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Produto;
import model.ProdutoBuilder;
import util.FirebaseService;
import util.JsonUtil;

public class ProdutoDAO {

    private final FirebaseService firebaseService;

    public ProdutoDAO() {
        this.firebaseService = new FirebaseService();
    }

    public void cadastrar(Produto produto) throws ClassNotFoundException, SQLException {
        try {
            String json = produtoParaJson(produto);
            firebaseService.put("produtos/" + produto.getId(), json);
        } catch (Exception e) {
            throw new SQLException("Erro ao cadastrar no Firebase: " + e.getMessage(), e);
        }
    }

    public void deletar(Produto produto) throws ClassNotFoundException, SQLException {
        try {
            firebaseService.delete("produtos/" + produto.getId());
        } catch (Exception e) {
            throw new SQLException("Erro ao deletar no Firebase: " + e.getMessage(), e);
        }
    }

    public void atualizar(Produto produto) throws ClassNotFoundException, SQLException {
        try {
            String json = produtoParaJson(produto);
            firebaseService.put("produtos/" + produto.getId(), json);
        } catch (Exception e) {
            throw new SQLException("Erro ao atualizar no Firebase: " + e.getMessage(), e);
        }
    }

    public Produto consultarById(Produto busca) throws ClassNotFoundException, SQLException {
        try {
            String json = firebaseService.get("produtos/" + busca.getId());
            if (json == null || json.trim().equals("null") || json.trim().isEmpty()) {
                return new Produto();
            }
            return jsonParaProduto(json);
        } catch (Exception e) {
            throw new SQLException("Erro ao consultar no Firebase: " + e.getMessage(), e);
        }
    }

    public List<Produto> consultarTodos() throws ClassNotFoundException, SQLException {
        List<Produto> listaProdutos = new ArrayList<>();
        try {
            String jsonCompleto = firebaseService.get("produtos");
            if (jsonCompleto == null || jsonCompleto.trim().equals("null") || jsonCompleto.trim().isEmpty()) {
                return listaProdutos;
            }
            
            List<String> blocos = extrairObjetosJson(jsonCompleto, "\"descricao\"");
            for (String blocoJson : blocos) {
                listaProdutos.add(jsonParaProduto(blocoJson));
            }
        } catch (Exception e) {
            throw new SQLException("Erro ao listar produtos: " + e.getMessage(), e);
        }
        return listaProdutos;
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

    private String produtoParaJson(Produto produto) {
        return String.format(
            "{\"id\":%d,\"descricao\":\"%s\",\"preco\":%s,\"fornecedor\":\"%s\",\"quantidadeEstoque\":%d,\"cor\":\"%s\",\"marca\":\"%s\",\"tamanho\":\"%s\",\"material\":\"%s\",\"avaliacao\":%s}",
            produto.getId(),
            JsonUtil.escaparJson(produto.getDescricao()),
            String.valueOf(produto.getPreco()),
            JsonUtil.escaparJson(produto.getFornecedor()),
            produto.getQuantidadeEstoque(),
            JsonUtil.escaparJson(produto.getCor()),
            JsonUtil.escaparJson(produto.getMarca()),
            JsonUtil.escaparJson(produto.getTamanho()),
            JsonUtil.escaparJson(produto.getMaterial()),
            String.valueOf(produto.getAvaliacao())
        );
    }

    private Produto jsonParaProduto(String json) {
        int id = JsonUtil.extrairCampoInt(json, "id");
        String descricao = JsonUtil.extrairCampoString(json, "descricao");
        double preco = JsonUtil.extrairCampoDouble(json, "preco");
        String fornecedor = JsonUtil.extrairCampoString(json, "fornecedor");
        int quantidadeEstoque = JsonUtil.extrairCampoInt(json, "quantidadeEstoque");
        String cor = JsonUtil.extrairCampoString(json, "cor");
        String marca = JsonUtil.extrairCampoString(json, "marca");
        String tamanho = JsonUtil.extrairCampoString(json, "tamanho");
        String material = JsonUtil.extrairCampoString(json, "material");
        double avaliacao = JsonUtil.extrairCampoDouble(json, "avaliacao");

        return new ProdutoBuilder()
                .comId(id)
                .comDescricao(descricao)
                .comPreco(preco)
                .comFornecedor(fornecedor)
                .comQuantidadeEstoque(quantidadeEstoque)
                .comCor(cor)
                .comMarca(marca)
                .comTamanho(tamanho)
                .comMaterial(material)
                .comAvaliacao(avaliacao)
                .constroi();
    }
}