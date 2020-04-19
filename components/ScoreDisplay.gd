extends Component


var _score: int = 0


func _ready():
	._ready()
	_parent_node.text = "Score: " + String(_score)


func _make_score_text(score, price):
	return "Accuracy: " + String(score) + "% - you earned: " + String(score * price / 100)


func on_state_changed(state: Dictionary)-> void:
	var new_score = state["score"]
	if new_score != _score:
		var _price: int = state["tattoo_price"]
		_score = new_score
		_parent_node.text = _make_score_text(new_score, _price)
