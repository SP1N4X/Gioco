extends Node2D

signal Complete

export var Health : float = 3
export var Strength : float = 1
export var Stamina : float = 4
export var Magic : float = 1
export var attack = {	"attack1":
							{	
								"Tipe": "Magic", 
								"Damage": 2
							},
						"attack2":
							{	
								"Tipe": "Physic", 
								"Damage": 1
							}
					}

onready var TileMapNode = get_owner().get_node("TileMap")

onready var ProcessMoviment = MovimentPlayer.new(self)
onready var ProcessAttack = AttackPlayer.new(self)
onready var ProcessAnimation = PlayerAnimation.new(self)
onready var globalFunction = GlobalFunction.new(self)
onready var playerAttackInfo = playerAttackInfo
onready var debug = DebugControl.new(self)
onready var Group 

func _ready():
	var Groups = get_groups()
	if "GroupPlayer" in Groups:
		Set_asPlayer()
	if "GroupEnemy" in Groups:
		Set_asEnemy()
	Set_asObstacle()

func _process(delta):
	ProcessMoviment._process(delta)

func move(pathArray):
	ProcessMoviment.MoveTo(pathArray)
	yield(ProcessMoviment, "Complete")
	emit_signal('Complete')

func attackStamina(pathArray, Enemy, damage):
	ProcessAttack.StaminaAttackTo(pathArray, damage, Enemy)
	yield(ProcessAttack, "Complete")
	emit_signal('Complete')

func attackMagic(Enemy, damage):
	Magic -= 1
	ProcessAttack.MagicAttackTo(damage, Enemy)
	yield(ProcessAttack, "Complete")
	emit_signal('Complete')

func dead():
	ProcessAnimation.animationDead()
	yield(ProcessAnimation, "Complete")
	globalFunction.Remove_FromGroup(self, Group)
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
	Group = "GroupPlayer"

func Set_asEnemy():
	$ColorRect.color = Color.yellow
	Group = "GroupEnemy"

func AnimationComplete():
	ProcessAnimation.emit_signal("Complete")
