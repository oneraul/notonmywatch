function love.load()
	class = require '30log'
	require 'pathstuff'
	require 'enemy'

	enemies = {}
end

function love.update(dt)
	require("lurker").update()
	
	for i = #enemies, 1, -1 do
		if enemies[i]:followPath(dt) then table.remove(enemies, i) end
	end
end

function love.draw()
	for i, enemy in ipairs(enemies) do enemy:draw() end
	
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

function debugDraw()
	if debug_paths then
		love.graphics.setColor(100, 100, 100)
		for i, node in ipairs(pathNodes) do
			love.graphics.circle("line", node.x, node.y, 5)
			love.graphics.print(i, node.x, node.y)
			for j, other in ipairs(node.connections) do
				love.graphics.line(node.x, node.y, pathNodes[other].x, pathNodes[other].y)
			end
		end
	end
end