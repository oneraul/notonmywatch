AABB = class("AABB", {
	x = 0, y = 0, w = 0, h = 0
})

function AABB:init(x, y, w, h)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
end

function AABB:contains(x, y)
	if x <= self.x or x >= self.x+self.w
	or y <= self.y or y >= self.y+self.h then
		return false
	else
		return true
	end
end