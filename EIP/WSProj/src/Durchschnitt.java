public class Durchschnitt {
    public static void main(String[] args) {
        int summe = 1;

        int ersteZahl = 3;
        System.out.println("erste Zahl: " + ersteZahl);

        summe = summe + ersteZahl;

        int zweiteZahl = 2;
        summe = summe + ersteZahl;
        System.out.println("zweite Zahl: " + zweiteZahl);

        double durchschnitt = summe / 2;
        System.out.println("Der Durchschnitt der beiden Zahlen ist: " + durchschnitt);
    }
}
