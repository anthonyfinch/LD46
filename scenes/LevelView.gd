extends Component


var _state: String = ""
var _tattooing = null
var _scoring = null
var _client = null


func _ready():
	._ready()
	_tattooing = _parent_node.get_node("Tattooing")
	_scoring = _parent_node.get_node("Scoring")
	_client = _parent_node.get_node("Client")


func on_state_changed(state: Dictionary)-> void:
	var new_state = state["state"]
	if _state != new_state:

		match new_state:
			"tattooing":
				_tattooing.visible = true
				_scoring.visible = false
				_client.visible = true
			"scoring":
				_tattooing.visible = false
				_scoring.visible = true
				_client.visible = false
