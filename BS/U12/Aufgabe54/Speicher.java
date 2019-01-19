public class Speicher {

	int anzahl_der_schreibewuensche;
	int anzahl_leser;
	boolean schreiber_aktiv;
	String daten;
	
	// Hier Code ergänzen
	public Speicher(                                      ) {
		// Hier Code ergänzen
	
	
	
	
	
	
	
	
	
	}

	public synchronized void leserechte_holen(int prozess_id) {
		try {
			// Hier Code ergänzen
		   while (                                                ) {
		   // Hier Code ergänzen
			
			



			
		   }
		} catch (InterruptedException ie) {}
		
		// Hier Code ergänzen
		
		

		
		System.out.println("Prozess " + prozess_id
			+ " ==> Leserecht erhalten (" + anzahl_leser + " Leser)");
	}

	public synchronized void leserechte_freigeben(int prozess_id) {
		// Hier Code ergänzen
		

		
		
		System.out.println("Prozess " + prozess_id
			+ " ==> Leserecht freigegeben (" + anzahl_leser + " Leser)");
		// Hier Code ergänzen
		
		
		
	}

	public synchronized void schreibrecht_holen(int prozess_id) {
		try {
		   anzahl_der_schreibewuensche++;
		   // Hier Code ergänzen
		   while (                                                ) {
		      // Hier Code ergänzen
			

	

				
				
		   }
			schreiber_aktiv = true;
		} catch (InterruptedException ie) {
		}
		System.out.println("Prozess " + prozess_id
			+ " ==> Schreibrecht erhalten (" + anzahl_leser + " Leser)");
	}

	public synchronized void schreibrecht_freigeben(int prozess_id) {
		// Hier Code ergänzen
		

		

		
		schreiber_aktiv = false;
		System.out.println("Prozess " + prozess_id
			+ " ==> Schreibrecht freigegeben (" + anzahl_leser + " Leser)");
		// Hier Code ergänzen
		


		
		
	}

	public String lese() {
		try { // Das Lesen dauert etwas...
			Thread.sleep(400);
		} catch (InterruptedException e) {}
		return daten;
	}

	public synchronized void schreibe(String s) {
		try { // Das Schreiben dauert etwas...
			Thread.sleep(400);
		} catch (InterruptedException e) {}
		this.daten = s;
	}

}
