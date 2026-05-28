/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mathe
 */
public class Venda {

    private int id;
    private String nomeTenis;
    private String dataVenda;
    private String formaPagamento;
    private String opcionais;
    private double valorFinal;
    private List<ItemVenda> itens;

    public Venda() {
        this.itens = new ArrayList<>();
    }

    public Venda(int id, String nomeTenis, String dataVenda) {
        this.id = id;
        this.nomeTenis = nomeTenis;
        this.dataVenda = dataVenda;
        this.formaPagamento = "";
        this.opcionais = "";
        this.valorFinal = 0.0;
        this.itens = new ArrayList<>();
    }

    public Venda(int id, String nomeTenis, String dataVenda, String formaPagamento,
                 String opcionais, double valorFinal, List<ItemVenda> itens) {
        this.id = id;
        this.nomeTenis = nomeTenis;
        this.dataVenda = dataVenda;
        this.formaPagamento = formaPagamento;
        this.opcionais = opcionais;
        this.valorFinal = valorFinal;
        this.itens = itens != null ? itens : new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomeTenis() {
        return nomeTenis;
    }

    public void setNomeTenis(String nomeTenis) {
        this.nomeTenis = nomeTenis;
    }

    public String getDataVenda() {
        return dataVenda;
    }

    public void setDataVenda(String dataVenda) {
        this.dataVenda = dataVenda;
    }

    public String getFormaPagamento() {
        return formaPagamento;
    }

    public void setFormaPagamento(String formaPagamento) {
        this.formaPagamento = formaPagamento;
    }

    public String getOpcionais() {
        return opcionais;
    }

    public void setOpcionais(String opcionais) {
        this.opcionais = opcionais;
    }

    public double getValorFinal() {
        return valorFinal;
    }

    public void setValorFinal(double valorFinal) {
        this.valorFinal = valorFinal;
    }

    public List<ItemVenda> getItens() {
        return itens;
    }

    public void setItens(List<ItemVenda> itens) {
        this.itens = itens;
    }

    public void addItem(ItemVenda item) {
        this.itens.add(item);
    }

    public double getTotal() {
        double total = 0.0;
        for (ItemVenda item : itens) {
            total += item.getSubtotal();
        }
        return total;
    }

    public String getDataVendaFormatada() {
        if (dataVenda != null && dataVenda.length() >= 10 && dataVenda.contains("-")) {
            String[] partes = dataVenda.split("-");
            if (partes.length == 3) {
                return partes[2] + "/" + partes[1] + "/" + partes[0];
            }
        }
        return dataVenda;
    }

    public String getInfoPagamento(TipoPagamento pagamento) {
        if (pagamento.estaDisponivel()) {
            return pagamento.getDescricao();
        }
        return "";
    }
}
