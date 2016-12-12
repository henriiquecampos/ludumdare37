extends Label
signal turnChanged
export (String,"playerOne", "playerTwo") var turn setget SetTurn
var currentPlaying
var lastPlayed
func _ready():
	SetTurn("playerOne")

func SetTurn(value):
	turn = value
	if value != null:
		SetCurrentPlayer()

func ToggleTurn():
	if turn == "playerOne":
		SetTurn("playerTwo")
	elif turn == "playerTwo":
		SetTurn("playerOne")
	ResolveTurn()

func ResolveTurn():
	if lastPlayed.actionQueue.size() > 0:
		if lastPlayed.actionQueue[0] == "punch":
			lastPlayed.actions.ExecutePunch()
		elif lastPlayed.actionQueue[0] == "kick":
			lastPlayed.actions.ExecuteKick()
		elif lastPlayed.actionQueue[0] == "defend":
			lastPlayed.actions.ExecuteDefense()
	elif lastPlayed.comboBonus < 10:
		lastPlayed.get_node("animator").play("idle")
		pass
	lastPlayed.comboBonus = 0
	emit_signal("turnChanged")
func SetCurrentPlayer():
		if turn == "playerOne":
			currentPlaying = get_node("../playerOne")
			lastPlayed = get_node("../playerTwo")
		elif turn == "playerTwo":
			currentPlaying = get_node("../playerTwo")
			lastPlayed = get_node("../playerOne")
		currentPlaying.actionQueue.clear()
		lastPlayed.actionsInterface.set_hidden(true)
		currentPlaying.actionsInterface.set_hidden(false)
		lastPlayed.ResetActions()
		currentPlaying.actionsInterface.set_hidden(false)
		currentPlaying.currentStance = "normal"