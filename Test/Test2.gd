extends Node2D

signal foo

func foo_emit(ale):
	print("foo_emit")
	print(ale)
#   yield(get_tree(),"idle_frame")
	emit_signal("foo")
