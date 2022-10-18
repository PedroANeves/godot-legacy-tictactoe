extends Node

onready var Game = get_node("/root/Game/")
onready var PlayerOScoreUi = Game.get_node("ui/HBoxContainer/VBoxContainer2/HBoxContainer/playerOScoreLabel")
onready var PlayerXScoreUi = Game.get_node("ui/HBoxContainer/VBoxContainer/HBoxContainer/playerXScoreLabel")
var c = load("res://src/main/Card.gd")

var faceEmpty = preload("res://assets/art/ttt_empty.png")
var faceO = preload("res://assets/art/ttt_o.png")
var faceX = preload("res://assets/art/ttt_x.png")

var playerOScore = 0
var playerXScore = 0

var playerTurn = 1
var winner = 0

var board = Array()

func _ready():
	fillBoard()
	dealBoard()

func fillBoard():
	for _i in range(9):
		board.append(c.new(0))

func dealBoard():
	for i in len(board):
		Game.get_node("grid").add_child(board[i])

func togglePlayer():
	if playerTurn == 1: playerTurn = 2
	else: playerTurn = 1

# 0 1 2
# 3 4 5
# 6 7 8
func checkForWinner():
	var line = Array()
	var collum = Array()
	var diagonal = Array()
	
	line.append( [board[0].symbol , board[1].symbol , board[2].symbol] )
	line.append( [board[3].symbol , board[4].symbol , board[5].symbol] )
	line.append( [board[6].symbol , board[7].symbol , board[8].symbol] )
	
	collum.append( [board[0].symbol , board[3].symbol , board[6].symbol] )
	collum.append( [board[1].symbol , board[4].symbol , board[5].symbol] )
	collum.append( [board[2].symbol , board[5].symbol , board[8].symbol] )
	
	diagonal.append( [board[0].symbol , board[4].symbol , board[8].symbol] )
	diagonal.append( [board[2].symbol , board[4].symbol , board[6].symbol] )
	
	print(line[0])
	print(line[1])
	print(line[2])
	
	for i in len(line):
		if line[i] == [1,1,1]: winner = 1
		elif line[i] == [2,2,2]: winner = 2
	
	for j in len(collum):
		if collum[j] == [1,1,1]: winner = 1
		elif collum[j] == [2,2,2]: winner = 2
	
	for k in len(diagonal):
		if diagonal[k] == [1,1,1]: winner = 1
		elif diagonal[k] == [2,2,2]: winner = 2

	
	
	if winner != 0:
		if winner == 1:
			playerOScore += 1
		elif winner == 2:
			playerXScore += 1
		updateUi()
		#TODO add delay
		resetBoard()

func updateUi():
	PlayerOScoreUi.text = str(playerOScore)
	PlayerXScoreUi.text = str(playerXScore)

func resetBoard():
	winner = 0
	for card in board:
		card.symbol = 0
		card.paintFace()
