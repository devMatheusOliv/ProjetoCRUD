/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author mathe
 */
public class ProdutoBuilder {
    private int id;
    private String descricao;
    private double preco;
    private String fornecedor;
    private int quantidadeEstoque;
    private String cor;
    private String marca;
    private String tamanho;
    private String material;
    private double avaliacao;

    public ProdutoBuilder comId(int id) {
        this.id = id;
        return this;
    }

    public ProdutoBuilder comDescricao(String descricao) {
        this.descricao = descricao;
        return this;
    }

    public ProdutoBuilder comPreco(double preco) {
        this.preco = preco;
        return this;
    }

    public ProdutoBuilder comFornecedor(String fornecedor) {
        this.fornecedor = fornecedor;
        return this;
    }

    public ProdutoBuilder comQuantidadeEstoque(int quantidadeEstoque) {
        this.quantidadeEstoque = quantidadeEstoque;
        return this;
    }

    public ProdutoBuilder comCor(String cor) {
        this.cor = cor;
        return this;
    }

    public ProdutoBuilder comMarca(String marca) {
        this.marca = marca;
        return this;
    }

    public ProdutoBuilder comTamanho(String tamanho) {
        this.tamanho = tamanho;
        return this;
    }

    public ProdutoBuilder comMaterial(String material) {
        this.material = material;
        return this;
    }

    public ProdutoBuilder comAvaliacao(double avaliacao) {
        this.avaliacao = avaliacao;
        return this;
    }

    public Produto constroi() {
        return new Produto(id, descricao, preco, fornecedor, quantidadeEstoque, cor, marca, tamanho, material, avaliacao);
    }
}
