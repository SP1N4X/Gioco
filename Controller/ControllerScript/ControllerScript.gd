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

func _on_TileSelector_body_exited(sender, _body):
	if sender.ProcessSelection.Player:
		setMoveMode()
	else:
		setSelectMode()

func setAttackMode():
	print("setAttackMode()")
	$AttackButton.visible = true 
	$MoveButton.visible = false
	$SelectButton.visible = false
	$AttackButton.action = "ui_select"
	$MoveButton.action = ""
	$SelectButton.action = ""

func setMoveMode():
	print("setMoveMode()")
	$AttackButton.visible = false 
	$MoveButton.visible = true
	$SelectButton.visible = false
	$AttackButton.action = ""
	$MoveButton.action = "ui_select"
	$SelectButton.action = ""

func setSelectMode():
	print("setSelectMode()")
	$AttackButton.visible = false 
	$MoveButton.visible = false
	$SelectButton.visible = true
	$AttackButton.action = ""
	$MoveButton.action = ""
	$SelectButton.action = "ui_select"
