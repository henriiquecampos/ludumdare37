extends Node

signal correctHit
onready var queue = get_parent().actionQueue
onready var turnController = get_parent().get_node("actionsComponent").turnController
export (NodePath) var comboInterfacePath
onready var comboInterface = get_node(comboInterfacePath)
var alreadyPressed = false
var action
var generatedInputs = []

func GenerateComboInputs():
	comboInterface.set_hidden(false)
	comboInterface.get_child(1).set_max(get_node("Timer").get_wait_time())
	randomize()
	for i in range(0,queue.size()):
		action = InputMap.get_action_from_id(int(rand_range(12,20)))
		generatedInputs.append(action)
		var button = TextureFrame.new()
		comboInterface.get_child(0).add_child(button)
		button.set_texture(load("res://actors/inputResolver/"+action+".png"))
	print(generatedInputs)
	set_process(true)
	set_process_input(true)
	get_node("Timer").start()

func _process(delta):
	comboInterface.get_child(1).set_value(get_node("Timer").get_time_left())
	if get_node("Timer").get_time_left() > 0:
		if generatedInputs.size() > 0:
			if Input.is_action_just_pressed(generatedInputs[0]):
				print("CORRECT")
				emit_signal("correctHit")
			elif Input.is_action_just_released(generatedInputs[0]):
				generatedInputs.pop_front()
		elif generatedInputs.size() == 0:
			get_node("Timer").stop()
			turnController.ToggleTurn()
				
	else:
		set_process(false)
func _input(event):
	#print("Inputing" + str(event))
	if generatedInputs.size() > 0:
		if event.type == InputEvent.KEY:
			if not event.is_action(generatedInputs[0]):
				get_parent().get_node("animator").play("exposed")
				turnController.currentPlaying.SetCurrentStance("exposed")
				get_parent().actionQueue.clear()
				generatedInputs.clear()
				set_process(false)
				get_node("Timer").stop()
				set_process_input(false)
				turnController.ToggleTurn()
func _on_Timer_timeout():
	print("timed out")
	get_parent().get_node("animator").play("exposed")
	turnController.currentPlaying.SetCurrentStance("exposed")
	generatedInputs.clear()
	get_parent().actionQueue.clear()
	turnController.ToggleTurn()