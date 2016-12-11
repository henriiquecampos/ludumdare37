extends Node

onready var queue = get_parent().actionQueue
onready var turnController = get_parent().get_node("actionsComponent").turnController
var alreadyPressed = false
var action
var generatedInputs = []

func GenerateComboInputs():
	randomize()
	for i in range(0,queue.size()):
		action = InputMap.get_action_from_id(int(rand_range(12,20)))
		generatedInputs.append(action)
	print(generatedInputs)
	set_process(true)
	set_process_input(true)
	get_node("Timer").start()

func _process(delta):
	if get_node("Timer").get_time_left() > 0:
		if generatedInputs.size() > 0:
			if Input.is_action_just_pressed(generatedInputs[0]):
				print("CORRECT")
				generatedInputs.pop_front()
		elif generatedInputs.size() == 0:
			get_node("Timer").stop()
			turnController.ToggleTurn()
				
	else:
		set_process(false)
func _input(event):
	if generatedInputs.size() > 0:
		if event.type == InputEvent.KEY:
			if not event.is_action(generatedInputs[0]) and not alreadyPressed:
				get_parent().actionQueue.clear()
				generatedInputs.clear()
				set_process(false)
				get_node("Timer").stop()
				set_process_input(false)
				turnController.ToggleTurn()
func _on_Timer_timeout():
	print("timed out")
	generatedInputs.clear()
	get_parent().actionQueue.clear()
	turnController.ToggleTurn()