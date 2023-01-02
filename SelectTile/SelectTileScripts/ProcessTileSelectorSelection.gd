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

func TrySelection():
	if !taskComplete:
		return

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

func CheckBody(body):
	if Parent.TurnTo == 'Player':
		CheckBodyPlayer(body)
	if Parent.TurnTo == 'Enemy':
		CheckBodyEnemy(body)

func CheckBodyPlayer(body):
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

func CheckBodyEnemy(body):
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
		ResetObstacle()
		ResetSelection()
		print("pathExceed")

func PathAndAttack(PlayerPosition, EnemyPosition):
	var path = TileMapNode.getPath(PlayerPosition, EnemyPosition)
	if path.size() <= Player.Stamina:
		taskComplete = false
		Player.attackStamina(path, Enemy)
		yield(Player, 'Complete')
		ResetObstacle()
		ResetSelection()
		Parent.turnSwitch()
		taskComplete = true
	elif Player.Magic > 0:
		taskComplete = false
		Player.attackMagic(Enemy)
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
	UiInfoNode.UnDisplayInfo()

func ResetObstacle():
	if Enemy:
		Enemy.Set_asObstacle()
	if Player:
		Player.Set_asObstacle()

