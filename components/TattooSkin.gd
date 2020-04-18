extends Component


var _tattoo: Array = []


func on_state_changed(state: Dictionary)-> void:
	var current_tattoo = state["current_tattoo"]
	if _tattoo.size() != current_tattoo.size():
		_tattoo = state["current_tattoo"].duplicate()
		update()


func _draw():
	for point in _tattoo:
		draw_rect(Rect2(point, Vector2(4,4)), Color(0, 0, 0))
