extends Node2D

onready var flameSpirte = load("res://Player/Image/AttackAnimation/FlameSprite.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		var node = flameSpirte.instance()
		node.position = Vector2(16,16)
		add_child(node)
		print(node.position)
		
