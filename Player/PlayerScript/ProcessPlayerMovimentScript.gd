extends Node
class_name MovimentPlayer

signal Complete

var Parent
var tileSize = 16
var speed = 2.5

var deltavalue
var path : PoolVector2Array = [] 
var perc_moveToNext = 0.0
var initialPosition
var dir
var Moving = false
var isMoving = false

func _init(parent):
	Parent = parent

func _process(delta):
	if Moving:
		tryMove(delta)

func tryMove(delta):
	if path and path.size() > 0:
		if isMoving:
			Move(delta)
		else:
			isMoving = true 
			DirCalculation()
			Parent.ProcessAnimation.animationWalk(dir)
			Move(delta)
	else:
		Moving = false
		Parent.ProcessAnimation.animationIdle()
		emit_signal("Complete")

func MoveTo(pathArray):
	path = pathArray
	initialPosition = Parent.position
	Moving = true

func Move(delta):
	perc_moveToNext += speed * delta
	if perc_moveToNext >= 1.0:
		Parent.position = initialPosition + (tileSize * dir)
		isMoving = false
		perc_moveToNext = 0.0
		initialPosition = Parent.position
		path.remove(0)
	else:
		Parent.position = initialPosition + (tileSize * dir * perc_moveToNext)

func DirCalculation():
	dir = (path[0] - Parent.position)/16
