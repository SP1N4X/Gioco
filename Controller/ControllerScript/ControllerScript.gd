extends Node

func _ready():
	pass

func _on_TileSelector_body_entered(sender, body):	
	if sender.ProcessSelection.Player:
		if body.Group != sender.ProcessSelection.Player.Group:
			setAttackMode()
		else:
			setSelectMode()
	else:
		setSelectMode()

func _on_TileSelector_body_exited(sender, body):
	if sender.ProcessSelection.Player:
		setMoveMode()
	else:
		setSelectMode()

func setAttackMode():
	print("setAttackMode()")
	$AttackButton.visible = true 
	$MoveButton.visible = false
	$SelectButton.visible = false

func setMoveMode():
	print("setMoveMode()")
	$AttackButton.visible = false 
	$MoveButton.visible = true
	$SelectButton.visible = false

func setSelectMode():
	print("setSelectMode()")
	$AttackButton.visible = false 
	$MoveButton.visible = false
	$SelectButton.visible = true
