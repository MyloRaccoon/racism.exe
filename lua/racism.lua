local height = 10
local width = 30

local empty_char = "□"
local wall_char = "█"
local player_char = "☻"
local enemy_char = "☺"
local coin_char = "$"

local init_player_x = 1
local init_player_y = 1
local player_speed = 1
local init_enemy_x = width - 1
local init_enemy_y = height - 1
local enemy_speed = 1

local score = 0

local player = { x = init_player_x, y = init_player_y, speed = player_speed }

function player:up()
	if self.y > 1 then
		self.y = self.y - self.speed
	end
end

function player:down()
	if self.y < height-1 then
		self.y = self.y + self.speed
	end
end

function player:right()
	if self.x < width-1 then
		self.x = self.x + self.speed
	end
end

function player:left()
	if self.x > 1 then
		self.x = self.x - self.speed
	end
end

function player:move(char)
	if char == 'z' then
		self:up()
	elseif char == 's' then
		self:down()
	elseif char == 'd' then
		self:right()
	elseif char == 'q' then
		self:left()
	end
end


local enemy = { x = init_enemy_x, y = init_enemy_y, speed = enemy_speed, can_move = true }

function enemy:move()
	local dist_x = math.abs(player.x - self.x)
	local dist_y = math.abs(player.y - self.y)
	if dist_x >= dist_y then
		if self.x > player.x then
			if self.x > 1 then
				self.x = self.x - self.speed
			end
		else
			if self.x < width-1 then
				self.x = self.x + self.speed
			end
		end
	else
		if self.y > player.y then
			if self.y > 1 then
				self.y = self.y - self.speed
			end
		else
			if self.y < height-1 then
				self.y = self.y + self.speed
			end
		end
	end
end

function enemy:check()
	local dist_x = math.abs(self.x - player.x)
	local dist_y = math.abs(self.y - player.y)

	return dist_x <= 1 and dist_y <= 1
end


local coin = { x = 0, y = 0 }

function coin:tp()
	self.x = math.random(1, width-1)
	self.y = math.random(1, height-1)
end

function coin:check()
	if self.x == player.x and self.y == player.y then
		score = score + 1
		self:tp()
	end
end


local function print_board()
	for y = 0, height do
		local line = ""
		for x = 0, width do
			if x == 0 or y == 0 or x == width or y == height then
				line = line .. wall_char
			elseif x == player.x and y == player.y then
				line = line .. player_char
			elseif x == enemy.x and y == enemy.y then
				line = line .. enemy_char
			elseif x == coin.x and y == coin.y then
				line = line .. coin_char
			else
				line = line .. empty_char
			end
		end
		print(line)
	end
end

local function is_move_command( move )
	return move == "z" or move == "q" or move == "s" or move == "d"
end

local playing = true

coin:tp()

while playing do
	print_board()

	if enemy:check() then
		print(string.format("You ded with %d$", score))
		playing = false
	end

	print(string.format("score = %d$", score))
	print("Type a command: ")
	local command = io.read(1)

	if is_move_command(command) then
		player:move(command)

		enemy.can_move = not enemy.can_move
		if enemy.can_move then
			enemy:move()
		end

	elseif command == 'e' then
		playing = false
	elseif command == 'h' then
		print("(z,q,s,d) to move, e (or ctrl-c) to exit")
	end

	coin:check()
end