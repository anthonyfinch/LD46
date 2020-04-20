extends Component


export var shake = 1.0
var _gun_on = false


func on_state_changed(state):
	_gun_on = state["gun_on"]


func _process(delta):
	if _gun_on:
		_parent_node.set_offset(Vector2(
			rand_range(-1.0, 1.0) * shake,
			rand_range(-1.0, 1.0) * shake
		))
