extends Node2D
class_name DebugControl

onready var DebugLabel = get_owner().get_node("Debug")

func _init(parent):
	DebugLabel = parent.get_owner().get_node("Debug")

func DebugWriteLine(stringa):
	if typeof(stringa) == TYPE_ARRAY:
		for s in stringa: 
			DebugLabel.text = DebugLabel.text + "\n" + s
	else:
		DebugLabel.text = DebugLabel.text + "\n" + stringa
