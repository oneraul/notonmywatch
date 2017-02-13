
pathNodes = {}

pathNodes[ 1] = {x = 390, y = 293, connections = {5, 6, 7, 8}}
pathNodes[ 2] = {x = 535, y = 269, connections = {9, 10}}
pathNodes[ 3] = {x = 704, y = 279, connections = {11, 12}}
pathNodes[ 4] = {x = 863, y = 307, connections = {13, 14, 15}}

pathNodes[ 5] = {x = 328, y = 390, connections = {}}
pathNodes[ 6] = {x = 330, y = 539, connections = {}}
pathNodes[ 7] = {x = 411, y = 531, connections = {}}
pathNodes[ 8] = {x = 412, y = 417, connections = {}}

pathNodes[ 9] = {x = 485, y = 399, connections = {}}
pathNodes[10] = {x = 480, y = 510, connections = {}}

pathNodes[11] = {x = 763, y = 391, connections = {}}
pathNodes[12] = {x = 760, y = 533, connections = {}}

pathNodes[13] = {x = 833, y = 400, connections = {}}
pathNodes[14] = {x = 833, y = 513, connections = {}}
pathNodes[15] = {x = 901, y = 426, connections = {}}

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
	
	return path
end