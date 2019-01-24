package toyFactory;

public class BlauerWichtel extends Wichtel {


    public BlauerWichtel(Wichtel.Color color) {
        super(color);
    }

    public String toString(){
        return this.toString()+this.color.toString();
    }


}
