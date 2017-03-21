local Player = {}

local textures = {
	body = {
		front = {
			love.graphics.newImage("images/humanos/tendero/moving/front/front1.png"),
			love.graphics.newImage("images/humanos/tendero/moving/front/front2.png")
		}, 
		back = {
			love.graphics.newImage("images/humanos/tendero/moving/back/back1.png"),
			love.graphics.newImage("images/humanos/tendero/moving/back/back2.png")
		}
	},
	usingTool = {
		hammer = {
			love.graphics.newImage("images/humanos/tendero/tool/hammer/hammer1.png"),
			love.graphics.newImage("images/humanos/tendero/tool/hammer/hammer2.png")
		},
		nailgun = {
			love.graphics.newImage("images/humanos/tendero/tool/nail/nail1.png"),
			love.graphics.newImage("images/humanos/tendero/tool/nail/nail2.png")
		}
	},
	face = {
		normal = {
			love.graphics.newImage("images/humanos/tendero/face/normal_right.png"),
			love.graphics.newImage("images/humanos/tendero/face/normal_left.png")
		},
		angry = {
			love.graphics.newImage("images/humanos/tendero/face/angry_right.png"),
			love.graphics.newImage("images/humanos/tendero/face/angry_left.png")
		}
	}
}

Player.x, Player.y = 540, 252
local v = 200
local body_width, body_height = textures.body.front[1]:getDimensions()

local bodyAnimator = Animator(textures.body.front)
local lookingDirectionX = 1 -- 1 right, 2 left
local lookingDirectionY = "front"
local faceState = "normal"
local moving = false

function Player:draw()
	love.graphics.draw(textures.body[lookingDirectionY][bodyAnimator:getCurrentFrameNumber()], self.x-70, self.y-127)
	if lookingDirectionY == "front" then love.graphics.draw(textures.face[faceState][lookingDirectionX], self.x-70, self.y-127) end
end

function Player:update(dt)
	self:movementAndCollision(dt)
	if moving then bodyAnimator:update(dt) end
end

function Player:movementAndCollision(dt)
	local dx, dy = 0, 0
	if love.keyboard.isDown("w", "up") then dy = dy - 1 end
	if love.keyboard.isDown("a", "left") then dx = dx - 1 end
	if love.keyboard.isDown("s", "down") then dy = dy + 1 end
	if love.keyboard.isDown("d", "right") then dx = dx + 1 end
	
	if dy ~= 0 then
		self.y = self.y + dy * v * dt
		for i, aabb in ipairs(stage) do
			if aabb:contains(self.x, self.y) then
				if dy < 0 then 
					self.y = aabb.y + aabb.h
				else 
					self.y = aabb.y 
				end
				break
			end
		end
		
		lookingDirectionY = dy > 0 and "front" or "back"
	end
	
	if dx ~= 0 then
		self.x = self.x + dx * v * dt
		for i, aabb in ipairs(stage) do
			if aabb:contains(self.x, self.y) then
				if dx < 0 then 
					self.x = aabb.x + aabb.w
				else 
					self.x = aabb.x
				end
			end
		end
		
		lookingDirectionX = dx > 0 and 1 or 2 -- is he looking left or right?
	end
	
	moving = (dx ~= 0 or dy ~= 0) -- is he moving?
end

return Player