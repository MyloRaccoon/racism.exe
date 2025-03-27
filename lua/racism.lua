local height = 10
local width = 30

local empty_char = "0"
local wall_char = "0"
local player_char = "P"
local enemy_char = "E"
local coin_char = "C"

local init_player_x = 1
local init_player_y = 1
local player_speed = 1
local init_enemy_x = height - 1
local init_enemy_y = width - 1
local enemy_speed = 1

Entity = {
	x = 0,
	y = 0,
	speed = 1,
}

function Entity:create(o)
	o.parent = self
	return o
end

function Entity:up()
	self.y = self.y - self.speed
end

function Entity:down()
	self.y = self.y + self.speed
end

function Entity:left()
	self.x = self.x - self.speed
end

function Entity:right()
	self.x = self.x + self.speed
end

local player = Entity:create{ x = init_player_x, y = init_player_y, speed = player_speed }


local enemy = Entity:create{ x = init_enemy_x, y = init_enemy_y, speed = enemy_speed }

function enemy:move()
	local dist_x = math.abs(player.x - self.x)
	local dist_y = math.abs(player.y - self.y)
	if dist_x >= dist_y then
		if self.x > player.x then
			-- find a way to go up, need to look up how tf you inherit in this language
		else
			-- find a way to go up, need to look up how tf you inherit in this language
		end
	else
		if self.y > player.y then
			-- find a way to go up, need to look up how tf you inherit in this language
		else
			-- find a way to go up, need to look up how tf you inherit in this language
		end
	end
end


local coin = Entity:create{ x = 0, y = 0 }

function coin:tp()
	self.x = math.random(1, width-1)
	self.y = math.random(1, height-1)
end



local function print_board()
	for y = 0, height do
		local line = ""
		for x = 0, width do
			if x == 0 or y == 0 or x == height or y == width then
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

coin:tp()
print_board()
enemy:move()
coin:tp()
print_board()