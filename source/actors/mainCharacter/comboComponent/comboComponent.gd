extends Node

var hits = 0

onready var parent = get_parent()
onready var turnController = parent.get_node("actionsComponent").turnController
func MakeCombo():
	randomize()
	hits = int(rand_range(2,6))
	for i in range (0,hits):
		parent.actionQueue.append(parent.actionType[randi(0,2)%2])
		print(parent.actionQueue)
	turnController.ResolveTurn()