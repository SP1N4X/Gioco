extends Area2D

signal Complete

onready var ProcessMoviment = TileSelectorMoviment.new(self)
onready var ProcessSelection = TileSelectorSelection.new(self)
onready var globalFunction = GlobalFunction.new(self)

onready var Ray = $RayCast2D
onready var Text = get_owner().get_node("WinText")

var TurnTo = 'Player'

func _ready():
	AddException()

func _process(delta):
	ProcessMoviment._process(delta)

func move(dir):
	if !ValidDir(dir):
		emit_signal('Complete')
	else:
		ProcessMoviment.MoveTo(dir)
		yield(ProcessMoviment, "Complete")
		emit_signal('Complete')

func select():
	ProcessSelection.TrySelection()

func turnSwitch():
	if TurnTo == 'Player':
		if globalFunction.Get_GroupChildren("GroupEnemy"):
			TurnTo = 'Enemy'
		else:
			Text.text = '!!Player WIN!!'
			Text.visible = true
	elif TurnTo == 'Enemy':
		if globalFunction.Get_GroupChildren("GroupPlayer"):
			TurnTo = 'Player'
		else:
			Text.text = '!!Enemy WIN!!'
			Text.visible = true

func ValidDir(dir):
	Ray.cast_to = dir * 16
	Ray.force_raycast_update()
	if Ray.is_colliding() and Ray.get_collider().get_class() == 'TileMap':
		return false
	return true

func AddException():
	for p in globalFunction.Get_GroupChildren("GroupPlayer"):
		Ray.add_exception(p)
	for e in globalFunction.Get_GroupChildren("GroupEnemy"):
		Ray.add_exception(e)

