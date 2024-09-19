import java.util.Scanner;

public class Player extends BoardObject {

	private int score;

	public Player(int x, int y) {
		super(x, y, "O");
	}

	public int score() {
		return score;
	}

	public void incrementS() {
		score += 1;
	}

	public void up() {
		if (y>1)
			y -= 1;
	}

	public void down() {
		if (y<Board.HEIGHT-2)
			y += 1;
	}

	public void right() {
		if (x<Board.WIDTH-2)
			x += 1;
	}

	public void left() {
		if (x>1)
			x -= 1;
	}

	public boolean move(char c) {
		switch(c) {
			case 'z':
				up();
				break;
			case 'q':
				left();
				break;
			case 's':
				down();
				break;
			case 'd':
				right();
				break;
			case 'e':
				return false;
		}
		return true;
	}

	public char askPlayer() {
		Scanner scanner = new Scanner(System.in);
		char answer;
		try {
			answer = scanner.next().charAt(0);
		} catch (Exception e) {
			answer = ' ';
		}
		return answer;
	}
}