extends Component


var _tattoo: Array = []


func on_state_changed(state: Dictionary)-> void:
	var current_tattoo = state["current_tattoo"]
	if _tattoo.size() != current_tattoo.size():
		_tattoo = state["current_tattoo"].duplicate()
		update()


func _draw():
	var local_pos = _parent_node.position
	for point in _tattoo:
		var pos = point - local_pos
		draw_rect(Rect2(pos - Vector2(4,4), Vector2(4,4)), Color(0, 0, 0))
