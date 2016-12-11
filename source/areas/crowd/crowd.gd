extends Node2D

export (NodePath) var crowdPosPath
onready var crowdPos = get_node(crowdPosPath)
func _ready():
	var crowdChildren = crowdPos.get_children()
	for i in range(0,crowdPos.get_child_count()):
		randomize()
		var whichChild = crowdChildren[randi(0,crowdChildren.size())%crowdChildren.size()]
		if whichChild.is_in_group("flip"):
			get_child(i).set_flip_h(true)
			get_child(i).set_offset(Vector2(get_child(i).get_offset().x * -1, get_child(i).get_offset().y))
		get_child(i).set_pos(whichChild.get_pos())
		get_child(i).set_z(whichChild.get_z())
		if get_child(i).get_z() == 3:
			get_child(i).set_modulate(Color(0.8,0.8,0.8))
		elif get_child(i).get_z() == 2:
			get_child(i).set_modulate(Color(0.6,0.6,0.6))
		elif get_child(i).get_z() == 1:
			get_child(i).set_modulate(Color(0.3,0.3,0.3))
		elif get_child(i).get_z() == 4:
			get_child(i).set_modulate(Color(0.9,0.9,0.9))
		crowdChildren.remove(crowdChildren.find(whichChild))