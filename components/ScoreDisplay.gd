extends Component


var _score: int = 0


func _ready():
	._ready()
	_parent_node.text = "Score: " + String(_score)


func on_state_changed(state: Dictionary)-> void:
	var new_score = state["score"]
	if new_score != _score:
		print(new_score)
		_score = new_score
		_parent_node.text = "Score: " + String(new_score)
