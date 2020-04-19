extends Component


var _time_display: String = ""


func _ready():
	._ready()
	_parent_node.text = _time_display


func on_state_changed(state: Dictionary)-> void:
	var new_time_display = state["time_display"]
	if new_time_display != _time_display:
		_time_display = new_time_display
		_parent_node.text = new_time_display
