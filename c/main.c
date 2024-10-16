#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

const int WIDTH = 30;
const int HEIGHT = 15;
const char p_char = 'O';
const char c_char = '$';
const char e_char = 'X';
const int e_max_speed = 3;

int randint(int min, int max) {
  int range = max - min + 1;
  int num = rand() % range + min;
  return num;
}

void updateBoard(char **board, int *player, int *coin, int *enemy) {
  for (int i = 0; i < HEIGHT; i++) {
    for (int j = 0; j < WIDTH; j++) {
      if (i == 0 || i == HEIGHT - 1 || j == 0 || j == WIDTH - 1)
        board[i][j] = '0';
      else
        board[i][j] = ' ';
    }
  }
  board[player[1]][player[0]] = p_char;
  board[coin[1]][coin[0]] = c_char;
  board[enemy[1]][enemy[0]] = e_char;
}

void writeBoard(char **board, int score) {
  for (int i = 0; i < HEIGHT; i++) {
    for (int j = 0; j < WIDTH; j++) {
      write(1, &board[i][j], 1);
    }
    write(1, "\n", 1);
  }
  printf("Score : %d$\n", score);
}

char askPlayer() {
  char res;
  scanf("%c", &res);
  return res;
}

void playerUp(int *player) {
  if (player[1] > 1) {
    player[1] -= 1;
  }
}

void playerDown(int *player) {
  if (player[1] < HEIGHT - 2) {
    player[1] += 1;
  }
}

void playerLeft(int *player) {
  if (player[0] > 1) {
    player[0] -= 1;
  }
}

void playerRight(int *player) {
  if (player[0] < WIDTH - 2) {
    player[0] += 1;
  }
}

void movePlayer(int *player, char dir) {
  switch (dir) {
  case 'z':
    playerUp(player);
    break;
  case 'q':
    playerLeft(player);
    break;
  case 's':
    playerDown(player);
    break;
  case 'd':
    playerRight(player);
    break;
  }
}

void randCoin(int *coin) {
  coin[0] = randint(1, WIDTH - 2);
  coin[1] = randint(1, HEIGHT - 2);
}

int colliding(int *object1, int *object2) {
  return (object1[0] == object2[0] && object1[1] == object2[1]);
}

int playerCollingEnemy(int *player, int *enemy) {
  return (abs(enemy[0] - player[0]) <= 1 && abs(enemy[1] - player[1]) <= 1);
}

void moveEnemy(int *player, int *enemy) {
  if (abs(player[0] - enemy[0]) < abs(player[1] - enemy[1]))
    if (player[1] < enemy[1])
      playerUp(enemy);
    else
      playerDown(enemy);
  else if (player[0] > enemy[0])
    playerRight(enemy);
  else
    playerLeft(enemy);
}

int process(int *coin, int *enemy, int *e_speed, int *player, int *score) {
  if (colliding(coin, player)) {
    (*score)++;
    randCoin(coin);
  }
  (*e_speed)--;

  if (*e_speed <= 0) {
    (*e_speed) = e_max_speed;
    moveEnemy(player, enemy);
  }

  return playerCollingEnemy(player, enemy);
}

int main() {

  srand(time(NULL));

  char **board = (char **)malloc(HEIGHT * sizeof(char *));
  for (int i = 0; i < HEIGHT; i++) {
    board[i] = (char *)malloc(WIDTH * sizeof(char));
  }

  int player[2];
  player[0] = 1;
  player[1] = 1;

  int enemy[2];
  enemy[0] = WIDTH - 2;
  enemy[1] = HEIGHT - 2;

  int e_speed = 2;

  int score = 0;

  int coin[2];
  randCoin(coin);

  int playing = 1;

  while (playing) {
    system("clear");
    updateBoard(board, player, coin, enemy);
    writeBoard(board, score);
    char res = askPlayer();
    playing = (res != 'e');
    if (playing) {
      movePlayer(player, res);
      playing = !process(coin, enemy, &e_speed, player, &score);
    }
  }
  system("clear");
  printf("Your score : %d\n", score);
  return 0;
}