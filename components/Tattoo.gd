extends Component


var _img_path: String = ""


func on_state_changed(state: Dictionary)-> void:
	var img_path = state["current_tattoo_design"]
	if _img_path != img_path:
		var tex = load(img_path)
		_parent_node.texture = tex

		_img_path = img_path
