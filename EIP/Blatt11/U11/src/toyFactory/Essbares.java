package toyFactory;

public class Essbares extends Geschenk {

    private boolean gesund;

    public Essbares(){
        this.schwierigkeit = Zufall.schwierigkeit(15);

        if (Math.floor( schwierigkeit ) % 2 == 0 ){
            this.gesund = true;
        } else {
            this.gesund = false;
        }
    }

    public String toString(){
        return super.toString() + " gesund "+ this.gesund;
    }
}
