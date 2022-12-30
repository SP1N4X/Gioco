extends Node
class_name TileSelectorMoviment

signal Complete

var Parent
var tileSize = 16
var speed = 5

var deltavalue
var perc_moveToNext = 0.0
var initialPosition
var Dir = Vector2.ZERO
var Moving = false

func _init(parent):
	Parent = parent

func _process(delta):
	if Moving:
		tryMove(delta)

func tryMove(delta):
	if Dir != Vector2.ZERO:
		Move(delta)
	else:
		Moving = false
		emit_signal("Complete")

func MoveTo(dir):
	Dir = dir
	initialPosition = Parent.position
	Moving = true

func Move(delta):
	perc_moveToNext += speed * delta
	if perc_moveToNext >= 1.0:
		Parent.position = initialPosition + (tileSize * Dir)
		perc_moveToNext = 0.0
		initialPosition = Parent.position
		Dir = Vector2.ZERO
	else:
		Parent.position = initialPosition + (tileSize * Dir * perc_moveToNext)
