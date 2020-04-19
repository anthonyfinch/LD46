extends Component


var _day: int = 0


func _ready():
	._ready()
	_parent_node.text = "Day: " + String(_day)


func on_state_changed(state: Dictionary)-> void:
	var new_day = state["day"]
	if new_day != _day:
		_day = new_day
		_parent_node.text = "Day: " + String(new_day)
