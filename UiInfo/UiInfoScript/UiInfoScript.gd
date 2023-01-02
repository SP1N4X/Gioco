extends Node2D

var display = false

func DisplayInfo(Player):
	$Vita.text = str(Player.Health)
	$Forza.text = str(Player.Strength)
	$Stamina.text = str(Player.Stamina)
	$Magia.text = str(Player.Magic)
	
	if !display:
		self.set_visible(true)
		display = true

func UnDisplayInfo():
	if display:
		self.set_visible(false)
		display = false
