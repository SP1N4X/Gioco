extends Node2D

var display = false
onready var Player

func DisplayInfo(player):
	Player = player 
	$Vita.text = str(player.Health)
	$Forza.text = str(player.Strength)
	$Stamina.text = str(player.Stamina)
	$Magia.text = str(player.Magic)
	
	if !display:
		self.set_visible(true)
		display = true

func UnDisplayInfo():
	if display:
		self.set_visible(false)
		display = false
	Player = null

func RefreshDisplayInfo():
	if Player:
		DisplayInfo(Player)
	
