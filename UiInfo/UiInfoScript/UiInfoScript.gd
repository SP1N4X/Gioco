extends Node2D

onready var infoDisplayed = false 

func DisplayInfo(Player):
	$Vita.text = str(Player.Health)
	$Forza.text = str(Player.Strength)
	$Stamina.text = str(Player.Stamina)
	
	if !infoDisplayed:
		self.visible = true
