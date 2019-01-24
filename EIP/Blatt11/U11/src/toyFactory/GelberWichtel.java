package toyFactory;

public class GelberWichtel extends Wichtel {


    public GelberWichtel(Wichtel.Color color) {
        super(color);
    }

    public String toString(){
        return this.toString()+this.color.toString();
    }

}
