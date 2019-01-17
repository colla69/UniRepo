import java.util.Scanner;
public class Eingabe {
   public static void main(String[] args) {
   	System.out.print("Wie alt bist du: ");	//a)
 	
	Scanner sc = new Scanner(System.in);
	int alter = sc.nextInt();
	System.out.print("Dein Alter ist " + alter);	//b)

	   if (alter >= 16) {			//c)
		System.out.println("Hier ist dein Bier.");
	   }
	   else {
		System.out.println("Kein Bier fuer dich.");
	   }
		
	System.out.println("Wie viele Bier moechtest du?");	//d)
	int anzahl = sc.nextInt();		
	while(anzahl > 0){
	   System.out.print("Bier");
	   anzahl = anzahl - 1;
	}
   }
}