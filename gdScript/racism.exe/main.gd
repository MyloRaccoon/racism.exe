extends Label

@onready var pts = $pts

var BOARD_WIDTH : int = 50
var BOARD_HEIGHT : int = 20
var ENEMY_SPEED : int = 2

var board : Board

var playing : bool = true

class Board:
	
	var board : Array[Array]
	var player : Player
	var coin : Coin
	var enemy : Enemy
	var width : int
	var height : int
	
	func _init(w : int, h : int, espeed : int) -> void:
		self.player = Player.new(1, 1)
		self.width = w
		self.height = h
		self.coin = Coin.new(self.width, self.height)
		self.enemy = Enemy.new(width-1, height-1, espeed)
		update_board()
	
	func update_board():
		board = []
		for i in range(height+1):
			var l = []
			for j in range(width+1):
				if j == player.x and i == player.y:
					l.append(player.c)
				elif j == coin.x and i == coin.y:
					l.append(coin.c)
				elif j == enemy.x and i == enemy.y:
					l.append(enemy.c)
				elif i in [0, height] or j in [0, width]:
					l.append("█")
				else:
					l.append("□")
			board.append(l)
	
	func _to_string() -> String:
		var string = ""
		for line in board:
			for c in line:
				string += c
			string += "\n"
		return string

class BoardObject:
	
	var x : int
	var y : int
	var c : String
	
	func _init(ox : int, oy : int, character : String):
		self.x = ox
		self.y = oy
		self.c = character
	
	func _to_string() -> String:
		return c

class Coin extends BoardObject:
	
	func _init(width, height) -> void:
		super(5, 5, '₩')
		randomize_pos(width, height)
	
	func process(board : Board):
		if collidingPlayer(board.player):
			board.player.pts += 1
			randomize_pos(board.width, board.height)
	
	func collidingPlayer(player : Player):
		if player.x == x and player.y == y:
			return true
		else:
			return false
	
	func randomize_pos(width, height):
		x = randi_range(1, width)
		y = randi_range(1, height)

class Entity extends BoardObject:
	
	func _init(ex : int, ey : int, character : String):
		super(ex, ey, character)
	
	func go_up():
		if self.y > 1:
			self.y -= 1
	
	func go_down(board_height : int):
		if self.y < board_height-1:
			self.y += 1
	
	func go_left():
		if self.x > 1:
			self.x -= 1
	
	func go_right(board_width : int):
		if self.x < board_width-1:
			self.x += 1

class Player extends Entity:
	
	var pts : int = 0
	
	func _init(px : int, py : int) -> void:
		super(px, py, '☺')

class Enemy extends Entity:
	
	var speed : int
	var max_speed : int
	
	func _init(ex, ey, mspeed) -> void:
		super(ex, ey, '☻')
		self.max_speed = mspeed
		self.speed = max_speed
	
	func process(board : Board) -> bool:
		var boolean : bool = false
		speed -= 1
		if speed <= 0:
			speed = max_speed
			move(board)
			boolean = collidingPlayer(board.player)
		return boolean
	
	func move(board : Board):
		if abs(board.player.x-x) < abs(board.player.y-y):
			if board.player.y < y:
				go_up()
			else:
				go_down(board.height)
		else:
			if board.player.x > x:
				go_right(board.width)
			else:
				go_left()
	
	func collidingPlayer(player : Player) -> bool:
		if abs(player.x-x)<=1 && abs(player.y-y)<=1:
			return true
		else:
			return false


func turn():
	board.coin.process(board)
	if board.enemy.process(board):
		text = "you looose with : " + str(board.player.pts) + "$"
		playing = false
	else:
		board.update_board()
		text = board.to_string()
		pts.text = "points : " + str(board.player.pts) + "$"

func _ready() -> void:
	board = Board.new(BOARD_WIDTH, BOARD_HEIGHT, ENEMY_SPEED)
	turn()

func _input(event: InputEvent) -> void:
	if playing:
		if event.is_action_pressed("ui_up"):
			board.player.go_up()
			turn()
		elif event.is_action_pressed("ui_down"):
			board.player.go_down(BOARD_HEIGHT)
			turn()
		elif event.is_action_pressed("ui_right"):
			board.player.go_right(BOARD_WIDTH)
			turn()
		elif event.is_action_pressed("ui_left"):
			board.player.go_left()
			turn()
