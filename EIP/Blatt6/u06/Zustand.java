public class Zustand
{
	public static void main(String[] args) {
		final int DIV = 24;
		int variable;
		int counter = 1;
		{
			// *a* 
			variable = counter++;  
			int y = 12;    	
			variable += y;
			counter++;
			// *b*
		}
		final double d;
		{  
			counter = 4;
			double a = 10.0;
			{
				d = a + ++counter;
				// *c*
			}
			counter = 3;
			while(counter > 0){
				counter--;
				a -= counter;
				// *d*
			}
		} 
		variable = variable / DIV;
		// *e*
	} 
}