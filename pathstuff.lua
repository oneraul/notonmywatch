
pathNodes = {}

pathNodes[ 1] = {x = 100, y = 100, connections = {5, 13}}
pathNodes[ 2] = {x = 300, y = 100, connections = {6, 15}}
pathNodes[ 3] = {x = 500, y = 100, connections = {7}}
pathNodes[ 4] = {x = 700, y = 100, connections = {8}}

pathNodes[ 5] = {x = 100, y = 300, connections = {9, 14}}
pathNodes[ 6] = {x = 300, y = 300, connections = {10}}
pathNodes[ 7] = {x = 500, y = 300, connections = {11}}
pathNodes[ 8] = {x = 700, y = 300, connections = {12}}

pathNodes[ 9] = {x = 130, y = 500, connections = {}}
pathNodes[10] = {x = 300, y = 500, connections = {}}
pathNodes[11] = {x = 500, y = 500, connections = {}}
pathNodes[12] = {x = 700, y = 500, connections = {}}

pathNodes[13] = {x =  50, y = 250, connections = {}}
pathNodes[14] = {x =  50, y = 380, connections = {}}
pathNodes[15] = {x = 200, y = 230, connections = {}}

function generatePath(originX)
	local firstNode = 1
	if math.abs(originX-pathNodes[2].x) < math.abs(originX-pathNodes[1].x) then
		firstNode = 2
		if math.abs(originX-pathNodes[3].x) < math.abs(originX-pathNodes[2].x) then
			firstNode = 3
			if math.abs(originX-pathNodes[4].x) < math.abs(originX-pathNodes[3].x) then
				firstNode = 4
			end
		end
	end
	
	local path = { firstNode }
	
	while true do
		if #pathNodes[path[#path]].connections > 0 then
			local last = pathNodes[path[#path]]
			table.insert(path, last.connections[math.random(#last.connections)])
		else
			for i = #path-1, 1, -1 do table.insert(path, path[i]) end
			break
		end
	end
	
	-- TODO add a last node at (pathNodes[firstNode].x, wallY)
	
	return path
end