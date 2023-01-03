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
	if sender.get_overlapping_bodies().size() > 0:
		return
	if sender.ProcessSelection.Player:
		setMoveMode()
	else:
		setSelectMode()

func setAttackMode():
	$Attack1Button.visible = true 
	$Attack2Button.visible = true 
	$MoveButton.visible = false
	$SelectButton.visible = false

func setMoveMode():
	$Attack1Button.visible = false 
	$Attack2Button.visible = false
	$MoveButton.visible = true
	$SelectButton.visible = false

func setSelectMode():
	$Attack1Button.visible = false 
	$Attack2Button.visible = false
	$MoveButton.visible = false
	$SelectButton.visible = true

func setStaminaToUse(i):
	$MoveButton/Label.text = str(i) 
