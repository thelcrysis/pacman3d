extends Node



static func at(coord):
	# returns content of world tile at coord
	# 0 for wall, 1 for floor
	var world = [[1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1], [1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1], [1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1], [1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1], [1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1], [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1], [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1], [1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1], [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0], [1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1], [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1], [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1], [1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 1], [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1], [1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1], [1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1], [1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1]]
	var minX = 0
	var maxX = len(world[0]) -1
	var minY = 0
	var maxY = len(world) - 1
	if (minY <= coord.y and coord.x <= maxY) and (minX <= coord.x  and coord.x <= maxX):
		return world[coord.y][coord.x]
	else:
		return null
	return 

static func getClosestFloorLocation(coord):
	var i = 1
	var modifiers = [[-1,0],[0, 1],[1, 0],[0, -1]]
	while true:
		var start = [coord.x+i, coord.y-i]
		for side in range(4):
			var m = modifiers[side]
			for cell in range(i*2):
				start[0] += m[0]
				start[1] += m[1]
				if at(Vector2(start[0],start[1])) == 1:
					return Vector2(start[0], start[1])
		i+=1

static func getLocalFromGlobalCoord(global):
	
	var local = Vector2();
	local.x = int((abs(global.x+11.8)/(11.8+7.8))*20)
	local.y = int((abs(global.z+10.8)/(10.8+7.8))*19)
	# portal patch
	if local.y == 19:
		local.y = 18
	if local.x == 20:
		local.x = 19
	return local

static func getGlobalFromLocalCoord(local, height):
	var global = Vector3();
	global.x = local.x*((11.8+7.8)/19) -11.8
	global.z = local.y*((10.8+7.8)/18) -10.8
	global.y = height
	return global

