public class Vektor {
	private Integer[] vek;
	
	public static void main(String[] args) {
		Vektor v1 = new Vektor(3,4);
		Vektor v2 = new Vektor(3,1);
		v2.set(4,9);
		System.out.println(v1);
		System.out.println(v1.addiere(v2));
		System.out.println(v1.skalarprodukt(v2));
		Vektor v3 = null;
		System.out.println(v3);
	}
	
	public Vektor(int dimension) {
	//TODO 10-2a)
	}
	
	public Vektor(int dimension, int defaultValue) {
	//TODO 10-2b)
	}
	
	public Integer get(int i) {
	//TODO 10-2c)
	}
	
	public int getDim() {
	//TODO 10-2c)
	}
	
	public void set(int i, int value) {
	//TODO 10-2c)
	}
	
	public boolean istGleich(Vektor v) {
	//TODO 10-2d);
	}
	
	public Integer enthaelt(int k) {
	//TODO 10-2e)
	}
	
	public String toString() {
	//TODO 10-2f)
	}
	
	public Vektor addiere(Vektor v) {
	//TODO 10-2g)
	}
	
	public Integer skalarprodukt(Vektor v) {
	//TODO 10-2h)
	}
	
}
