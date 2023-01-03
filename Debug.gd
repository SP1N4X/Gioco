extends Node2D

onready var TileSelector = $TileSelector

var taskComplete = true 

func _input(event):
	if taskComplete:
		if Input.is_action_pressed("ui_select"):
			TileSelector.select("select")
		
		if Input.is_action_pressed("ui_magicAttack"):
			TileSelector.select("magic")
		if Input.is_action_pressed("ui_staminaAttack"):
			TileSelector.select("stamina")
		if Input.is_action_pressed("ui_move"):
			TileSelector.select("move")

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