static func shortestPath(start, end):
	var adjacency_dict = {Vector2(0, 0): [Vector2(0, 1), Vector2(1, 0)], Vector2(1, 0): [Vector2(0, 0), Vector2(2, 0)], Vector2(2, 0): [Vector2(2, 1), Vector2(1, 0)], Vector2(3, 0): [], Vector2(4, 0): [Vector2(4, 1), Vector2(5, 0)], Vector2(5, 0): [Vector2(4, 0), Vector2(6, 0)], Vector2(6, 0): [Vector2(6, 1), Vector2(5, 0)], Vector2(7, 0): [], Vector2(8, 0): [], Vector2(9, 0): [], Vector2(10, 0): [Vector2(10, 1)], Vector2(11, 0): [], Vector2(12, 0): [], Vector2(13, 0): [], Vector2(14, 0): [Vector2(14, 1), Vector2(15, 0)], Vector2(15, 0): [Vector2(14, 0), Vector2(16, 0)], Vector2(16, 0): [Vector2(16, 1), Vector2(15, 0), Vector2(17, 0)], Vector2(17, 0): [Vector2(16, 0), Vector2(18, 0)], Vector2(18, 0): [Vector2(17, 0), Vector2(19, 0)], Vector2(19, 0): [Vector2(19, 1), Vector2(18, 0)], Vector2(0, 1): [Vector2(0, 0), Vector2(0, 2)], Vector2(1, 1): [], Vector2(2, 1): [Vector2(2, 0), Vector2(2, 2), Vector2(3, 1)], Vector2(3, 1): [Vector2(2, 1), Vector2(4, 1)], Vector2(4, 1): [Vector2(4, 0), Vector2(3, 1)], Vector2(5, 1): [], Vector2(6, 1): [Vector2(6, 0), Vector2(6, 2)], Vector2(7, 1): [], Vector2(8, 1): [], Vector2(9, 1): [], Vector2(10, 1): [Vector2(10, 0), Vector2(10, 2)], Vector2(11, 1): [], Vector2(12, 1): [], Vector2(13, 1): [], Vector2(14, 1): [Vector2(14, 0), Vector2(14, 2)], Vector2(15, 1): [], Vector2(16, 1): [Vector2(16, 0), Vector2(16, 2)], Vector2(17, 1): [], Vector2(18, 1): [], Vector2(19, 1): [Vector2(19, 0), Vector2(19, 2)], Vector2(0, 2): [Vector2(0, 1), Vector2(0, 3)], Vector2(1, 2): [], Vector2(2, 2): [Vector2(2, 1), Vector2(2, 3)], Vector2(3, 2): [], Vector2(4, 2): [], Vector2(5, 2): [], Vector2(6, 2): [Vector2(6, 1), Vector2(6, 3)], Vector2(7, 2): [], Vector2(8, 2): [], Vector2(9, 2): [], Vector2(10, 2): [Vector2(10, 1), Vector2(10, 3)], Vector2(11, 2): [], Vector2(12, 2): [], Vector2(13, 2): [], Vector2(14, 2): [Vector2(14, 1), Vector2(14, 3)], Vector2(15, 2): [], Vector2(16, 2): [Vector2(16, 1), Vector2(16, 3)], Vector2(17, 2): [], Vector2(18, 2): [], Vector2(19, 2): [Vector2(19, 1), Vector2(19, 3)], Vector2(0, 3): [Vector2(0, 2), Vector2(0, 4)], Vector2(1, 3): [], Vector2(2, 3): [Vector2(2, 2), Vector2(3, 3)], Vector2(3, 3): [Vector2(2, 3), Vector2(4, 3)], Vector2(4, 3): [Vector2(4, 4), Vector2(3, 3), Vector2(5, 3)], Vector2(5, 3): [Vector2(4, 3), Vector2(6, 3)], Vector2(6, 3): [Vector2(6, 2), Vector2(6, 4), Vector2(5, 3), Vector2(7, 3)], Vector2(7, 3): [Vector2(6, 3), Vector2(8, 3)], Vector2(8, 3): [Vector2(7, 3), Vector2(9, 3)], Vector2(9, 3): [Vector2(8, 3), Vector2(10, 3)], Vector2(10, 3): [Vector2(10, 2), Vector2(10, 4), Vector2(9, 3), Vector2(11, 3)], Vector2(11, 3): [Vector2(10, 3), Vector2(12, 3)], Vector2(12, 3): [Vector2(11, 3), Vector2(13, 3)], Vector2(13, 3): [Vector2(12, 3), Vector2(14, 3)], Vector2(14, 3): [Vector2(14, 2), Vector2(13, 3), Vector2(15, 3)], Vector2(15, 3): [Vector2(14, 3), Vector2(16, 3)], Vector2(16, 3): [Vector2(16, 2), Vector2(16, 4), Vector2(15, 3), Vector2(17, 3)], Vector2(17, 3): [Vector2(16, 3), Vector2(18, 3)], Vector2(18, 3): [Vector2(17, 3), Vector2(19, 3)], Vector2(19, 3): [Vector2(19, 2), Vector2(19, 4), Vector2(18, 3)], Vector2(0, 4): [Vector2(0, 3), Vector2(0, 5)], Vector2(1, 4): [], Vector2(2, 4): [], Vector2(3, 4): [], Vector2(4, 4): [Vector2(4, 3), Vector2(4, 5)], Vector2(5, 4): [], Vector2(6, 4): [Vector2(6, 3), Vector2(6, 5)], Vector2(7, 4): [], Vector2(8, 4): [], Vector2(9, 4): [], Vector2(10, 4): [Vector2(10, 3), Vector2(10, 5)], Vector2(11, 4): [], Vector2(12, 4): [], Vector2(13, 4): [], Vector2(14, 4): [], Vector2(15, 4): [], Vector2(16, 4): [Vector2(16, 3), Vector2(16, 5)], Vector2(17, 4): [], Vector2(18, 4): [], Vector2(19, 4): [Vector2(19, 3), Vector2(19, 5)], Vector2(0, 5): [Vector2(0, 4), Vector2(0, 6)], Vector2(1, 5): [], Vector2(2, 5): [Vector2(2, 6), Vector2(3, 5)], Vector2(3, 5): [Vector2(2, 5), Vector2(4, 5)], Vector2(4, 5): [Vector2(4, 4), Vector2(4, 6), Vector2(3, 5)], Vector2(5, 5): [], Vector2(6, 5): [Vector2(6, 4), Vector2(6, 6), Vector2(7, 5)], Vector2(7, 5): [Vector2(6, 5), Vector2(8, 5)], Vector2(8, 5): [Vector2(8, 6), Vector2(7, 5), Vector2(9, 5)], Vector2(9, 5): [Vector2(8, 5), Vector2(10, 5)], Vector2(10, 5): [Vector2(10, 4), Vector2(9, 5), Vector2(11, 5)], Vector2(11, 5): [Vector2(10, 5), Vector2(12, 5)], Vector2(12, 5): [Vector2(12, 6), Vector2(11, 5)], Vector2(13, 5): [], Vector2(14, 5): [Vector2(14, 6), Vector2(15, 5)], Vector2(15, 5): [Vector2(14, 5), Vector2(16, 5)], Vector2(16, 5): [Vector2(16, 4), Vector2(16, 6), Vector2(15, 5)], Vector2(17, 5): [], Vector2(18, 5): [], Vector2(19, 5): [Vector2(19, 4), Vector2(19, 6)], Vector2(0, 6): [Vector2(0, 5), Vector2(0, 7)], Vector2(1, 6): [], Vector2(2, 6): [Vector2(2, 5), Vector2(2, 7)], Vector2(3, 6): [], Vector2(4, 6): [Vector2(4, 5), Vector2(4, 7)], Vector2(5, 6): [], Vector2(6, 6): [Vector2(6, 5), Vector2(6, 7)], Vector2(7, 6): [], Vector2(8, 6): [Vector2(8, 5), Vector2(8, 7)], Vector2(9, 6): [], Vector2(10, 6): [], Vector2(11, 6): [], Vector2(12, 6): [Vector2(12, 5), Vector2(12, 7)], Vector2(13, 6): [], Vector2(14, 6): [Vector2(14, 5), Vector2(14, 7)], Vector2(15, 6): [], Vector2(16, 6): [Vector2(16, 5), Vector2(16, 7)], Vector2(17, 6): [], Vector2(18, 6): [], Vector2(19, 6): [Vector2(19, 5), Vector2(19, 7)], Vector2(0, 7): [Vector2(0, 6), Vector2(0, 8)], Vector2(1, 7): [], Vector2(2, 7): [Vector2(2, 6), Vector2(2, 8)], Vector2(3, 7): [], Vector2(4, 7): [Vector2(4, 6), Vector2(4, 8)], Vector2(5, 7): [], Vector2(6, 7): [Vector2(6, 6), Vector2(6, 8)], Vector2(7, 7): [], Vector2(8, 7): [Vector2(8, 6), Vector2(8, 8)], Vector2(9, 7): [], Vector2(10, 7): [], Vector2(11, 7): [], Vector2(12, 7): [Vector2(12, 6), Vector2(12, 8)], Vector2(13, 7): [], Vector2(14, 7): [Vector2(14, 6), Vector2(14, 8)], Vector2(15, 7): [], Vector2(16, 7): [Vector2(16, 6), Vector2(16, 8)], Vector2(17, 7): [], Vector2(18, 7): [], Vector2(19, 7): [Vector2(19, 6), Vector2(19, 8)], Vector2(0, 8): [Vector2(0, 7), Vector2(0, 9), Vector2(1, 8)], Vector2(1, 8): [Vector2(0, 8), Vector2(2, 8)], Vector2(2, 8): [Vector2(2, 7), Vector2(1, 8)], Vector2(3, 8): [], Vector2(4, 8): [Vector2(4, 7), Vector2(4, 9), Vector2(5, 8)], Vector2(5, 8): [Vector2(4, 8), Vector2(6, 8)], Vector2(6, 8): [Vector2(6, 7), Vector2(5, 8)], Vector2(7, 8): [], Vector2(8, 8): [Vector2(8, 7), Vector2(8, 9)], Vector2(9, 8): [], Vector2(10, 8): [], Vector2(11, 8): [], Vector2(12, 8): [Vector2(12, 7), Vector2(12, 9), Vector2(13, 8)], Vector2(13, 8): [Vector2(12, 8), Vector2(14, 8)], Vector2(14, 8): [Vector2(14, 7), Vector2(13, 8)], Vector2(15, 8): [], Vector2(16, 8): [Vector2(16, 7), Vector2(16, 9), Vector2(17, 8)], Vector2(17, 8): [Vector2(16, 8), Vector2(18, 8)], Vector2(18, 8): [Vector2(17, 8), Vector2(19, 8)], Vector2(19, 8): [Vector2(19, 7), Vector2(18, 8)], Vector2(0, 9): [Vector2(0, 8), Vector2(0, 10)], Vector2(1, 9): [], Vector2(2, 9): [], Vector2(3, 9): [], Vector2(4, 9): [Vector2(4, 8), Vector2(4, 10)], Vector2(5, 9): [], Vector2(6, 9): [], Vector2(7, 9): [], Vector2(8, 9): [Vector2(8, 8), Vector2(8, 10)], Vector2(9, 9): [], Vector2(10, 9): [], Vector2(11, 9): [], Vector2(12, 9): [Vector2(12, 8), Vector2(12, 10)], Vector2(13, 9): [], Vector2(14, 9): [], Vector2(15, 9): [], Vector2(16, 9): [Vector2(16, 8), Vector2(16, 10)], Vector2(17, 9): [], Vector2(18, 9): [], Vector2(19, 9): [], Vector2(0, 10): [Vector2(0, 9), Vector2(0, 11), Vector2(1, 10)], Vector2(1, 10): [Vector2(0, 10), Vector2(2, 10)], Vector2(2, 10): [Vector2(2, 11), Vector2(1, 10)], Vector2(3, 10): [], Vector2(4, 10): [Vector2(4, 9), Vector2(4, 11), Vector2(5, 10)], Vector2(5, 10): [Vector2(4, 10), Vector2(6, 10)], Vector2(6, 10): [Vector2(6, 11), Vector2(5, 10)], Vector2(7, 10): [], Vector2(8, 10): [Vector2(8, 9), Vector2(8, 11)], Vector2(9, 10): [], Vector2(10, 10): [], Vector2(11, 10): [], Vector2(12, 10): [Vector2(12, 9), Vector2(12, 11), Vector2(13, 10)], Vector2(13, 10): [Vector2(12, 10), Vector2(14, 10)], Vector2(14, 10): [Vector2(14, 11), Vector2(13, 10)], Vector2(15, 10): [], Vector2(16, 10): [Vector2(16, 9), Vector2(16, 11), Vector2(17, 10)], Vector2(17, 10): [Vector2(16, 10), Vector2(18, 10)], Vector2(18, 10): [Vector2(17, 10), Vector2(19, 10)], Vector2(19, 10): [Vector2(19, 11), Vector2(18, 10)], Vector2(0, 11): [Vector2(0, 10), Vector2(0, 12)], Vector2(1, 11): [], Vector2(2, 11): [Vector2(2, 10), Vector2(2, 12)], Vector2(3, 11): [], Vector2(4, 11): [Vector2(4, 10), Vector2(4, 12)], Vector2(5, 11): [], Vector2(6, 11): [Vector2(6, 10), Vector2(6, 12)], Vector2(7, 11): [], Vector2(8, 11): [Vector2(8, 10), Vector2(8, 12)], Vector2(9, 11): [], Vector2(10, 11): [], Vector2(11, 11): [], Vector2(12, 11): [Vector2(12, 10), Vector2(12, 12)], Vector2(13, 11): [], Vector2(14, 11): [Vector2(14, 10), Vector2(14, 12)], Vector2(15, 11): [], Vector2(16, 11): [Vector2(16, 10), Vector2(16, 12)], Vector2(17, 11): [], Vector2(18, 11): [], Vector2(19, 11): [Vector2(19, 10), Vector2(19, 12)], Vector2(0, 12): [Vector2(0, 11), Vector2(0, 13)], Vector2(1, 12): [], Vector2(2, 12): [Vector2(2, 11), Vector2(2, 13)], Vector2(3, 12): [], Vector2(4, 12): [Vector2(4, 11), Vector2(4, 13)], Vector2(5, 12): [], Vector2(6, 12): [Vector2(6, 11), Vector2(6, 13)], Vector2(7, 12): [], Vector2(8, 12): [Vector2(8, 11), Vector2(8, 13)], Vector2(9, 12): [], Vector2(10, 12): [], Vector2(11, 12): [], Vector2(12, 12): [Vector2(12, 11), Vector2(12, 13)], Vector2(13, 12): [], Vector2(14, 12): [Vector2(14, 11), Vector2(14, 13)], Vector2(15, 12): [], Vector2(16, 12): [Vector2(16, 11), Vector2(16, 13)], Vector2(17, 12): [], Vector2(18, 12): [], Vector2(19, 12): [Vector2(19, 11), Vector2(19, 13)], Vector2(0, 13): [Vector2(0, 12), Vector2(0, 14)], Vector2(1, 13): [], Vector2(2, 13): [Vector2(2, 12), Vector2(3, 13)], Vector2(3, 13): [Vector2(2, 13), Vector2(4, 13)], Vector2(4, 13): [Vector2(4, 12), Vector2(4, 14), Vector2(3, 13)], Vector2(5, 13): [], Vector2(6, 13): [Vector2(6, 12), Vector2(6, 14), Vector2(7, 13)], Vector2(7, 13): [Vector2(6, 13), Vector2(8, 13)], Vector2(8, 13): [Vector2(8, 12), Vector2(7, 13), Vector2(9, 13)], Vector2(9, 13): [Vector2(8, 13), Vector2(10, 13)], Vector2(10, 13): [Vector2(10, 14), Vector2(9, 13), Vector2(11, 13)], Vector2(11, 13): [Vector2(10, 13), Vector2(12, 13)], Vector2(12, 13): [Vector2(12, 12), Vector2(11, 13)], Vector2(13, 13): [], Vector2(14, 13): [Vector2(14, 12), Vector2(15, 13)], Vector2(15, 13): [Vector2(14, 13), Vector2(16, 13)], Vector2(16, 13): [Vector2(16, 12), Vector2(16, 14), Vector2(15, 13)], Vector2(17, 13): [], Vector2(18, 13): [], Vector2(19, 13): [Vector2(19, 12), Vector2(19, 14)], Vector2(0, 14): [Vector2(0, 13), Vector2(0, 15)], Vector2(1, 14): [], Vector2(2, 14): [], Vector2(3, 14): [], Vector2(4, 14): [Vector2(4, 13), Vector2(4, 15)], Vector2(5, 14): [], Vector2(6, 14): [Vector2(6, 13), Vector2(6, 15)], Vector2(7, 14): [], Vector2(8, 14): [], Vector2(9, 14): [], Vector2(10, 14): [Vector2(10, 13), Vector2(10, 15)], Vector2(11, 14): [], Vector2(12, 14): [], Vector2(13, 14): [], Vector2(14, 14): [], Vector2(15, 14): [], Vector2(16, 14): [Vector2(16, 13), Vector2(16, 15)], Vector2(17, 14): [], Vector2(18, 14): [], Vector2(19, 14): [Vector2(19, 13), Vector2(19, 15)], Vector2(0, 15): [Vector2(0, 14), Vector2(0, 16)], Vector2(1, 15): [], Vector2(2, 15): [Vector2(2, 16), Vector2(3, 15)], Vector2(3, 15): [Vector2(2, 15), Vector2(4, 15)], Vector2(4, 15): [Vector2(4, 14), Vector2(3, 15), Vector2(5, 15)], Vector2(5, 15): [Vector2(4, 15), Vector2(6, 15)], Vector2(6, 15): [Vector2(6, 14), Vector2(6, 16), Vector2(5, 15), Vector2(7, 15)], Vector2(7, 15): [Vector2(6, 15), Vector2(8, 15)], Vector2(8, 15): [Vector2(7, 15), Vector2(9, 15)], Vector2(9, 15): [Vector2(8, 15), Vector2(10, 15)], Vector2(10, 15): [Vector2(10, 14), Vector2(10, 16), Vector2(9, 15), Vector2(11, 15)], Vector2(11, 15): [Vector2(10, 15), Vector2(12, 15)], Vector2(12, 15): [Vector2(11, 15), Vector2(13, 15)], Vector2(13, 15): [Vector2(12, 15), Vector2(14, 15)], Vector2(14, 15): [Vector2(14, 16), Vector2(13, 15), Vector2(15, 15)], Vector2(15, 15): [Vector2(14, 15), Vector2(16, 15)], Vector2(16, 15): [Vector2(16, 14), Vector2(16, 16), Vector2(15, 15), Vector2(17, 15)], Vector2(17, 15): [Vector2(16, 15), Vector2(18, 15)], Vector2(18, 15): [Vector2(17, 15), Vector2(19, 15)], Vector2(19, 15): [Vector2(19, 14), Vector2(19, 16), Vector2(18, 15)], Vector2(0, 16): [Vector2(0, 15), Vector2(0, 17)], Vector2(1, 16): [], Vector2(2, 16): [Vector2(2, 15), Vector2(2, 17)], Vector2(3, 16): [], Vector2(4, 16): [], Vector2(5, 16): [], Vector2(6, 16): [Vector2(6, 15), Vector2(6, 17)], Vector2(7, 16): [], Vector2(8, 16): [], Vector2(9, 16): [], Vector2(10, 16): [Vector2(10, 15), Vector2(10, 17)], Vector2(11, 16): [], Vector2(12, 16): [], Vector2(13, 16): [], Vector2(14, 16): [Vector2(14, 15), Vector2(14, 17)], Vector2(15, 16): [], Vector2(16, 16): [Vector2(16, 15), Vector2(16, 17)], Vector2(17, 16): [], Vector2(18, 16): [], Vector2(19, 16): [Vector2(19, 15), Vector2(19, 17)], Vector2(0, 17): [Vector2(0, 16), Vector2(0, 18)], Vector2(1, 17): [], Vector2(2, 17): [Vector2(2, 16), Vector2(2, 18), Vector2(3, 17)], Vector2(3, 17): [Vector2(2, 17), Vector2(4, 17)], Vector2(4, 17): [Vector2(4, 18), Vector2(3, 17)], Vector2(5, 17): [], Vector2(6, 17): [Vector2(6, 16), Vector2(6, 18)], Vector2(7, 17): [], Vector2(8, 17): [], Vector2(9, 17): [], Vector2(10, 17): [Vector2(10, 16), Vector2(10, 18)], Vector2(11, 17): [], Vector2(12, 17): [], Vector2(13, 17): [], Vector2(14, 17): [Vector2(14, 16), Vector2(14, 18)], Vector2(15, 17): [], Vector2(16, 17): [Vector2(16, 16), Vector2(16, 18)], Vector2(17, 17): [], Vector2(18, 17): [], Vector2(19, 17): [Vector2(19, 16), Vector2(19, 18)], Vector2(0, 18): [Vector2(0, 17), Vector2(1, 18)], Vector2(1, 18): [Vector2(0, 18), Vector2(2, 18)], Vector2(2, 18): [Vector2(2, 17), Vector2(1, 18)], Vector2(3, 18): [], Vector2(4, 18): [Vector2(4, 17), Vector2(5, 18)], Vector2(5, 18): [Vector2(4, 18), Vector2(6, 18)], Vector2(6, 18): [Vector2(6, 17), Vector2(5, 18)], Vector2(7, 18): [], Vector2(8, 18): [], Vector2(9, 18): [], Vector2(10, 18): [Vector2(10, 17)], Vector2(11, 18): [], Vector2(12, 18): [], Vector2(13, 18): [], Vector2(14, 18): [Vector2(14, 17), Vector2(15, 18)], Vector2(15, 18): [Vector2(14, 18), Vector2(16, 18)], Vector2(16, 18): [Vector2(16, 17), Vector2(15, 18), Vector2(17, 18)], Vector2(17, 18): [Vector2(16, 18), Vector2(18, 18)], Vector2(18, 18): [Vector2(17, 18), Vector2(19, 18)], Vector2(19, 18): [Vector2(19, 17), Vector2(18, 18)]}	
	var open_ = [[start]]
	var visited = []
	while open_:
		var cpath = open_[0]
		var last_node = cpath[-1]
		visited.append(last_node)
		for n in adjacency_dict[last_node]:
			if not visited.has(n):
				var cp = [] + cpath
				cp.append(n)
				if n == end:
					return cp
				else:
					open_.append(cp)
		open_.remove(0)

static func detectDirection(v1,v2):
	if v1.x != v2.x:
		if v2.x<v1.x:
			return 'l'
		else:
			return 'r'
	else:
		if v2.y<v1.y:
			return 'd'
		else:
			return 'u'
			
static func getAllPathsDirectionChanges(path):
	var dir_ = null
	var directionChanges = []
	for i in range(len(path)):
		var j = i+1
		if j == len(path): break
		if dir_ == null:
			dir_ = detectDirection(path[i], path[j])
		elif dir_ != detectDirection(path[i], path[j]):
			directionChanges.append(path[i])
			dir_ = detectDirection(path[i], path[j])
	directionChanges.append(path[-1])
	return directionChanges

static func getFirstDirectionChangeLocation(start:Vector2, end:Vector2):
	var path = shortestPath(start, end);
	return getAllPathsDirectionChanges(shortestPath(start, end))[0];
	
func _ready():
	pass # Replace with function body.
