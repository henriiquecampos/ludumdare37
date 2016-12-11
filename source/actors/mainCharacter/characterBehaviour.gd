extends Sprite

export (String, "normal", "defense", "exposed") var currentStance setget SetCurrentStance, GetCurrentStance
onready var actions = get_node("actionsComponent")

var actionType = ["punch","kick","defend"]
var health = 100
var actionQueue = []
var avaiableActions = 3 setget SetAvaiableActions
var defense
var comboBonus = 0

export (NodePath) var actionsInterfacePath
onready var actionsInterface = get_node(actionsInterfacePath)
export (NodePath) var healthBarPath
onready var healthBar = get_node(healthBarPath)

func _ready():
	SetCurrentStance("normal")
func ResetActions():
	avaiableActions = 3
func SetAvaiableActions(value):
	if avaiableActions <= 1:
		get_node("../turnController").ToggleTurn()
	elif value != 0:
		avaiableActions += value
	else:
		avaiableActions = 0
		
func SetCurrentStance(value):
	currentStance = value
	if value == "normal":
		defense = 0
	elif value == "defense":
		defense = -20
	elif value == "exposed":
		defense = 20
	
func GetCurrentStance():
	return
	
func DamageCharacter(value):
	health -= value
	if health > 0:
		print("health: " + str(health))
		healthBar.set_value(health)
		get_node("animator").play("getHit")
	elif health <= 0:
		healthBar.set_value(health)
		print("Game Over")

func _on_punchButton_released():
	SetAvaiableActions(-1)
	actionQueue.append(actionType[0])
func _on_kickButton_released():
	SetAvaiableActions(-1)
	actionQueue.append(actionType[1])
func _on_defenseButton_released():
	actionQueue.append(actionType[2])
	get_node("../turnController").ToggleTurn()
func _on_comboButton_released():
	if avaiableActions <3:
		print("you can't make a combo")
	else:
		comboBonus = 20
		get_node("comboComponent").MakeCombo()