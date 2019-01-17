import java.util.Random;

public class SwitchLsg {
	
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
		switch(a){
			case 1: ausgabe(y,x,z); break;
			//case 2: nicht erreichbar!
			case 3: ausgabe(y,z,x); break;
			case 4: ausgabe(x,z,y); break;
			//case 5: nicht erreichbar!
			case 6: ausgabe(z,x,y); break;
			case 7: ausgabe(z,y,x); break;
			default: ausgabe(x,y,z); break;
		}
		
		
	}
	
	public static void ausgabe(int a, int b, int c) {
		if(a > b || a > c || b > c) {
			System.out.println("Da stimmt etwas nicht!");
			test = false;
		}	
		System.out.println("Es gilt: " + a + " <= " + b + " <= " + c);
	}
}