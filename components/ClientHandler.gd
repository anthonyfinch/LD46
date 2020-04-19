extends Component


func _ready()-> void:
	._ready()
	add_to_group("has_view_data")


func build_data(state: Dictionary)-> Dictionary:
	state["client"] = {
		"position": _parent_node.position,
		"rect": _parent_node.get_rect(),
		"image": _parent_node.texture.get_data()
	}
	return state
