public class Prozess extends Thread {
	private Speicher my_speicher;
	private int prozess_id;

	public Prozess(int prozess_id, Speicher my_speicher) {
		this.prozess_id = prozess_id;
		this.my_speicher = my_speicher;
	}

	public void run() {
		System.out.println("prozess " + prozess_id + " is now running");
		while (true) {
			if (Math.random() >= 0.5) {
				// Hole Leserecht
				my_speicher.leserechte_holen(prozess_id);
				// lese
				System.out.println("Prozess " + prozess_id + " hat gelesen: "
						+ my_speicher.lese());
				// Leserecht freigeben
				my_speicher.leserechte_freigeben(prozess_id);
			} else {
				// Arbeite als Schreiber
				my_speicher.schreibrecht_holen(prozess_id);
				// schreibe
				my_speicher.schreibe(Integer.toString(prozess_id));
				// schreiben
				my_speicher.schreibrecht_freigeben(prozess_id);
			}
		}
	}
}
