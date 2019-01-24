package toyFactory;

public class Kleidung extends Geschenk {

    private int eleganz;

    public Kleidung(){
        this.eleganz = this.name.length();
    }

    public String toString(){
        return super.toString() + " eleganz "+ this.eleganz;
    }
}
