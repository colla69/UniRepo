public class Vaterprozess {
	private Speicher my_speicher;
	private Prozess[] prozesse;

	public Vaterprozess() {
		my_speicher = new Speicher();
		prozesse = new Prozess[5];
		for (int i = 0; i < prozesse.length; i++) {
			prozesse[i] = new Prozess(i, my_speicher);
			prozesse[i].start();
		}
	}

	public static void main(String[] args) {
		new Vaterprozess();
	}
}
