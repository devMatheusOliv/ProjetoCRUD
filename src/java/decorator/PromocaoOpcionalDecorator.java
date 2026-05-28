/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package decorator;

/**
 *
 * @author mathe
 */
public abstract class PromocaoOpcionalDecorator implements Calcado {

    protected Calcado Calcadodecorator;

    public PromocaoOpcionalDecorator(Calcado calcado) {
        this.Calcadodecorator = calcado;
    }

    @Override
    public String getDescricao() {
        return Calcadodecorator.getDescricao();
    }

    @Override
    public Double Preco() {
        return Calcadodecorator.Preco();
    }
}
