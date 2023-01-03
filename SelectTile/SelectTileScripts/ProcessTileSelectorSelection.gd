extends Node
class_name TileSelectorSelection

#signal Complete

var Parent
var PrincipalNode
var Player 
var Enemy
var TileMapNode
var UiInfoNode

var taskComplete = true

func _init(parent):
	Parent = parent
	PrincipalNode = Parent.get_parent()
	TileMapNode = PrincipalNode.get_node('TileMap')
	UiInfoNode = PrincipalNode.get_node('UiInfo')


func tileInput(tipe):
	if !taskComplete:
		return
	
	if tipe == "select":
		if Parent.get_overlapping_bodies().size() > 0: 
			CheckBody(Parent.get_overlapping_bodies()[0])
	elif tipe == "move":
		if Player:
			PathAndMove(Player.position, Parent.position)
	else:
		TypeAttack(Player.attack[tipe])
	"""
	if Player:
		if Parent.get_overlapping_bodies().size() > 0:
			CheckBody(Parent.get_overlapping_bodies()[0])
			if Enemy:
				PathAndAttack(Player.position, Enemy.position)
		else:
			PathAndMove(Player.position, Parent.position)

	else:
		if Parent.get_overlapping_bodies().size() > 0:
			CheckBody(Parent.get_overlapping_bodies()[0])
			if Enemy:
				UiInfoNode.DisplayInfo(Enemy)
	"""

func TypeAttack(attack):
	if Parent.get_overlapping_bodies().size() > 0:
		 CheckBodyToAttack(Parent.get_overlapping_bodies()[0], attack["Tipe"], attack["Damage"])

func CheckBodyToAttack(body, tipe, damage):
	if Parent.TurnTo == 'Player':
		CheckBodyToAttackPlayer(body, tipe, damage)
	if Parent.TurnTo == 'Enemy':
		CheckBodyToAttackEnemy(body, tipe, damage)

func CheckBodyToAttackPlayer(body, tipe, damage):
	if body in Parent.globalFunction.Get_GroupChildren("GroupEnemy"):
		Enemy = body
		Enemy.Set_asTile()
		if tipe == "Physic":
			PathAndAttack(Player.position, Enemy.position, damage)
		elif tipe == "Magic":
			StayAndAttack(Player.position, Enemy.position, damage)

func CheckBodyToAttackEnemy(body, tipe, damage):
	if body in Parent.globalFunction.Get_GroupChildren("GroupPlayer"):
		Enemy = body
		Enemy.Set_asTile()
		if tipe == "Physic":
			PathAndAttack(Player.position, Enemy.position, damage)
		elif tipe == "Magic":
			StayAndAttack(Player.position, Enemy.position, damage)

func CheckBody(body):
	print(body, Parent.TurnTo)
	if Parent.TurnTo == 'Player':
		CheckBodyPlayer(body)
	if Parent.TurnTo == 'Enemy':
		CheckBodyEnemy(body)

func CheckBodyPlayer(body):
	if body in Parent.globalFunction.Get_GroupChildren("GroupPlayer"):
		ResetObstacle()
		ResetSelection()
		Player = body
		Player.Set_asTile()
		Player.Select()

func CheckBodyEnemy(body):
	if body in Parent.globalFunction.Get_GroupChildren("GroupEnemy"):
		ResetObstacle()
		ResetSelection()
		Player = body
		Player.Set_asTile()
		Player.Select()

func CheckBodyPlayer2(body):
	Enemy = null
	if body in Parent.globalFunction.Get_GroupChildren("GroupPlayer"):
		if Player:
			if Player == body:
				ResetObstacle()
				ResetSelection()
				return
			else:
				ResetObstacle()
				ResetSelection()
		Player = body
		Player.Set_asTile()
		Player.Select()
		UiInfoNode.DisplayInfo(Player)
	if body in Parent.globalFunction.Get_GroupChildren("GroupEnemy"):
		if Player:
			body.Set_asTile()
		Enemy = body
		UiInfoNode.DisplayInfo(Enemy)

func CheckBodyEnemy2(body):
	Enemy = null
	if body in Parent.globalFunction.Get_GroupChildren("GroupEnemy"):
		if Player:
			if Player == body:
				ResetObstacle()
				ResetSelection()
				return
			else:
				ResetObstacle()
				ResetSelection()
		body.Set_asTile()
		Player = body
		Player.Select()
		UiInfoNode.DisplayInfo(Player)
	if body in Parent.globalFunction.Get_GroupChildren("GroupPlayer"):
		if Player:
			body.Set_asTile()
		Enemy = body
		UiInfoNode.DisplayInfo(Enemy)

func PathAndMove(PlayerPosition, SelectPosition):
	var path = TileMapNode.getPath(PlayerPosition, SelectPosition)
	if path.size() <= Player.Stamina and path.size() != 0:
		taskComplete = false
		Player.move(path)
		yield(Player, 'Complete')
		ResetObstacle()
		ResetSelection()
		Parent.turnSwitch()
		taskComplete = true
	else:
		""" popup allert message (path exceed)"""

func PathAndAttack(PlayerPosition, EnemyPosition, damage):
	var path = TileMapNode.getPath(PlayerPosition, EnemyPosition)
	if path.size() <= Player.Stamina:
		taskComplete = false
		Player.attackStamina(path, Enemy, damage)
		yield(Player, 'Complete')
		ResetObstacle()
		ResetSelection()
		Parent.turnSwitch()
		taskComplete = true
	else:
		Enemy.Set_asObstacle()
		Enemy = null
		""" popup allert message (path exceed)"""

func StayAndAttack(PlayerPosition, EnemyPosition, damage):
	if Player.Magic > 0:
		taskComplete = false
		Player.attackMagic(Enemy, damage)
		yield(Player, 'Complete')
		ResetObstacle()
		ResetSelection()
		Parent.turnSwitch()
		taskComplete = true
	else:
		Enemy.Set_asObstacle()
		Enemy = null

func ResetSelection():
	if Enemy:
		Enemy = null
	if Player:
		Player.UnSelect()
		Player = null

func ResetObstacle():
	if Enemy:
		Enemy.Set_asObstacle()
	if Player:
		Player.Set_asObstacle()

