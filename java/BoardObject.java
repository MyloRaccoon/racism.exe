public abstract class BoardObject {
	
	protected String CHAR;
	protected int x;
	protected int y;

	public BoardObject(int x, int y, String CHAR) {
		this.x = x;
		this.y = y;
		this.CHAR = CHAR;
	}

	public String CHAR() {
		return CHAR;
	}
	
	public int x() {
		return x;
	}

	public int y() {
		return y;
	}
}