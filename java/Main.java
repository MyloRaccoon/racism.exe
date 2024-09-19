import java.util.Random;

public class Main {

	public static int getRandomCoord(int max) {
		Random r = new Random();
		return r.nextInt((max - 1) + 1) + 1;
	}

	public static void main(String[] args) {
		Board board = new Board();
		board.process();
	}

}