extends Sprite

onready var animationMode = $AnimationTree.get("parameters/playback")

func _ready():
	animationMode.start("IdleHeart")

func beginAnimation(damage):
	var nextHealth = $AnimationTree.get("parameters/IdleHeart/blend_position") - damage
	$AnimationTree.set("parameters/DamageHeart/blend_position", nextHealth)
	$AnimationTree.set("parameters/IdleHeart/blend_position", nextHealth)
	animationMode.travel("DamageHeart")
