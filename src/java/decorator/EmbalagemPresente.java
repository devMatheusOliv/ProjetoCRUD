/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package decorator;

/**
 *
 * @author mathe
 */
public class EmbalagemPresente extends PromocaoOpcionalDecorator {

    public EmbalagemPresente(Calcado calcado) {
        super(calcado);
    }

    @Override
    public String getDescricao() {
        return Calcadodecorator.getDescricao()
                + "\n  + Embalagem para presente: +R$ 10,00";
    }

    @Override
    public Double Preco() {
        return Calcadodecorator.Preco() + 10.00;
    }
}
