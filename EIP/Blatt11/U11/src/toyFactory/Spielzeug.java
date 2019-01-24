package toyFactory;

public class Spielzeug extends Geschenk  {

    private double spannend;

    public Spielzeug(){
        this.schwierigkeit = Zufall.schwierigkeit(10);
        this.spannend = this.schwierigkeit*this.name.length()/10;
    }

    public String toString(){
        return super.toString()+" spannend "+ spannend;
    }
}
