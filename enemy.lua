Enemy = class("Enemy")

local textures = {
	body = {
		front = {
			love.graphics.newImage("images/humanos/punkata/moving/front/front1.png"),
			love.graphics.newImage("images/humanos/punkata/moving/front/front2.png")
		}, 
		back = {
			love.graphics.newImage("images/humanos/punkata/moving/back/back1.png"),
			love.graphics.newImage("images/humanos/punkata/moving/back/back2.png")
		}
	}, 
	face = {
		normal = {
			love.graphics.newImage("images/humanos/punkata/face/normal_right.png"),
			love.graphics.newImage("images/humanos/punkata/face/normal_left.png")
		},
		angry = {
			love.graphics.newImage("images/humanos/punkata/face/angry_right.png"),
			love.graphics.newImage("images/humanos/punkata/face/angry_left.png")
		},
		scared = {
			love.graphics.newImage("images/humanos/punkata/face/scared_right.png"),
			love.graphics.newImage("images/humanos/punkata/face/scared_left.png")
		}
	}
}

local body_width, body_height = textures.body.front[1]:getDimensions()

function Enemy:init(window, name, input, output)
	self.x = math.random(300, 954)
	self.y = 200
	self.path = generatePath(self.x)
	self.currentNode = 1
end

function Enemy:draw()
	love.graphics.draw(textures.body.front[1], self.x-70, self.y-127)
end

function Enemy:followPath(dt)
	local v = 150

	if self.currentNode > #self.path then
		self.y = self.y-v*dt
		if self.y <= 200 then return true end
	else
		local node = pathNodes[self.path[self.currentNode]]
		local dirX, dirY = node.x-self.x, node.y-self.y
		local l = math.sqrt(dirX*dirX+dirY*dirY)
		dirX, dirY = dirX/l, dirY/l
		
		if l <= 5 then self.currentNode = self.currentNode+1 end
		
		self.x, self.y = self.x+dirX*v*dt, self.y+dirY*v*dt
	end
	
	return false
end