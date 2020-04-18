extends Component


const Ink = preload("res://components/Ink.tscn")
var _tattoo: Array = []


func on_state_changed(state: Dictionary)-> void:
	_tattoo = state["current_tattoo"]
	update()


func _draw():
	for point in _tattoo:
		draw_rect(Rect2(point, Vector2(4,4)), Color(0, 0, 0))
