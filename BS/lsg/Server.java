public class Server {
    private int maxClients;
    private int anzahlClients;
    private boolean sicherungswunsch;

    public Server(int max) {
        maxClients = max;
        anzahlClients = 0;
        sicherungswunsch = true;
    }

    public synchronized void daten_ablegen(Client c) throws InterruptedException {

        System.out.println("Client " + c.ID + " will Daten ablegen");

        while (sicherungswunsch||(maxClients<=anzahlClients)) {
            try {
                wait();
                System.out.println("Client " + c.ID + " wartet mit der Ablage");
            } catch (InterruptedException e) {

            }
        }

        anzahlClients++;
        System.out.println(anzahlClients + " Clients legen Daten ab.");
    }

    public synchronized void daten_ablegen_beenden() {
        anzahlClients--;
        notifyAll();
    }

    public synchronized void sicherungAktivieren() throws InterruptedException {


        System.out.println("Sicherungswunsch angemeldet!");

        while (anzahlClients > 0) {
            try {
                wait();
            } catch (InterruptedException e) {
            }

        }
        // Zum Sichern bereit.
        sicherungswunsch = true;
        notifyAll();
    }

    public synchronized void sicherungDeaktivieren() {

        sicherungswunsch = false;
        System.out.println("Sicherungswunsch deaktiviert.");
        notifyAll();


    }
}
