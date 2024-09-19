import java.lang.StringBuilder;

public class Board {
	
	public final static String BG_CHAR = " ";
	public final static String WALL_CHAR = "█";
	private String[][] board;
	public final static int WIDTH = 30;
	public final static int HEIGHT = 15;
	private Player player;
	private Coin coin;
	private Enemy enemy;

	public Board() {
		this.board = new String[HEIGHT][WIDTH];
		this.player = new Player(1,1);
		this.coin = new Coin();
		this.enemy = new Enemy(WIDTH-2, HEIGHT-2, 2);
		update();
	}

	public Player player() {
		return player;
	}

	public void update() {
		for (int i = 0; i<HEIGHT; i++) {
			for (int j =0; j<WIDTH; j++) {
				if (i==0 || i == Board.HEIGHT-1 || j==0 || j == Board.WIDTH-1)
					board[i][j] = WALL_CHAR;
				else	
					board[i][j] = BG_CHAR;
			}
		}

		board[player.y()][player.x()] = player.CHAR();
		board[enemy.y()][enemy.x()] = enemy.CHAR();
		board[coin.y()][coin.x()] = coin.CHAR();
	}

	public String toString() {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i<HEIGHT; i++) {
			for (int j = 0; j<WIDTH; j++) {
				sb.append(board[i][j]);
			}
			sb.append('\n');
		}
		return sb.toString();
	}

	public void process() {
		Boolean playing = true;
		while (playing) {
			System.out.println(this);
			System.out.println("Score : " + Integer.toString(player.score()));
			playing = player.move(player.askPlayer());
			playing = !enemy.process(player);
			coin.process(player);
			update();
		}
		System.out.println(this);
		System.out.println("u ded with " + Integer.toString(player.score()) + "$");
	}
}