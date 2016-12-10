extends Node
signal finishedAction
onready var turnController = get_tree().get_root().get_child(0).find_node("turnController")

func GenerateActionThereshold():
	randomize()
	var thereshold = randi(0,100)%100
	return thereshold
func ExecutePunch():
	var result = GenerateActionThereshold() - turnController.currentPlaying.defense
	if  result > 15:
		turnController.currentPlaying.DamageCharacter(15)
		get_parent().get_node("animator").play("testAnim")
		get_parent().actionQueue.pop_front()
	else:
		turnController.lastPlayed.SetCurrentStance("exposed")
		get_parent().actionQueue.clear()
		print("exposed")
	print(result)
func ExecuteKick():
	var result = GenerateActionThereshold() - turnController.currentPlaying.defense
	if result > 30:
		var damage = int(rand_range(10,21))
		turnController.currentPlaying.DamageCharacter(damage)
		get_parent().get_node("animator").play("testAnim")
		get_parent().actionQueue.pop_front()
	else:
		turnController.lastPlayed.SetCurrentStance("exposed")
		get_parent().actionQueue.clear()
		print("exposed")
func ExecuteDefense():
	print("you're a coward")
	turnController.lastPlayed.SetCurrentStance("defense")
	get_parent().actionQueue.clear()
func ExecuteCombo():
	pass
