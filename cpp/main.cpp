#include <iostream>
#include "header.hpp"

using namespace std;

char getDirection() {
	char dir;
	cout<<"choose a direction (zqsd) : ";
	cin>>dir;
	return dir;
}

void changePlayerPos(char dir, Player& player) {
	switch(dir) {
		case 'z':
			player.up();
			break;
		case 'q':
			player.left();
			break;
		case 's':
			player.down();
			break;
		case 'd':
			player.right();
			break;
	}
}

int main() {
	bool playing = true;
	Board board = Board();
	while (playing) {
		system("cls");
		board.print();
		char dir = getDirection();
		if (dir == 'e'){
			system("cls");
			cout<<"quitting...";
			playing = false;
		} else{
			changePlayerPos(dir, board.getPlayer());
			board.update();
			playing =  !board.isLoose();
		}
	}
	system("cls");
	cout<<"u ded. You had "<<board.getPlayer().getPts()<<"$"<<endl;

	return 0;
}

//g++ -std=c++17 -Wall main.cpp sources.cpp -o racism.exe.exe