extends Node
class_name GlobalFunction

onready var Parent

func _init(parent):
	Parent = parent

func Get_GroupChildren(groupName):
	var children = Parent.get_tree().get_nodes_in_group(groupName)
	return children

static func Get_Group(parent):
	var groups = parent.get_groups()
	if groups and groups.size() > 0:
		return groups[0]
	return ""

func Remove_FromGroup(node, groupName):
	if node in Parent.get_tree().get_nodes_in_group(groupName):
		node.remove_from_group(groupName)
