public class Uebung5_Loesung {

    /**	5-2   ----------------------------------------------------------------------------------
     * Berechnung der zweiten Wurzel einer natürlichen Zahl mit
     * Hilfe des Annaeherungsverfahrens von Heron.
     * @param   x der Radikand
     * @param   n die Rekursionstiefe
     * @return  die angenaeherte 2-te Wurzel von x
     */
    public static double quadratwurzel(double x, int n){
        if(x == -1){		// Nicht für die Wertung noetig
            return -1;
        }

        if(n == 0) {									// +1 Pkt
            return 0.5*(x+1.0);
        }
        else {       									// +1 Pkt
            double rek = quadratwurzel(x,n-1);
            double rek2 = quadratwurzel(x,n-1);
            return 0.5*(rek+x/rek);
        }
    }


    /**	5-3    ----------------------------------------------------------------------------------
     * Berechnung eines Vieta-Faktors zur Approximation des Wertes von Pi.
     * @param   n die Rekursionstiefe
     * @return  der approximierte Wert von Pi
     */
    public static double vietaFaktor(int n) {
        if(n == 0){													// +1 Pkt
            return 0.5*quadratwurzel(2.0,20);
        }
        else {														// +1 Pkt
            return 0.5*quadratwurzel(2.0+2.0*vietaFaktor(n-1),20);
        }
    }

    /** 5-3
     * Approximation des Wertes von Pi mit Hilfe der analytischen Darstellung von Vieta.
     * @param   n die Rekursionstiefe
     * @return  der approximierte Wert von Pi
     */
    public static double pi(int n) {		// +1 Pkt
        if(n == 0)
            return 2.0/vietaFaktor(0);
        else
            return 1.0/vietaFaktor(n)*pi(n-1);
    }



    /**	5-4    ----------------------------------------------------------------------------------
     * Berechnung der Distanz zwischen zwei zweidimensionalen Punkten.
     * @param   x1 die erste Koordinate des ersten Punktes
     * @param   y1 die zweite Koordinate des ersten Punktes
     * @param   x2 die erste Koordinate des zweiten Punktes
     * @param   y2 die zweite Koordinate des zweiten Punktes
     * @return  Die Distanz zwischen Punkt 1 und Punkt 2
     */
    public static double berechneDistanz(double x1,double y1,double x2,double y2){
        double dx = x2-x1;								// +1 Pkt, gesamter Teil
        double dy = y2-y1;
        return quadratwurzel(dx*dx+dy*dy,10);
    }
}
