/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author mathe
 */
public class Produto {

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

    public Produto() {
    }

    public Produto(int id, String descricao, double preco, String fornecedor,
                   int quantidadeEstoque, String cor, String marca,
                   String tamanho, String material, double avaliacao) {
        this.id = id;
        this.descricao = descricao;
        this.preco = preco;
        this.fornecedor = fornecedor;
        this.quantidadeEstoque = quantidadeEstoque;
        this.cor = cor;
        this.marca = marca;
        this.tamanho = tamanho;
        this.material = material;
        this.avaliacao = avaliacao;
    }

    public int getId() {
        return id;
    }

    public String getDescricao() {
        return descricao;
    }

    public double getPreco() {
        return preco;
    }

    public String getFornecedor() {
        return fornecedor;
    }

    public int getQuantidadeEstoque() {
        return quantidadeEstoque;
    }

    public String getCor() {
        return cor;
    }

    public String getMarca() {
        return marca;
    }

    public String getTamanho() {
        return tamanho;
    }

    public String getMaterial() {
        return material;
    }

    public double getAvaliacao() {
        return avaliacao;
    }
}
