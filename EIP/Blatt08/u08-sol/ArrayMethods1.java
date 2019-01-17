public class ArrayMethods {
	/** Gibt den Wert einer bestimmten Position von einem Array zurueck.
	 * @param	array:	das Array
	 * @param	i: 	die Position im Array, deren Wert bestimmt wird
	 * @return	der Wert an der Position i in einem Array
	 */
	public static int arrayGet(int[] array, int i) {
		if(i < 0 || i > array.length-1)
			return Integer.MIN_VALUE;
		else
			return array[i];
	}
	
	/** Bestimmt die Summe aller Eintraege des Arrays.
	 * @param	array, das Array, dessen Eintraege summiert werden.
	 * @return	die Summe aller Eintraege des Arrays.
	 */
	public static int sum(int[] array) {
		int sum = 0;
		for(int i = 0; i < array.length; i++) {
			sum += array[i];
		}
		return sum;
	}
	
	/**Die Methode bestimmt den Mittelwert aller Eintraege eines int-Arrays
	 * @param	array:	das Array, von dem der Mittelwert berechnet wird.
	 * @return	der Mittelwert aller Eintraege des Arrays.
	 */
	public static int mean(int[] array) {
		return sum(array)/array.length;
	}
	
	/**Die Methode quadriert jeden Eintrag eines int-Arrays
	 * @param	array:	das Array, dessen Eintraege quadriert werden.
	 */
	public static void square(int[] array) {
		for(int i = 0; i < array.length; i++) {
			array[i] = array[i]*array[i];
		}
	}
	
	/**Die Methode findet fuer ein Array den groessten Wert aller Eintraege
	 * @param	array:	das Array, dessen Eintraege nach dem Groessten
	 *					durchsucht werden.
	 * @return	der groesste Eintrag des Arrays.
	 */	
	public static int max(int[] array) {
	int max = Integer.MIN_VALUE;
	for(int i = 0; i < array.length; i++) {
		if(array[i] > max) {
			max = array[i];
		}
	}
	return max;
	}
}