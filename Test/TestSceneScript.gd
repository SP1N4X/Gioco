extends Node2D

onready var globalFunction = GlobalFunction.new(self)

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		globalFunction.Remove_FromGroup($Node2D, "dkjf")
		print(globalFunction.Get_GroupChildren("Ally"))
