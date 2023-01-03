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
	$Attack1Button.visible = true 
	$Attack2Button.visible = true 
	$MoveButton.visible = false
	$SelectButton.visible = false
	$Attack1Button.action = "ui_attack1"
	$Attack2Button.action = "ui_attack2"
	$MoveButton.action = ""
	$SelectButton.action = ""

func setMoveMode():
	$Attack1Button.visible = false 
	$Attack2Button.visible = false
	$MoveButton.visible = true
	$SelectButton.visible = false
	$Attack1Button.action = ""
	$Attack2Button.action = ""
	$MoveButton.action = "ui_move"
	$SelectButton.action = ""

func setSelectMode():
	$Attack1Button.visible = false 
	$Attack2Button.visible = false
	$MoveButton.visible = false
	$SelectButton.visible = true
	$Attack1Button.action = ""
	$Attack2Button.action = ""
	$MoveButton.action = ""
	$SelectButton.action = "ui_select"
