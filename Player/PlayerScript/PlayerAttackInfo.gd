extends Node
class_name PlayerAttackInfo

onready var Parent
onready var Attack1
onready var Attack2

func _init(parent, Array attack1, Array attack2):
	Parent = parent
	Attack1 = attack1
	Attack2 = attack2

