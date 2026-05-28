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
public class VendaBuilder {
    private int id;
    private String nomeTenis;
    private String dataVenda;
    private String formaPagamento;
    private List<ItemVenda> itens;
    private String opcionais;
    private double valorFinal;

    public VendaBuilder() {
        this.itens = new ArrayList<>();
        this.opcionais = "";
        this.valorFinal = 0.0;
    }

    public VendaBuilder comId(int id) {
        this.id = id;
        return this;
    }

    public VendaBuilder comNomeTenis(String nomeTenis) {
        this.nomeTenis = nomeTenis;
        return this;
    }

    public VendaBuilder comDataVenda(String dataVendaStr) {
        this.dataVenda = dataVendaStr;
        return this;
    }

    public VendaBuilder comFormaPagamento(String formaPagamento) {
        this.formaPagamento = formaPagamento;
        return this;
    }

    public VendaBuilder comOpcionais(String opcionais) {
        this.opcionais = opcionais;
        return this;
    }

    public VendaBuilder comItens(List<ItemVenda> itens) {
        this.itens = itens;
        return this;
    }

    public VendaBuilder comValorFinal(double valorFinal) {
        this.valorFinal = valorFinal;
        return this;
    }

    public Venda constroi() {
        return new Venda(id, nomeTenis, dataVenda, formaPagamento, opcionais, valorFinal, itens);
    }
}
