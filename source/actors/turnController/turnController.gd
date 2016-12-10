extends Label

export (String,"playerOne", "playerTwo") var turn setget SetTurn

func _ready():
	SetTurn("playerOne")
func SetTurn(value):
	turn = value
	if value != null:
		set_text(value)
		if turn == "playerOne":
			get_node("../playerTwo/actionsInterface").set_hidden(true)
			get_node("../playerOne/actionsInterface").set_hidden(false)
			get_node("../playerTwo").ResetActions()
		elif turn == "playerTwo":
			get_node("../playerOne/actionsInterface").set_hidden(true)
			get_node("../playerTwo/actionsInterface").set_hidden(false)
			get_node("../playerOne").ResetActions()

func ToggleTurn():
	if turn == "playerOne":
		SetTurn("playerTwo")
	elif turn == "playerTwo":
		SetTurn("playerOne")