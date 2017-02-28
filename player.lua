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

function Player:draw()
	love.graphics.draw(textures.body.front[1], self.x-70, self.y-127)
end

function Player:movementAndCollision(dt)
	local dx, dy = 0, 0
	if love.keyboard.isDown("w") then dy = dy - 1 end
	if love.keyboard.isDown("a") then dx = dx - 1 end
	if love.keyboard.isDown("s") then dy = dy + 1 end
	if love.keyboard.isDown("d") then dx = dx + 1 end
	
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
	end
end

return Player