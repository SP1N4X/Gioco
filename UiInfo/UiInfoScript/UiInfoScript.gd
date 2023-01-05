extends Node2D

var display = false

func DisplayInfo(player):
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

func RefreshDisplayInfo(bodies):
	if bodies.size() < 1:
		UnDisplayInfo()
	else:
		DisplayInfo(bodies[0])
	
