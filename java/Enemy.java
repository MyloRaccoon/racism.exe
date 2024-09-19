import java.lang.Math;

public class Enemy extends BoardObject {

	private int maxSpeed;
	private int speed;

	public Enemy(int x, int y, int speed) {
		super(x, y, "X");
		this.maxSpeed = speed;
		this.speed = speed;
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

	public void move(Player player) {
		if (Math.abs(player.x()-x) < Math.abs(player.y()-y)) {
			if (player.y() < y)
				up();
			else
				down();
		} else {
			if (player.x() > x)
				right();
			else
				left();
		}
	}

	public boolean isCollidingPlayer(Player player) {
		if (Math.abs(player.x()-x)<=1 && Math.abs(player.y()-y)<=1)
			return true;
		else 
			return false;
	}

	public boolean process(Player player) {
		speed -= 1;
		if (speed == 0) {
			speed = maxSpeed;
			move(player);
		}
		return isCollidingPlayer(player);	
	}
}