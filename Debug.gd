extends Node2D

onready var TileSelector = $TileSelector

var taskComplete = true 
onready var debug = $Debug

func _input(event):
	debug.text = debug.text + "\n" + str(event.is_action_pressed("ui_select"))
	if taskComplete:
		if Input.is_action_pressed("ui_select"):
			TileSelector.select()

		if Input.is_action_pressed("ui_right"):
			taskComplete = false
			var dir = Vector2(1,0)
			TileSelector.call_deferred("move", dir)
			yield(TileSelector, "Complete")
			taskComplete = true

		if Input.is_action_pressed("ui_left"):
			taskComplete = false
			var dir = Vector2(-1,0)
			TileSelector.call_deferred("move", dir)
			yield(TileSelector, "Complete")
			taskComplete = true 

		if Input.is_action_pressed("ui_up"):
			taskComplete = false
			var dir = Vector2(0,-1)
			TileSelector.call_deferred("move", dir)
			yield(TileSelector, "Complete")
			taskComplete = true 

		if Input.is_action_pressed("ui_down"):
			taskComplete = false
			var dir = Vector2(0,1)
			TileSelector.call_deferred("move", dir)
			yield(TileSelector, "Complete")
			taskComplete = true 
