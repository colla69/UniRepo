import java.util.Random;
	//-------------------------------------------------------------- a)
public class Sudoku {
	
	final int n = 3;
	final int gridsize = n*n;	
	int[][] field = new int[gridsize][gridsize];
	Random random = new Random();
	
	public Sudoku() {
	}
	
	/**
	* Getter for single entries
	*/
	private String get(int i, int j) {
	}

	private String line(int n){
	}
	
	//-------------------------------------------------------------- c)
	/**
	* Two rows in one band are swapped. This produces 3!^3 as much solutions.
	*/
	private void permutateRows(int a, int b) {
	}
	
	/**
	* Two columns in one stack are swapped. This produces 3!^3 as much solutions.
	*/
	private void permutateColumns(int a, int b) {
	}

	//-------------------------------------------------------------- d)
	/**
	* Two stacks are swapped. This produces 3! as much solutions.
	*/
	private void permutateStacks(int a, int b) {
	}
	
	/**
	* Two bands are swapped. This produces 3! as much solutions.
	*/	
	private void permutateBands(int a, int b) {
	}
	
	//-------------------------------------------------------------- e)
	/**
	* Two rows in one band are swapped. This produces 3!^3 as much solutions.
	*/
	private void permutateRows() {
	}
	
	/**
	* Two columns in one stack are swapped. This produces 3!^3 as much solutions.
	*/
	private void permutateColumns() {
	}
	
	private void permutateStacks() {
	}
	
	private void permutateBands() {
	}

	//-------------------------------------------------------------- f) 
	/**
	* The matrix is transposed. This produces double as much solutions.
	*/	
	private void transpose() {
	}
	//--------------------------------------------------------------  g)
	private void randomPermutation(){
	}
	
	//--------------------------------------------------------------  h)
	/**
	* Returns random row of digits. Used to relabel digits in the initial matrix
	* This yields 9! as much solutions.
	*/ 
	private int[] randomRow(){
	}

	//--------------------------------------------------------------  i)	
	private void hide(int n) {
	}
	
	/*****************************************/       //gegeben
	public static void main(String[] args){
		Sudoku s = new Sudoku(100000);
		System.out.println(s);
		s.hide(50);
		System.out.println(s);
	}	
}
