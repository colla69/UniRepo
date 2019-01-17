public class ArrayMethods {
	
	/** Die Methode vertauscht die Eintraege zweier Positionen eines Arrays
	 *	miteinander.
	 * @param	array:	das Array, in dem Positionen eins mit Position 
	 *					zwei vertauscht wird.
	 * @param	i:	Position eins im Array.
	 * @param	j:	Position zwei im Array.
	 */
	public static void swap(int[] array, int i, int j) {
		if(i == j)
			return;
		int temp = array[i];
		array[i] = array[j];
		array[j] = temp;
	}
	
	/** Sortiert die Eintraege eines Arrays der Groesse nach aufsteigend.
	* @param	array:	das Array, das sortiert wird
	*/
	public static void sort(int[] array) {
		for(int i = 0; i < array.length; i++) {
			int min = Integer.MAX_VALUE;
			int minPos = 0;
			for(int j = i; j < array.length; j++) {
				if(min > array[j]) {
					min = array[j];
					minPos = j;
				}
			}
			int temp = array[i];
			array[i] = array[minPos];
			array[minPos] = temp;
		}
	}
	
	/** Diese Methode bestimmt den Wert des Medians eines Arrays.
	* @param	array:	das Array, dessen Median bestimmt wird.
	* @return	der Median des Arrays array.
	*/
	public static int median(int[] array){
		sort(array);
		return array[array.length/2];
	}
	
	/** Diese Methode wandelt ein Array beliebiger Laenge in ein Array 
	*	anderer Laenge um.
	* @param	array:	das Start-Array, dessen Laenge geaendert wird.
	* @param	length:	die neue Laenge des Arrays
	* @return   Das laengenveraenderte Array
	*/
	public static int[] resize(int[] array, int length) {
		if(length == array.length)
			return array;
		int[] tempArray = new int[length];
		if(length < array.length)
			for(int i = 0; i < length; i++)
				tempArray[i] = array[i];
		else {
			for(int i = 0; i < array.length; i++)
				tempArray[i] = array[i];
			for(int i = array.length; i < length; i++)
				tempArray[i] = 0;
		}
		return tempArray;
	}
	
	/** Die Methode gibt die Eintraege eines Arrays aus.
	* @param	array:	das Array, das als String ausgegeben wird
	* @return	ein String, der die Eintraege des Arrays in richtiger 
	*			Reihenfolge enthaelt.
	*/
	public static String show(int[] array) {
		String str = "[";
		for(int i = 0; i < array.length; i++) {
			str += " " + array[i];
		}
		str += " ]";
		return str;
	}
}