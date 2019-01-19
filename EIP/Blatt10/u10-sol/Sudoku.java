import java.util.Random;
	//-------------------------------------------------------------- a)
public class Sudoku {
	
	final int n = 3;
	final int gridsize = n*n;	
	int[][] field = new int[gridsize][gridsize];
	
	Random random = new Random();
	
	public Sudoku() {
		int[] firstRow = {1,2,3,4,5,6,7,8,9};
		//h):  int[] firstRow = randomRow();
		for (int i = 0; i < gridsize; i++)
			for (int j = 0; j < gridsize; j++)
				field[i][j] = (i*n + i/n + j) % gridsize + 1;
				//h):  field[i][j] = firstRow[(i*n + i/n + j) % gridsize];
		System.out.println(this);
	}
	
	//------------------------------------------------------------- g)
	public Sudoku(int permutationCount) {
		this();
		randomPermutation(permutationCount);
	}	
	
	//-------------------------------------------------------------- b) 
	/**Die Methode gibt ein Sudoku-Objekt als einen String zurueck
	 * @return	der String eines Sudoku-Objektes
	 */
	public String toString() {
		String str = line(25);
		
		for(int i = 0; i < 9; i++){
			str += "|";
			for(int j = 0; j < 9; j++){
				str += " " + get(i,j);
				if(j == 2 || j == 5 || j == 8)
					str += " |";
			}
			str += "\n";
			if(i == 2 || i == 5 || i == 8){
				str += line(25);
			}
		}
		return str;
	}
	
	
	
	
	
	
	
	
	/**
	* Getter for single entries
	*/
	private String get(int i, int j) {
		if(i < 0 || i > gridsize + 1 || j < 0 || j > gridsize + 1) {
			return " ";
		}
		int m = field[i][j];
		if(m == 0)
			return " ";
		return ""+m;
	}

	private String line(int n){
		String str = "";
		for(int i = 0; i < n; i++)
			str += "-";
		return str+"\n";
	}
	
	//-------------------------------------------------------------- c)
	/**
	* Two rows in one band are swapped. This produces 3!^3 as much solutions.
	*/
	private void permutateRows(int a, int b) {
		if(a > 0 && a < 10 && b > 0 && b < 10) {
			for(int i = 0; i < gridsize; i++) {
				int temp = field[i][a-1];
				field[i][a-1] = field[i][b-1];
				field[i][b-1] = temp;
			}
		}
	}
	
	/**
	* Two columns in one stack are swapped. This produces 3!^3 as much solutions.
	*/
	private void permutateColumns(int a, int b) {
		if(a > 0 && a < 10 && b > 0 && b < 10) {
			int[] array = field[a-1];
			field[a-1] = field[b-1];
			field[b-1] = array;
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	//-------------------------------------------------------------- d)
	/**
	* Two stacks are swapped. This produces 3! as much solutions.
	*/
	private void permutateStacks(int a, int b) {
		if(b < a) {
			permutateStacks(b,a);
			return;
		}
		
		if(a == 1 && b == 2) {
			permutateColumns(1,4);
			permutateColumns(2,5);
			permutateColumns(3,6);
		}
		else if(a == 1 && b == 3) {
			permutateColumns(1,7);
			permutateColumns(2,8);
			permutateColumns(3,9);			
		}
		else if(a == 2 && b == 3) {
			permutateColumns(4,7);
			permutateColumns(5,8);
			permutateColumns(6,9);			
		}
	}
	
	/**
	* Two bands are swapped. This produces 3! as much solutions.
	*/	
	private void permutateBands(int a, int b) {
		if(b < a) {
			permutateBands(b,a);
			return;
		}
		
		if(a == 1 && b == 2) {
			permutateRows(1,4);
			permutateRows(2,5);
			permutateRows(3,6);
		}
		else if(a == 1 && b == 3) {
			permutateRows(1,7);
			permutateRows(2,8);
			permutateRows(3,9);			
		}
		else if(a == 2 && b == 3) {
			permutateRows(4,7);
			permutateRows(5,8);
			permutateRows(6,9);			
		}
	}
	
	
	
	//-------------------------------------------------------------- e)
	/**
	* Two rows in one band are swapped. This produces 3!^3 as much solutions.
	*/
	private void permutateRows() {
		int block = random.nextInt(3);
		int a = random.nextInt(3)+1;
		int b = random.nextInt(3)+1;
		permutateRows(a+block*3,b+block*3);
	}
	
	/**
	* Two columns in one stack are swapped. This produces 3!^3 as much solutions.
	*/
	private void permutateColumns() {
		int block = random.nextInt(3);
		int a = random.nextInt(3)+1;
		int b = random.nextInt(3)+1;
		permutateColumns(a+block*3,b+block*3);
	}
	
	private void permutateStacks() {
		int a = random.nextInt(3)+1;
		int b = random.nextInt(3)+1;
		permutateStacks(a,b);
	}
	
	private void permutateBands() {
		int a = random.nextInt(3)+1;
		int b = random.nextInt(3)+1;
		permutateBands(a,b);
	}
	//-------------------------------------------------------------- f) 
	/**
	* The matrix is transposed. This produces double as much solutions.
	*/	
	private void transpose() {
		for (int i = 0; i < gridsize; i++)
			for (int j = 0; j < i; j++) {
				int temp = field[j][i];
				field[j][i] = field[i][j];
				field[i][j] = temp;
			}
	}
	//--------------------------------------------------------------  g)
	private void randomPermutation(){
		switch(random.nextInt(5)) {
			case 0: permutateRows(); break;
			case 1: permutateColumns(); break;
			case 2: permutateStacks(); break;
			case 3: permutateBands(); break;
			case 4: transpose();
			default:			
		}
	}
	
	private void randomPermutation(int n){
		for(int i = 0; i < n; i++)
			randomPermutation();
	}
	
	//--------------------------------------------------------------  h)
	/**
	* Returns random row of digits. Used to relabel digits in the initial matrix
	* This yields 9! as much solutions.
	*/ 
	private int[] randomRow(){
		boolean[] used = new boolean[gridsize];
		int[] row = new int[gridsize];
		for(int i = 0; i < gridsize; i++) {
			int candidate = random.nextInt(gridsize);
			if(!used[candidate]){
				used[candidate] = true;
				row[i] = candidate+1;
			}
			else {
				i--;
			}
		}
		return row;
	}

	//--------------------------------------------------------------  i)	
	private void hide(int n) {
		if(n < 0)
			n = 0;
		if(n > 81)
			n = 81;
		
		for(int k = 0; k < n; k++) {
			int i = random.nextInt(9);
			int j = random.nextInt(9);
			if(field[i][j] != 0)
				field[i][j] = 0;
			else
				k--;
		}
	}
	
	/*****************************************/       //gegeben
	public static void main(String[] args){
		Sudoku s = new Sudoku(100000);
		System.out.println(s);
		s.hide(50);
		System.out.println(s);
	}	
}