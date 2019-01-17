import java.util.Random;

public class Schleifen {
	
	public static void main(String[] args){
		
		//System.out.println(a());
		//g(0);g(1);g(2);g(3);System.out.println();
		//g2(0);g2(1);g2(2);g2(3);System.out.println();
		//g3(0);g3(1);g3(2);g3(3);System.out.println();
		
		//System.out.println(istPrim(1981345234256234L));
		/*d();
		int x,y,z;
		Random random = new Random();
		x = random.nextInt()%50+50;
		y = random.nextInt()%50+50;
		z = random.nextInt()%50+50;
		System.out.println(x + " " + y + " " + z);
		sortiere(x,y,z);
		
		int i = (int)((char) 65536);
		System.out.println(i);*/
		
		d();
	}
	
	
	public static void a(){
		int i = 0;
		int j = 0;
		do {
			j = j++;
			i = j + i;
			System.out.println(i + "  " + j);
		} while(i < 200);
	}
	
	public static void b(){
		double i = 0.5;
		double j = 0;
		while(j < 1) {
			j += i;
			i *= 0.5;
			System.out.println(i + "  " + j);
		}
	}
	
	public static void c(){
		char i = 'a';
		short j = 0;
		while (i != j) {
			i++;
			j = (short) (i+i);
		}
	}
	
	public static void d(){
		long i = 26L;
		long j = 24L;
		long startTime = System.nanoTime();    

		for (long x = 0L; x < 1000L; x++)
		{
		  i = i / 12 + 23 * (--x);
		  j = (x--) + j + 5;
		  //System.out.println(i + "  " + j + "  " + x);
		}
		long estimatedTime = System.nanoTime() - startTime;
		System.out.println("time: " + estimatedTime);
	}
	
	public static int ggTI(int a, int b) {
		int erg;
		if(b == 0)
			erg = a;
		else if(a == 0)
			erg = b;
		else if(a > b)
			erg = ggTI(a-b,b);
		else 
			erg = ggTI(a,b-a);
		return erg;
	}
	
	public static void e(){
		int i = 0;
		int j = 42;
		while(i < j ^ i > j); { 
			i++;
			j--;
		}
		
		System.out.println(i + "  " + j);
	}
	
	public static void f(){
		int n = 1;
		double x = 0;
		double s;
		do {
			s = 1.0 / (n * n);
			x = x + s;
			n++;
		} while (s > 0.01);
		System.out.println(n + "  " + x + "  " + s);
	}
	
	public static void g(int n) {
		double x = 0.;
		double y = 1.;
		int i = 1;
		do {
			x = x + y;
			y = y / i;
		} while(i++ <= n);
		 
		System.out.print("  " + x + "-" + y);
	}

	public static void g2(int n) {
		double x = 1.;
		double y = 1.;
		int i = 1;
		while((i++) <= n) {
			x = x + y;
			y = y / i;
		}
		 
		System.out.print("  " + x + "-" + y);
	}
	
	public static void g3(int n) {
		double x = 1.;
		double y = 1.;
		for(int i = 1; i <= n; i++) {
			
			x = x + y;
			y = y / (i+1);
			
		}
		System.out.print("  " + x + "-" + y);
	}
	
	public static void h(){
		switch(4){
			case 1: System.out.println(1);break;
			case 4: System.out.println(4);break;
			case 5: System.out.println(5);break;
			default: System.out.println("def");
		}
		
	}
	
	public static long ggT(long a, long b) {
		while(b != 0){
			if(a > b)
				a = a - b;
			else
				b = b - a;
		}
		return a;
	}
	
	/*public static boolean istPrim(long n){
		int j = n%2*n%3*n%4*n%5
		switch(n)
		for(int i = 1; i < n; i++) {
			if(ggT(i,n) != 1)
				return false;
		}
		return true;
	}*/
	
	public static void sortiere(int x, int y, int z){
		int a = 0;
		a += (x > y ? 1 : 0);
		a += (x > z ? 2 : 0);
		a += (y > z ? 4 : 0);
		//System.out.println(a);
		
		
		// TODO
		switch(a){
			case 1: ausgabe(y,x,z); break;
			//case 2:
			case 3: ausgabe(y,z,x); break;
			//case 4: ausgabe(x,z,y); break;
			case 5: ausgabe(z,y,x); break;
			case 6: ausgabe(z,x,y); break;
			case 7: ausgabe(z,y,x); break;
			default: ausgabe(x,y,z); break;
		}
	}
	
	public static void ausgabe(int a, int b, int c) {
		if(a > b || a > c || b > c)
			System.out.println("Da stimmt etwas nicht!");
		System.out.println("Es gilt: " + a + " <= " + b + " <= " + c);
	}
	
	public static void test(){
		double x = 0.;
		for(int i = 0; i < 20; i++){
			x += 0.4/Math.pow(10.,i);
			System.out.println(x);
		}
	}
	
	
}