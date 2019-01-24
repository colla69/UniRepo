package toyFactory;

public class RoterWichtel extends Wichtel {


    public RoterWichtel(Wichtel.Color color) {
        super(color);
    }

    public void arbeite(Geschenk g){
        arbeiteWeiter();
        arbeiteWeiter();

    }

    public String toString(){
        return this.toString()+this.color.toString();
    }

}
