extends Node

var hits = 0

onready var parent = get_parent()
onready var turnController = parent.get_node("actionsComponent").turnController
onready var inputSolver = parent.get_node("inputResolver")
func MakeCombo():
	parent.actionsInterface.set_hidden(true)
	parent.comboBonus = 20
	randomize()
	hits = int(rand_range(2,6))
	for i in range (0,hits):
		parent.actionQueue.append(parent.actionType[randi(0,2)%2])
	inputSolver.GenerateComboInputs()