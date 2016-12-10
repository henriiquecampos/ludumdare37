extends Sprite

enum characterStances {NORMAL, DEFENSE,EXPOSED}
export (int) var currentStance setget SetCurrentStance, GetCurrentStance

var health = 100
var actionQueue = []
var avaiableActions = 3 setget SetAvaiableActions

func ResetActions():
	avaiableActions = 3
	print(avaiableActions)
func SetAvaiableActions(value):
	if avaiableActions <= 1:
		get_node("../turnController").ToggleTurn()
	elif value != 0:
		avaiableActions += value
	else:
		avaiableActions = 0
		get_node("../turnController").ToggleTurn()
		

func SetCurrentStance(value):
	currentStance = value
	
func GetCurrentStance():
	return
	
func DamageCharacter(value):
	health -= value
	get_node("healthBar").set_value(health)

func _on_punchButton_released():
	SetAvaiableActions(-1)

func _on_kickButton_released():
	SetAvaiableActions(-1)

func _on_defenseButton_released():
	SetAvaiableActions(-1)

func _on_comboButton_released():
	if avaiableActions <3:
		print("You can't do a combo")
	else:
		SetAvaiableActions(0)
		print("You made a combo")