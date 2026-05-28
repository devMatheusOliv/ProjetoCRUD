/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author mathe
 */
public class ItemVendaBuilder {
    private int idProduto;
    private int quantidade;
    private double precoUnitario;
    private String nomeProduto;

    public ItemVendaBuilder comIdProduto(int idProduto) {
        this.idProduto = idProduto;
        return this;
    }

    public ItemVendaBuilder comQuantidade(int quantidade) {
        this.quantidade = quantidade;
        return this;
    }

    public ItemVendaBuilder comPrecoUnitario(double precoUnitario) {
        this.precoUnitario = precoUnitario;
        return this;
    }

    public ItemVendaBuilder comNomeProduto(String nomeProduto) {
        this.nomeProduto = nomeProduto;
        return this;
    }

    public ItemVenda constroi() {
        return new ItemVenda(0, 0, idProduto, quantidade, precoUnitario, nomeProduto);
    }
}
