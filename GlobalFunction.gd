extends Node
class_name GlobalFunction

onready var Parent

func _init(parent):
	Parent = parent

func Get_GroupChildren(groupName):
	var children = Parent.get_tree().get_nodes_in_group(groupName)
	return children

func Remove_FromGroup(node, groupName):
	if node in Parent.get_tree().get_nodes_in_group(groupName):
		node.remove_from_group(groupName)
