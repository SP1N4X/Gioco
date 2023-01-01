extends Node
class_name AttackPlayer

signal Complete

var Parent

func _init(parent):
	Parent = parent

func StaminaAttackTo(pathArray, Strength, Enemy):
	pathArray.remove(pathArray.size() - 1)
	Parent.ProcessMoviment.MoveTo(pathArray)
	yield(Parent.ProcessMoviment, 'Complete')
	Parent.ProcessAnimation.animationAttack(Enemy.position, Parent.position)
	yield(Parent.ProcessAnimation, "Complete")
	Enemy.call_deferred("CalDamage", Strength)
	yield(Enemy, "Complete")
	emit_signal("Complete")

func MagicAttackTo(Strength, Enemy):
	Parent.ProcessAnimation.animationAttack(Enemy.position, Parent.position)
	yield(Parent.ProcessAnimation, "Complete")
	Enemy.call_deferred("CalDamage", Strength)
	yield(Enemy, "Complete")
	emit_signal("Complete")
