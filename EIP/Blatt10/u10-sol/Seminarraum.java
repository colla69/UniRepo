public class Seminarraum {
	
	private int anzahlStuehle = 0;
	private final int maxStuehle;
	
	public Seminarraum(int maxStuehle) {
		if(maxStuehle < 0)
			maxStuehle = 0;
		this.maxStuehle = maxStuehle;
	}
	
	public int getStuehle() {
		return anzahlStuehle;
	}
	
	public void setStuehle(int anzahl) {
		if(anzahl <= maxStuehle && anzahl >= 0)
			anzahlStuehle = anzahl;
	}
	
	public void inc() {
		if(anzahlStuehle < maxStuehle)
			anzahlStuehle++;
	}
	
	public void dec() {
		if(anzahlStuehle > 0)
			anzahlStuehle--;
	}
	
	public String toString() {
		return "Der Raum hat " + anzahlStuehle + 
			" von maximal " + maxStuehle + " Stuehlen.";
	}
	
	public boolean equals(Seminarraum r) {
		return this.anzahlStuehle == r.getStuehle();
	}
	
}
