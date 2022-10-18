extends TextureButton

class_name Card

var symbol = 0
#0 => empty
#1 => o
#2 => x

var face

func _ready():
	pass

func _init(var s):
	symbol = s
	paintFace()

func paintFace():
	if symbol == 1:
		face = GameManager.faceO
	elif symbol == 2:
		face = GameManager.faceX
	else:
		face = GameManager.faceEmpty
	
	set_normal_texture(face)

func _pressed():
	if symbol == 0:
		symbol = GameManager.playerTurn
		paintFace()
		GameManager.checkForWinner()
		GameManager.togglePlayer()
	else:
		pass
