function love.load()
	class = require '30log'
	require 'pathstuff'
	require 'animator'
	require 'enemy'
	require 'aabb'
	require 'stage'
	player = require 'player'

	enemies = {}
	background_texture = love.graphics.newImage("images/bg.png")
end

function love.update(dt)
	require("lurker").update()
	
	for i = #enemies, 1, -1 do
		if enemies[i]:update(dt) then table.remove(enemies, i) end
	end
	
	player:update(dt)
end

function love.draw()
	love.graphics.draw(background_texture)
	for i, enemy in ipairs(enemies) do enemy:draw() end
	player:draw()
	
	if debug_draw then debugDraw() end
end

function love.keypressed(key, scancode, isrepeat)
	if key == "p" then
		table.insert(enemies, Enemy())
	end
end

------------------

debug_draw = true
local debug_paths = true
local debug_enemies = true
local debug_stage = true

function debugDraw()
	if debug_paths then
		for i, node in ipairs(pathNodes) do
			love.graphics.circle("line", node.x, node.y, 5)
			love.graphics.print(i, node.x, node.y)
			for j, other in ipairs(node.connections) do
				love.graphics.line(node.x, node.y, pathNodes[other].x, pathNodes[other].y)
			end
		end
	end
	
	if debug_enemies then
		for i, enemy in ipairs(enemies) do
			love.graphics.circle("fill", enemy.x, enemy.y, 3)
		end
		love.graphics.circle("fill", player.x, player.y, 3)
	end
	
	if debug_stage then
		for i, aabb in ipairs(stage) do
			love.graphics.rectangle("line", aabb.x, aabb.y, aabb.w, aabb.h)
		end
	end
end