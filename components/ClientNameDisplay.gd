extends Component


var _client_name: String = ""


func _ready():
	._ready()
	_parent_node.text = "Client_Name: " + _client_name


func on_state_changed(state: Dictionary)-> void:
	var new_client_name = state["client_name"]
	if new_client_name != _client_name:
		_client_name = new_client_name
		_parent_node.text = "Client_Name: " + new_client_name
