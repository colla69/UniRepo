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
		if(dimension < 0)
			dimension = 0;
		vek = new Integer[dimension];
		for(int i = 0; i < vek.length; i++) {
			vek[i] = 0;
		}
	}
	
	public Vektor(int dimension, int defaultValue) {
		this(dimension);
		for(int i = 0; i < vek.length; i++) {
			vek[i] = defaultValue;
		}
	}
	
	public Integer get(int i) {
		if(i < 0)
			return null;
		if(i > vek.length - 1)
			return null;
		return vek[i];
	}
	
	public int getDim() {
		return vek.length;
	}
	
	public void set(int i, int value) {
		if(0 <= i && i < vek.length)
			vek[i] = value;
	}
	
	public boolean equals(Vektor v) {
		if(v == null)
			return false;
		if(v.getDim() != this.getDim())
			return false;
		for(int i = 0; i < vek.length; i++) {
			if(vek[i] != v.get(i))
				return false;
		}
		return true;
	}
	
	public boolean contains(int k) {
		for(int i = 0; i < vek.length; i++) {
			if(vek[i] == k)
				return true;
		}
		return false;
	}
	
	public String toString() {
		String str = "[";
		for(int i = 0; i < vek.length; i++) {
			if(i != 0)
				str += " ";
			str += vek[i];
		}
		str += "]";
		return str;
	}
	
	public Vektor addiere(Vektor v) {
		if(v == null)
			return null;
		if(v.getDim() != this.getDim())
			return null;
		Vektor sum = new Vektor(vek.length);
		for(int i = 0; i < vek.length; i++) {
			sum.set(i,vek[i]+v.get(i));
		}
		return sum;
	}
	
	public Integer skalarprodukt(Vektor v) {
		if(v == null)
			return null;
		if(v.getDim() != this.getDim())
			return 0;
		int sum = 0;
		for(int i = 0; i < vek.length; i++) {
			sum += vek[i]*v.get(i);
		}
		return sum;
	}
	
}
