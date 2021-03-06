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
		},
		back = {
			love.graphics.newImage("images/humanos/punkata/face/back_right.png"),
			love.graphics.newImage("images/humanos/punkata/face/back_left.png")
		}
	}
}

local body_width, body_height = textures.body.front[1]:getDimensions()

function Enemy:init(window, name, input, output)
	self.x = math.random(300, 954)
	self.y = 200
	self.path = generatePath(self.x)
	self.currentNode = 1
	
	self.bodyAnimator = Animator(textures.body.front)
	self.lookingDirectionX = 1 -- 1 right, 2 left
	self.lookingDirectionY = "front"
	self.faceState = "normal"
	self.moving = true
end

function Enemy:draw()
	love.graphics.draw(textures.body[self.lookingDirectionY][self.bodyAnimator:getCurrentFrameNumber()], self.x-70, self.y-127)
	local faceState = self.lookingDirectionY == "front" and self.faceState or "back"
	love.graphics.draw(textures.face[faceState][self.lookingDirectionX], self.x-70, self.y-127)
end

function Enemy:update(dt)
	if self:followPath(dt) then 
		return true
	else 
		self.bodyAnimator:update(dt) 
		return false
	end
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
		
		self.lookingDirectionX = dirX > 0 and 1 or 2
		self.lookingDirectionY = dirY > 0 and "front" or "back"
	end
	
	return false
end