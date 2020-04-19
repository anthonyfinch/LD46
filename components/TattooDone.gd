extends Component


var _image: Image = null
var _state: String = ""


func on_state_changed(state: Dictionary)-> void:
	var new_state = state["state"]
	if new_state != _state:
		_state = new_state
		match new_state:
			"scoring":
				var tex = ImageTexture.new()
				tex.create_from_image(state["current_tattoo_image"])
				_parent_node.texture = tex

