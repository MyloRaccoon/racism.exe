#include "header.hpp"
#include <iostream>
#include <locale>
#include <cstdio>
#include <random>

using namespace std;

int randint(int min, int max) {
	int range = max - min + 1;
	int num = rand() % range + min;
	return num;
}

Player::Player() {
	x=1;
	y=1;
	pts=0;
}

int Player::getX() {
	return x;
}

int Player::getY() {
	return y;
}

int Player::getPts() {
	return pts;
}

void Player::incrementPts() {
	pts++;
}

void Player::up() {
	if (y > 1)
		y -= 1;
}

void Player::down() {
	if (y < Board::HEIGHT-2)
		y += 1;
}

void Player::right() {
	if (x < Board::WIDTH-2)
		x += 1;
}

void Player::left() {
	if (x > 1)
		x -= 1;
}



Coin::Coin() {
	x = 10;
	y = 5;
}

int Coin::getX() {
	return x;
}

int Coin::getY() {
	return y;
}

bool Coin::isCollidingPlayer(Player player) {
	return (x == player.getX() && player.getY() == y);
}

void Coin::rollPos() {
	x = randint(1, Board::WIDTH-2);
	y = randint(1, Board::HEIGHT-2);
}

void Coin::process(Player& player) {
	if (isCollidingPlayer(player)) {
		player.incrementPts();
		rollPos();
	}
}




Enemy::Enemy() {
	x = Board::WIDTH-2;
	y = Board::HEIGHT-2;
	maxSpeed = 2;
	speed = maxSpeed;
}

int Enemy::getX(){
	return x;
}

int Enemy::getY(){
	return y;
}

void Enemy::setMaxSpeed(int s) {
	maxSpeed = s;
}

void Enemy::move(Player player) {
	if (abs(player.getX()-x) < abs(player.getY()-y))
		if (player.getY() < y)
			up();
		else
			down();
	else 
		if (player.getX() > x)
			right();
		else
			left();
}

void Enemy::up() {
	if (y > 1)
		y -= 1;
}

void Enemy::down() {
	if (y < Board::HEIGHT-2)
		y += 1;
}

void Enemy::right() {
	if (x < Board::WIDTH-2)
		x += 1;
}

void Enemy::left() {
	if (x > 1)
		x -= 1;
}

void Enemy::process(Player player) {
	speed -= 1;
	if (speed == 0) {
		speed = maxSpeed;
		move(player);
	}
}

bool Enemy::isCollidingPlayer(Player player) {
	return (abs(x-player.getX())<=1 && abs(y-player.getY())<=1);
}



Board::Board() {
	player = Player();
	enemy = Enemy();
	coin = Coin();
	update();
}

Player& Board::getPlayer() {
	return player;
}

bool Board::isLoose() {
	return enemy.isCollidingPlayer(player);
}

void Board::update() {
	enemy.process(player);
	coin.process(player);
	for (int i=0; i<HEIGHT; i++) {
		for (int j=0; j<WIDTH; j++) {
			if (i==0 || j == 0 || i == HEIGHT-1 || j == WIDTH-1)
				lines[i][j] = WALL_CHAR;
			else
				lines[i][j] = BG_CHAR;
		}
		lines[player.getY()][player.getX()] = Player::C;
		lines[enemy.getY()][enemy.getX()] = Enemy::C;
		lines[coin.getY()][coin.getX()] = Coin::C;
	}
}

void Board::print() {
	for (int i=0; i<HEIGHT; i++) {
		for (int j=0; j<WIDTH; j++)
			cout<<lines[i][j];
		cout<<endl;
	}
	cout<<"PTS : "<<player.getPts()<<"$"<<endl;
}