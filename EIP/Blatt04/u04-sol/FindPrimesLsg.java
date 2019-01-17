/**
 * Programm zum Finden von Primzahlen.
 * Es wird der euklidische Algorithmus 
 * zum Berechnen des ggT's benutzt.
 */
public class FindPrimesLsg {
  
	/**
	 * Implementation des euklidischen Algorithmus
	 * Zwei ganze Zahlen werden als Eingabe akzeptiert
	 * Die Ausgabe ist der ggT beider Eingabezahlen.
	 * Der Aufruf kann innerhalb dieser Datei durch
	 * ggT(Zahl1, Zahl2) erfolgen.
	 */
	public static int ggT(int a, int b) {
		while(b != 0) {
			/* TODO a):
			 * euklidischer Algorithmus
			 */
			if(a > b)
				a -= b;
			else 
				b -= a;
		}
		return a;
	}
  
	/**
	 * main Methode.
	 * Keine Eingabe wird benoetigt.
	 */
	public static void main(String[] args) {
		
		// Partielle Tests fuer die Korrektheit des ggT
		// Hier sehen Sie auch einen Aufruf fuer ggT() und
		// koennen in an spaeterer Stelle auch so verwenden
		System.out.println(ggT(73, 21) == 1);
		System.out.println(ggT(63, 42) == 21);
		
		// Dies ist der aktuelle Kandidat, der getestet wird,
		// ob er prim ist.
		int kandidat = 1;
		
		// Jeder Kandidat bis zur oberen Schranke (z.B. 100) wird 
		// getestet
		while(kandidat < 1000) {
			// erhoehe in jedem Durchgang kandidat um 1, um die
			// naechstgroessere Zahl zu erhalten.
			kandidat = kandidat + 1;
			
			// wir berechnen inkrementell das Produkt aller 
			// ggT(i,kandidat)
			int ggTProdukt = 1;
			
			
			/** TODO b): 
			 * - Fuehren Sie eine neue Variable "int i" ein. 
			 * - Eine while-Schleife soll alle i > 1 durchlaufen, 
			 *   die kleiner als der Kandidat sind
			 * - Fuer jedes i soll der ggT mit dem Kandidaten 
			 *   berechnet werden
			 * - Dann wird dieser Wert mit dem bisherigen ggTProdukt 
			 *   multipliziert
			 * - Nicht vergessen: i muss mit jedem Durchlauf erhoeht werden.
			*/
			
			int i = 2;
			while(i < kandidat) {
				ggTProdukt = ggTProdukt * ggT(i,kandidat);
				i = i+1;
			}
			
			
			// TODO c): Gib Zahl aus, genau dann wenn ggTProdukt == 1
			if(ggTProdukt == 1) {
				System.out.print(" " + kandidat);
			}			
		}
	}
}