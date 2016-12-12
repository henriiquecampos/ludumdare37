extends Node
signal finishedAction
onready var turnController = get_node("../../turnController")

var result = 0
func GenerateActionResult():
	randomize()
	var thereshold = randi(0,101)%101
	result = thereshold - turnController.currentPlaying.defense - turnController.lastPlayed.comboBonus
func ExecutePunch():
	GenerateActionResult()
	if  result < 75:
		get_parent().get_node("animator").play("punch")
		get_parent().actionQueue.pop_front()
	else:
		get_parent().actionQueue.clear()
		turnController.lastPlayed.SetCurrentStance("exposed")
		get_parent().get_node("animator").play("exposed")
	result = 0
func ExecuteKick():
	GenerateActionResult()
	if result < 50:
		var damage = int(rand_range(10,21))
		get_parent().get_node("animator").play("kick")
		get_parent().actionQueue.pop_front()
	else:
		get_parent().actionQueue.clear()
		turnController.lastPlayed.SetCurrentStance("exposed")
		get_parent().get_node("animator").play("exposed")
	result = 0
func ExecuteDefense():
	GenerateActionResult()
	if result < 60:
		turnController.lastPlayed.SetCurrentStance("defense")
		get_parent().get_node("animator").play("defend")
		get_parent().actionQueue.clear()
	else:
		get_parent().actionQueue.clear()
		turnController.lastPlayed.SetCurrentStance("exposed")
		get_parent().get_node("animator").play("exposed")
func ExecuteCombo():
	pass
