public class Passwort {	
	public static void main(String[] args){		
		String eingabe = "";
		int index = 0;
		
		if(args.length > 0)
			eingabe = args[0];
		else 
			return;
		
		if(args.length > 1)
			index = Integer.parseInt(args[1]);
		
		if(index == 0)
			for(int i = 0; i < 26; i++) 
				System.out.println(code(eingabe, i));
		else
			System.out.println(code(eingabe, index));
	}	
	
	// A: 65, Z: 90
	// a: 97, z: 122
	public static String code(String eingabe, int index){
		// TODO
		String ausgabe = "";
		for(int i = 0; i < eingabe.length(); i++){
			char c = eingabe.charAt(i);
			if(c > 96 && c < 123) {		//falls c Kleinbuchstabe
				c = (char)(c + index);
				if(c > 122)
					c = (char)(c - 26);
					
			}
			ausgabe += c;
		}
		return ausgabe;
	}
}