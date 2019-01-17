import java.awt.image.*;
import java.io.*;
import javax.imageio.*;
import java.util.Random;
import java.util.Arrays;

/**
 * Die Klasse Bildbearbeitung laedt eine Bilddatei und fuehrt 
 * abhaengig von gewaehlten Optionen eine Reihe von 
 * Bildmanipulationen aus. 
 */
public class Bildbearbeitung {
	private int[][] pixels;
	
	/**
	 * Konstruktor fuer die Klasse Bildbearbeitung, die eine Bilddatei einliest
	 * und das zweidimensionale Pixel-Array pixels befuellt.
	 * @param file Einzulesende Bilddatei
	 */
	private Bildbearbeitung(String file) {
		try {
			BufferedImage img = ImageIO.read(new File(file));
			pixels = new int[img.getWidth()][img.getHeight()];
			for(int i = 0; i < dimX(); i++)
				for(int j = 0; j < dimY(); j++)
					pixels[i][j] = img.getRGB(i, j);
		} catch (IOException e) {}
	}	
	
	private int dimX(){
		return pixels.length;
	}
	
	private int dimY(){
		if(dimX() == 0)
			return 0;
		return pixels[0].length;
	}

	/** 
	 * Diese Funktion schreibt den Inhalt des Pixelarrays in die
	 * Datei 'ausgabe.png'. Falls diese Datei nicht vorhanden ist, 
	 * wird sie angelegt. Eine vorhandene Datei wird eventuell ueberschrieben!
	 */
	private void save(String option){
		BufferedImage img = new BufferedImage(dimX(), dimY(), 3);
		for(int i = 0; i < dimX(); i++)
			for(int j = 0; j < dimY(); j++)
				img.setRGB(i, j, pixels[i][j]);
		
		try {
			File outputfile = new File("ausgabe-" + option + ".png");
			ImageIO.write(img, "png", outputfile);
		} catch (Exception e) {}
	}

	/**
	 * Diese Funktion nimmt einen ARGB-Wert und wandelt ihn in 
	 * ein vierelementiges Array um, dass die einzelnen Bytes 
	 * als int-Komponenten enthaelt. 
	 * @param ARGB Integre Darstellung eines Pixels mit 4 Byte
	 * Information: alpha-rot-gruen-blau
	 * @return 4-elementiges Array [alpha, red, green, blue]
	 */
	private int[] getColors(int ARGB) {
		// TODO nur das hier?
		int alpha = (ARGB >> 24) & 255;
		int red = (ARGB >> 16) & 255;
		int green = (ARGB >> 8) & 255;
		int blue = ARGB & 255;
		int[] array = {alpha,red,green,blue};
		return array;
	}
	
	/**
	 * Ein vierelementiges Array mit kleinen (< 1 byte) int-Werten 
	 * wird zu einem einzigen 4 byte Integer zusammengesetzt. 
	 * @param array 4-elementiges Array
	 * @return Eine Integerdarstellung einer Farbe in ARGB-Format.
	 */
	private int setColors(int[] array) {
		int alpha = array[0] << 24;
		int red = array[1] << 16;
		int green = array[2] << 8;
		int blue = array[3];
		return alpha | red | green | blue;
	}

