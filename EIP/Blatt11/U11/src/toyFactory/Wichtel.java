package toyFactory;

public abstract class Wichtel {

    final private String name = Zufall.koboldname();
    private Integer arbeitsZeit = 0;
    private Integer anzGeschenke = 0;
    protected Color color;
    private boolean arbeitet = false;

    public Wichtel(Color color){
        this.color = color;
    }

    public void arbeite(Geschenk g){
        return;
    }

    public boolean arbeitetNoch(){
        return arbeitet;
    }

    public void arbeiteWeiter(){
        arbeitsZeit -= 1;
    }

    public String toString(){
        return this.name;
    }

    public enum Color {
        ROT,BLAU,GELB;

        public String toString(){
            switch (this){
                case BLAU : return "BLAU";
                case ROT : return "ROT";
                case GELB : return "GELB";
            }
            return "";
        }
    }
}
