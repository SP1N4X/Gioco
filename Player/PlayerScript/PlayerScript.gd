extends Node2D

signal Complete

export var Health : float = 3
export var Strength : float = 1
export var Stamina : float = 4
export var Magic : float = 1

onready var TileMapNode = get_owner().get_node("TileMap")

onready var ProcessMoviment = MovimentPlayer.new(self)
onready var ProcessAttack = AttackPlayer.new(self)
onready var ProcessAnimation = PlayerAnimation.new(self)
onready var globalFunction = GlobalFunction.new(self)

onready var Group

func _ready():
	print("PlayerReady")
	Group = GlobalFunction.Get_Group(self)
	if Group == "GroupPlayer":
		Set_asPlayer()
	if Group == "GroupEnemy":
		Set_asEnemy()
	Set_asObstacle()
	print(self, "Ready")

func _process(delta):
	ProcessMoviment._process(delta)

func move(pathArray):
	ProcessMoviment.MoveTo(pathArray)
	yield(ProcessMoviment, "Complete")
	emit_signal('Complete')

func attackStamina(pathArray, Enemy):
	ProcessAttack.StaminaAttackTo(pathArray, Strength, Enemy)
	yield(ProcessAttack, "Complete")
	emit_signal('Complete')

func attackMagic(Enemy):
	Magic -= 1
	ProcessAttack.MagicAttackTo(Strength, Enemy)
	yield(ProcessAttack, "Complete")
	emit_signal('Complete')

func dead():
	ProcessAnimation.animationDead()
	yield(ProcessAnimation, "Complete")
	globalFunction.Remove_FromGroup(self, GlobalFunction.Get_Group(self))
	emit_signal("Complete")
	Set_asTile()
	self.queue_free()

func CalDamage(damage):
	Health -= damage
	ProcessAnimation.animationDamage(damage)
	yield(ProcessAnimation, "Complete")
	if Health <= 0:
		dead()
	else:
		emit_signal("Complete")

func Set_asObstacle():
	var mapPosition = TileMapNode.world_to_map(position)
	TileMapNode.astar.set_point_disabled(TileMapNode.id(mapPosition))

func Set_asTile():
	var mapPosition = TileMapNode.world_to_map(position)
	TileMapNode.astar.set_point_disabled(TileMapNode.id(mapPosition), false)

func Select():
	$Cornice.visible = true

func UnSelect():
	$Cornice.visible = false

func Set_asPlayer():
	$ColorRect.color = Color.blue

func Set_asEnemy():
	$ColorRect.color = Color.yellow

func AnimationComplete():
	ProcessAnimation.emit_signal("Complete")
