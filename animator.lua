Animator = class("Animator", {
	timer = 0,
	frameDuration = 0.15,
	currentFrame = 1
})

function Animator:init(frames, resetFunction) 
	self.frames = frames
	self.onFinish = resetFunction or self.reset
end

function Animator:update(dt)
	self.timer = self.timer + dt
	if self.timer >= self.frameDuration then
		self.timer = self.timer - self.frameDuration
		self.currentFrame = self.currentFrame + 1
		if self.currentFrame > #self.frames then
			self:onFinish()
		end
	end
end

function Animator:reset()
	self.currentFrame = 1
end

function Animator:getCurrentFrame()
	return self.frames[self.currentFrame]
end

function Animator:getCurrentFrameNumber()
	return self.currentFrame
end