#ifndef HEADER_HPP
#define HEADER_HPP

class Player {

public:
	static const char C = 'O';

private:
	int x;
	int y;
	int pts;

public:
	Player();
	~Player() = default;
	int getX();
	int getY();
	int getPts();
	void incrementPts();
	void up();
	void right();
	void down();
	void left();
};



class Coin {

public:
	static const char C = '$';

private:
	int x;
	int y;

public:

	Coin();
	~Coin() = default;
	int getX();
	int getY();
	bool isCollidingPlayer(Player player);
	void rollPos();
	void process(Player& player);
};



class Enemy {

public:
	static const char C = 'X';

private:
	int x;
	int y;
	int speed;
	int maxSpeed;

public:
	Enemy();
	~Enemy() = default;
	int getX();
	int getY();
	void setMaxSpeed(int s);
	void move(Player player);
	void up();
	void right();
	void down();
	void left();
	void process(Player player);
	bool isCollidingPlayer(Player player);
};




class Board {

public:
	static const int WIDTH = 40;
	static const int HEIGHT = 20;
	static const char BG_CHAR = ' ';
	static const char WALL_CHAR = '0';

private:
	char lines[HEIGHT][WIDTH];
	Player player;
	Enemy enemy;
	Coin coin;

public:
	Board();
	~Board() = default;
	Player& getPlayer();
	void update();
	void print();
	bool isLoose();
};

#endif