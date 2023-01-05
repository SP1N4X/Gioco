extends Node
class_name PlayerAnimation

# warning-ignore:unused_signal
signal Complete

var Parent
var animationTree : AnimationTree
var animationMode 
var animationPlayer : AnimationPlayer
var animationHealth
var flameSpirte = load("res://Player/Image/AttackAnimation/FlameSprite.tscn")

func _init(parent):
	Parent = parent
	animationTree = Parent.get_node("AnimationTree")
	animationPlayer = Parent.get_node("AnimationPlayer")
	animationHealth = Parent.get_node("HeartIcon")
	animationMode = animationTree.get("parameters/playback")
	animationHealth.SetHeart(Parent.Health)

func animationAttack(enemyPosition, Position):
	var dir = (enemyPosition - Position)/16
	animationTree.set("parameters/Attack/blend_position", dir)
	animationMode.travel('Attack')

func animationMagicAttack(enemyPosition, Position):
	var dir = (enemyPosition - Position)/16
	animationTree.set("parameters/Attack/blend_position", dir)
	animationMode.travel('Attack')
	var node = flameSpirte.instance()
	node.position = enemyPosition
	Parent.get_owner().add_child(node)

func animationWalk(dir):
	animationTree.set("parameters/Walk/blend_position", dir)
	animationMode.travel('Walk')

func animationIdle():
	animationMode.travel('Idle')

func animationDead():
	animationMode.travel("Dead")

func animationDamage(damage):
	animationHealth.beginAnimation(damage)
	animationMode.travel("Damage")
