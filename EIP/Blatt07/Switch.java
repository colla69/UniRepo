import java.util.Random;

public class Switch {
	
	private static boolean test = true;
	
	public static void main(String[] args){
		
		for(int i = 0; i < 10000; i++) {
			int x,y,z;
			Random random = new Random();
			x = random.nextInt()%50+50;
			y = random.nextInt()%50+50;
			z = random.nextInt()%50+50;
			System.out.println(x + " " + y + " " + z);
			sortiere(x,y,z);
		}
		
		if(test)
			System.out.println("--------------------\nAlles gut!");
		else
			System.out.println("--------------------\nLeider gab es Fehler!");
	}
	
	public static void sortiere(int x, int y, int z){
		int a = 0;
		a += (x > y ? 1 : 0);
		a += (x > z ? 2 : 0);
		a += (y > z ? 4 : 0);
		
		// TODO
		
	}
	
	public static void ausgabe(int a, int b, int c) {
		if(a > b || a > c || b > c) {
			System.out.println("Da stimmt etwas nicht!");
			test = false;
		}	
		System.out.println("Es gilt: " + a + " <= " + b + " <= " + c);
	}
}