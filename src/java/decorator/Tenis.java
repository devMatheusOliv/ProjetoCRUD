/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package decorator;

/**
 *
 * @author mathe
 */
public class Tenis implements Calcado {

    private String Descricao;
    private Double Preco;

    public Tenis(String Descricao, Double Preco) {
        this.Descricao = Descricao;
        this.Preco = Preco;
    }

    @Override
    public String getDescricao() {
        return Descricao;
    }

    @Override
    public Double Preco() {
        return Preco;
    }
}
