/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package decorator;

/**
 *
 * @author mathe
 */
public class Meia extends PromocaoOpcionalDecorator {

    public Meia(Calcado calcado) {
        super(calcado);
    }

    @Override
    public String getDescricao() {
        return Calcadodecorator.getDescricao()
                + "\n  + Meia: +R$ 19,90";
    }

    @Override
    public Double Preco() {
        return Calcadodecorator.Preco() + 19.90;
    }
}
