public class Coin extends BoardObject {

	public Coin() {
		super(Main.getRandomCoord(Board.WIDTH-2), Main.getRandomCoord(Board.HEIGHT-2), "$");
	}

	public void randomizeCoord() {
		x = Main.getRandomCoord(Board.WIDTH-2);
		y = Main.getRandomCoord(Board.HEIGHT-2);
	}

	public boolean isCollidingPlayer(Player player) {
		if (player.x == x && player.y == y)
			return true;
		else 
			return false;
	}

	public void process(Player player) {
		if (isCollidingPlayer(player)) {
			player.incrementS();
			randomizeCoord();
		}
	}
}