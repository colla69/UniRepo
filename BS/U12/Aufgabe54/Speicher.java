public class Speicher {

	int anzahl_der_schreibewuensche;
	int anzahl_leser;
	boolean schreiber_aktiv;
	String daten;
	
	// Hier Code erg�nzen
	public Speicher(                                      ) {
		// Hier Code erg�nzen
	
	
	
	
	
	
	
	
	
	}

	public synchronized void leserechte_holen(int prozess_id) {
		try {
			// Hier Code erg�nzen
		   while (                                                ) {
		   // Hier Code erg�nzen
			
			



			
		   }
		} catch (InterruptedException ie) {}
		
		// Hier Code erg�nzen
		
		

		
		System.out.println("Prozess " + prozess_id
			+ " ==> Leserecht erhalten (" + anzahl_leser + " Leser)");
	}

	public synchronized void leserechte_freigeben(int prozess_id) {
		// Hier Code erg�nzen
		

		
		
		System.out.println("Prozess " + prozess_id
			+ " ==> Leserecht freigegeben (" + anzahl_leser + " Leser)");
		// Hier Code erg�nzen
		
		
		
	}

	public synchronized void schreibrecht_holen(int prozess_id) {
		try {
		   anzahl_der_schreibewuensche++;
		   // Hier Code erg�nzen
		   while (                                                ) {
		      // Hier Code erg�nzen
			

	

				
				
		   }
			schreiber_aktiv = true;
		} catch (InterruptedException ie) {
		}
		System.out.println("Prozess " + prozess_id
			+ " ==> Schreibrecht erhalten (" + anzahl_leser + " Leser)");
	}

	public synchronized void schreibrecht_freigeben(int prozess_id) {
		// Hier Code erg�nzen
		

		

		
		schreiber_aktiv = false;
		System.out.println("Prozess " + prozess_id
			+ " ==> Schreibrecht freigegeben (" + anzahl_leser + " Leser)");
		// Hier Code erg�nzen
		


		
		
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
