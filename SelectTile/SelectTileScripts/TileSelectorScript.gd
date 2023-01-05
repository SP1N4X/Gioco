extends Area2D

signal Complete
signal Body_entered(sender, body)
signal Body_exited(sender, body)

onready var ProcessMoviment = TileSelectorMoviment.new(self)
onready var ProcessSelection = TileSelectorSelection.new(self)
onready var globalFunction = GlobalFunction.new(self)

onready var Ray = $RayCast2D
onready var Text = get_owner().get_node("WinText")
onready var TurnToLabel = get_owner().get_node("TurnTo")
onready var Controller = get_owner().get_node("Controller")
onready var tileMap = get_owner().get_node("TileMap")

var TurnTo = 'Player'

func _ready():
	var _a = self.connect("body_entered", self, "_send_onBodyEnteredSignal")
	_a = self.connect("body_exited", self, "_send_onBodyExitedSignal")
	_a = self.connect("Body_entered", Controller, "_on_TileSelector_body_entered")
	_a = self.connect("Body_exited", Controller, "_on_TileSelector_body_exited")
	print(_a)
	AddException()

func _send_onBodyEnteredSignal(body):
	emit_signal("Body_entered", self, body)
	ProcessSelection.UiInfoNode.DisplayInfo(body)

func _send_onBodyExitedSignal(body):
	emit_signal("Body_exited", self, body)
	if get_overlapping_bodies().size() > 0:
		return 
	if ProcessSelection.Player:
		ProcessSelection.UiInfoNode.DisplayInfo(ProcessSelection.Player)
	else:
		ProcessSelection.UiInfoNode.UnDisplayInfo()

func _process(delta):
	ProcessMoviment._process(delta)

func move(dir):
	if !ValidDir(dir):
		emit_signal('Complete')
	else:
		if ProcessSelection.Player:
			var path = tileMap.getPath(ProcessSelection.Player.position, position + dir * 16)
			if path.size() > 0:
				Controller.setStaminaToUse(path.size())
		ProcessMoviment.MoveTo(dir)
		yield(ProcessMoviment, "Complete")
		emit_signal('Complete')

func select(tipe):
	ProcessSelection.tileInput(tipe)

func turnSwitch():
	if TurnTo == 'Player':
		if globalFunction.Get_GroupChildren("GroupEnemy"):
			TurnTo = 'Enemy'
			TurnToLabel.text = "Yellow"
			Controller.setSelectMode()
		else:
			Text.text = '!!Player WIN!!'
			Text.visible = true
			Controller.setSelectMode()
	elif TurnTo == 'Enemy':
		if globalFunction.Get_GroupChildren("GroupPlayer"):
			TurnTo = 'Player'
			TurnToLabel.text = "Blue"
			Controller.setSelectMode()
		else:
			Text.text = '!!Enemy WIN!!'
			Text.visible = true
			Controller.setSelectMode()
	ProcessSelection.UiInfoNode.RefreshDisplayInfo(get_overlapping_bodies())

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

