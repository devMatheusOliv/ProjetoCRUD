/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package decorator;

/**
 *
 * @author mathe
 */
public class Desconto extends PromocaoOpcionalDecorator {

    public Desconto(Calcado calcado) {
        super(calcado);
    }

    @Override
    public String getDescricao() {
        double valorDesconto = Calcadodecorator.Preco() * 0.10;
        return Calcadodecorator.getDescricao()
                + "\n  + Desconto 2 pares: -R$ " + String.format("%.2f", valorDesconto) + " (-10%)";
    }

    @Override
    public Double Preco() {
        return Calcadodecorator.Preco() * 0.90;
    }
}
