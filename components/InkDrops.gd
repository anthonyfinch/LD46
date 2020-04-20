extends Component


var _gun_on = false


func on_state_changed(state):
	var on = state["gun_on"]
	if on != _gun_on:
		_gun_on = on
		_parent_node.emitting = on
