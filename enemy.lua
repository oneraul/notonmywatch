Enemy = class("Enemy")

function Enemy:init(window, name, input, output)
	self.x = math.random(love.graphics.getWidth())
	self.y = 10
	self.path = generatePath(self.x)
	self.currentNode = 1
end

function Enemy:draw()
	love.graphics.circle("line", self.x, self.y, 15)
	love.graphics.line(self.x, self.y, pathNodes[self.path[self.currentNode]].x, pathNodes[self.path[self.currentNode]].y)
end

function Enemy:followPath(dt)
	local node = pathNodes[self.path[self.currentNode]]
	local dirX, dirY = node.x-self.x, node.y-self.y
	local l = math.sqrt(dirX*dirX+dirY*dirY)
	dirX, dirY = dirX/l, dirY/l
	
	if l <= 5 then
		self.currentNode = self.currentNode+1
		if self.currentNode > #self.path then
			return true
		end
	end
	
	local v = 50
	self.x, self.y = self.x+dirX*v*dt, self.y+dirY*v*dt
	return false
end