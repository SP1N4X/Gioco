extends TileMap

onready var astar = AStar2D.new()
onready var used_cells = get_used_cells_by_id(0)

var path : PoolVector2Array

func _ready():
	_addPoints()
	_connectPoints()

func _addPoints():
	for cell in used_cells:
		astar.add_point(id(cell), cell, 1)

func _connectPoints():
	for cell in used_cells:
		var neighbors = PoolVector2Array ([
			Vector2.RIGHT, 
			Vector2.LEFT,
			Vector2.DOWN,
			Vector2.UP
		])
		for neighbor in neighbors:
			var next_cell = cell + neighbor
			if used_cells.has(next_cell): 
				astar.connect_points(id(cell), id(next_cell), false)

func getPath(startPoint, endPoint):
	path = PoolVector2Array()
	var start = world_to_map(startPoint)
	var end = world_to_map(endPoint)
	if astar.has_point(id(start)) and astar.has_point(id(end)):
		path = astar.get_point_path(id(start), id(end))
		if path.size() > 0:
			path.remove(0)
		for i in range(path.size()):
			path[i] = map_to_world(path[i])
	return path

func id(point):
	var a = point.x
	var b = point.y
	return (a + b) * (a + b + 1) / 2 + b