	/**
	 * Das Bild wird hier rotiert und n*90 Grad.
	 * @param n Anzahl der Vierteldrehungen.
	 */
	private void rotate(int n) {
		if (n<=0){
			return;
		}
		int[][] pixelsTemp = new int[dimY()][dimX()];
		for(int j = 0; j < dimY(); j++){
			for(int i = 0; i < dimX(); i++) {
				pixelsTemp[j][dimX()-1-i] = pixels[i][j];			}
			}
		}
		pixels = pixelsTemp;
		rotate(n-1);
	}
	
	/**
	 * Die Farben werden invertiert: Farbe = (255-Farbe)
	 */
	private void invert() {
		// TODO
		for(int i = 0; i < dimX(); i++) {
			for(int j = 0; j < dimY(); j++){
				int[] array = getColors(pixels[i][j]);
				//array[0] = (byte)(255-array[0]);
				array[1] = (255-array[1]);
				array[2] = (255-array[2]);
				array[3] = (255-array[3]);
				pixels[i][j] = setColors(array);
			}
		}	
	}
	
	/**
	 * Das Bild wird vertikal gespiegelt
	 */
	private void mirror() {
		// TODO
		for(int i = 0; i < dimX()/2; i++) {
			int[] col = pixels[i];
			pixels[i] = pixels[dimX()-i-1];
			pixels[dimX()-i-1] = col;
		}
	}

	/**
	 * Hilfsfunktion zum Zugriff, die Randpunkten gueltige 
	 * nullwertige Nachbarn zuweist.
	 */	
	private int getPixel(int i, int j) {
		if(i < 0 || j < 0 || i >= dimX() || j >= dimY())
			return 0;
		return pixels[i][j];
	}
	
	/**
	 * Diese Funktion betrachtet zu jedem Pixel seine Nachbarschaft, 
	 * summiert gewichtet diese Menge auf und skaliert sie
	 * @param filter 3x3 Umgebungsgewichte
	 */	
	private void meanFilter(double[] filter, double factor) {
		int[][] pixelsTemp = new int[dimX()][dimY()];
		for(int i = 0; i < dimX(); i++) {
			for(int j = 0; j < dimY(); j++){
				double[] sum = {0.,0.,0.,0.};
				int[] sumInt = new int[4];
				for(int col = 0; col < 4; col++){
					sum[col] += filter[0]*getColors(getPixel(i-1,j-1))[col];
					sum[col] += filter[1]*getColors(getPixel(i-1,j))[col];
					sum[col] += filter[2]*getColors(getPixel(i-1,j+1))[col];
					sum[col] += filter[3]*getColors(getPixel(i,j-1))[col];
					sum[col] += filter[4]*getColors(getPixel(i,j))[col];
					sum[col] += filter[5]*getColors(getPixel(i,j+1))[col];
					sum[col] += filter[6]*getColors(getPixel(i+1,j-1))[col];
					sum[col] += filter[7]*getColors(getPixel(i+1,j))[col];
					sum[col] += filter[8]*getColors(getPixel(i+1,j+1))[col];
					sumInt[col] = (int)(sum[col]*factor);
				}
				pixelsTemp[i][j] = setColors(sumInt);
			}
		}
		pixels = pixelsTemp;
	}
	
	
	/** 
	 * Gaussfilter
	 */	
	private void gauss(){
		double[] filter = {1,2,1,2,4,2,1,2,1};
		meanFilter(filter, 1.0/16.0);
	}
	
	/** 
	 * Blurfilter/ Lowpassfilter
	 */
	private void lpf(){
		double[] filter = {1,1,1,1,1,1,1,1,1};
		meanFilter(filter,1.0/9.0);
	}
	
	/** 
	 * Hochpassfilter 1
	 */
	private void hpf1(){
		double[] filter = {0,-1,0,-1,4,-1,0,-1,0};
		meanFilter(filter,1.0);
	}
	
	/** 
	 * Hochpassfilter 2
	 */
	private void hpf2(){
		double[] filter = {-1,-1,-1,-1,9,-1,-1,-1,-1};
		meanFilter(filter,1.0);
	}
	
	/** 
	 * Medianfilter
	 */	
	private void medianFilter(){
		//TODO
		int[][] pixelsTemp = new int[dimX()][dimY()];
		for(int i = 0; i < dimX(); i++) {
			for(int j = 0; j < dimY(); j++){
				int[] values = new int[4];
				for(int col = 0; col < 4; col++){
					int[] arrayMedian = new int[5];
					arrayMedian[0] = getColors(getPixel(i,j))[col];
					arrayMedian[1] = getColors(getPixel(i-1,j))[col];
					arrayMedian[2] = getColors(getPixel(i+1,j))[col];
					arrayMedian[3] = getColors(getPixel(i,j-1))[col];
					arrayMedian[4] = getColors(getPixel(i,j+1))[col];
					Arrays.sort(arrayMedian);
					values[col] = arrayMedian[2];
				}
				pixelsTemp[i][j] = setColors(values);
			}
		}
		pixels = pixelsTemp;
	}

	/** 
	 * Fuegt auf n Pixeln Rauschen hinzu.
	 */	
	private void jitter(int n) {
		Random random = new Random();
		for(int i = 0; i < n; i++) {
			int x = random.nextInt(dimX());
			int y = random.nextInt(dimY());
			int[] colors = getColors(getPixel(x,y));
			colors[1] = random.nextInt(256);
			colors[2] = random.nextInt(256);
			colors[3] = random.nextInt(256);
			pixels[x][y] = setColors(colors);
		}
	}
 
    public static void main(String[] args) {

		int argCount = args.length;

		if(argCount == 0) {
			System.out.println("Verwendung: java Bildbearbeitung <FILE> [-options]");
			System.out.println("wobei options Folgendes umfasst:");
			System.out.println("\t -rot90 90 Grad rotieren");
			System.out.println("\t -rot180 180 Grad rotieren");
			System.out.println("\t -rot270 270 Grad rotieren");
			System.out.println("\t -i Farben invertieren");
			System.out.println("\t -m Horizontal spiegeln");
			System.out.println("\t -lpf Verwaschen");
			System.out.println("\t -median Median-Filter");
			System.out.println("\t -gauss Gauss-Filter");
			System.out.println("\t -hpf1 Hochpassfilter1");
			System.out.println("\t -hpf2 Hochpassfilter2");
			System.out.println("\t -jitter Verrauscht das Bild");
			return;
		}

		// load image as specified in first argument args[0]
		Bildbearbeitung bild = new Bildbearbeitung(args[0]);
		
		bild.save("raw");
		for(int i = 1; i < argCount; i++) {
			String option = args[i];
			System.out.println("Processing: " + option);
			if(option.equals("-rot90"))
				bild.rotate(1);
			else if(option.equals("-rot180"))
				bild.rotate(2);
			else if(option.equals("-rot270"))
				bild.rotate(3);
			else if(option.equals("-i"))
				bild.invert();
			else if(option.equals("-m"))
				bild.mirror();	
			else if(option.equals("-gauss"))
				bild.gauss();
			else if(option.equals("-median"))
				bild.medianFilter();
			else if(option.equals("-lpf"))
				bild.lpf();
			else if(option.equals("-jitter"))
				bild.jitter(50000);
			else if(option.equals("-hpf1"))
				bild.hpf1();
			else if(option.equals("-hpf2"))
				bild.hpf2();
		
			bild.save(""+i);
		}

		bild.save("done");
	}
}
