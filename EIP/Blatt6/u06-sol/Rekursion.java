public class Rekursion {
		
	public static void main(String[] args){
		
		//long x = potenz(11L,23);
		//System.out.println(peer(1000));
	
	}
	
	/* 6-3a */
	/**
	 * Bestimmt die Potenz x hoch y von zwei ganzen Zahlen
	 * @param x  Basis der Potenz
	 * @param y  Exponent der Potenz
	 * @return   Potenz x hoch y
	 */
	public static long potenz(long x, int y) {
		if(y <= 0)
			return 1;
		else
			return x * potenz(x, y - 1);
	}

	/* 6-3b */
	/**
	 * Bestimmt die Anzahl an Stellen einer ganzen Zahl m
	 * @param m  ganze Zahl
	 * @return Anzahl der Stellen
	 */
	public static int stellen(long m) {
		if(m < 0)
			return stellen(-m);
		if(m < 10)
			return 1;
		else
			return 1 + stellen(m / 10);
	}
	
	/**
	 * Diese Methode bestimmt die Spiegelzahl einer ganzen Zahl.
	 * Die Spiegelzahl ist die urspruengliche Zahl in umgedrehter Ziffernreihenfolge. 
	 * @param m  ganze Zahl
	 * @return Spiegelzahl von m
	 */
	public static long spiegelzahl(long m) {
		if(m < 0)
			return spiegelzahl(-m);
		if(m < 10)
			return m;
		else {
			return (m % 10)*potenz(10,(stellen(m)-1)) + spiegelzahl(m/10);
		}
			
	}
	
	/**
	 * Die Methode istPalindrom berechnet ob eine ganze Zahl ein Palindrom ist, oder nicht.
	 * @param m  ganze Zahl
	 * @return Wahrheitswert, ob m Palindrom ist
	 */
	public static boolean istPalindrom(long m) {
		if(m % 10 == 0) 
			return false;
		return spiegelzahl(m) == m;
	}
	
	
	
	
	/* fuer Strings, spaeter */
	public static boolean istPalindrom(String str) {
		if(str.length() <= 1)
			return true;
		return str.charAt(0) == str.charAt(str.length()-1) && istPalindrom(str.substring(1,str.length()-1));
	}
	
	
	/* 6-4 */
	/**
	 * Diese Methode bestimmt die Anzahl der getesteten Kekse von einer Startmenge.
	 * @param n  ganze Zahl (= Startmenge)
	 * @return Anzahl der getesteten Kekse
	 */
	public static int peer(int n) {
		if(n <= 1)
			return n;
		else if(n%2 == 0)
			return 2 + peer((n-2) / 2);
		else
			return 1 + peer(n-1);
	}	
	

	/* 6-5a */
	/** Die Methode bestimmt rekursiv die Summe der ersten n natuerlichen Zahlen.
	 * @param n naturliche Zahl bis zu der addiert werden soll
	 * @return Summer der ersten n nat. Zahlen.
	 */
	public static int summeRek(int n) {
		if(n == 0)
			return 0;
		return summeRek(n-1)+n;
	}
	
	/* 6-5b */
	/**
	 * Die Methode bestimmt iterativ die Summe der ersten n natuerlichen Zahlen.
	 * @param n natuerliche Zahl bis zu der addiert werden soll
	 * @return Summer der ersten n nat. Zahlen.
	 */
	public static int summeIt(int n) {
		int res = 0;
		while(n >= 0) {
			res += n;
			n--;
		}
		return res;
	}
	
	/* 6-5c */
	/** Diese Methode approximiert die Wurzel einer reelen Zahl x mit n Iterationen.
	 * @param x  reelle Zahl
	 * @param n  Iterationsschritte
	 * @return die n-te Approximation der Wurzel von x
	 */
	public static double wurzelIt(double x, int n) {
		double res = (x+1.0)/2.0;
		while(n > 0){
			n--;
			res = 0.5*(res + x/res);
		}
		return res;
	}
	
	/* 6-5d */
	/** fibIt berechnet die n-te Fibonacci Zahl
	 * @param n  natuerliche Zahl
	 * @return die n-te Fibonacci Zahl
	 */
	public static int fibIt(int n){
		int a = 1;
		int b = 1;
		while(n >= 2) {
			n--;
			if(a > b)
				b = a + b;
			else 
				a = a + b;
		}
		if(a > b)
			return a;
		return b;
	}
	
}
