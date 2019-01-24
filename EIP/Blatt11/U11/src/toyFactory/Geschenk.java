package toyFactory;

public class Geschenk {

    protected String name;
    protected Double schwierigkeit = Zufall.schwierigkeit(25 );



    public String toString(){
        return "name "+name +"; Schwierigkeit "+ schwierigkeit;
    }

    public String name(){
        return name;
    }

    public Double schwierigkeit(){
        return schwierigkeit;
    }

}
