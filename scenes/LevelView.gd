extends Component


var _state: String = ""
var _next_button = null
var _finish_button = null
var _client = null
var _tattoo_done = null
var _score = null


func _ready():
	._ready()
	_next_button = _parent_node.get_node("NextButton")
	_finish_button = _parent_node.get_node("FinishButton")
	_client = _parent_node.get_node("Person")
	_tattoo_done = _parent_node.get_node("TattooDone")
	_score = _parent_node.get_node("Score")


func on_state_changed(state: Dictionary)-> void:
	var new_state = state["state"]
	if _state != new_state:

		match new_state:
			"tattooing":
				_next_button.visible = false
				_finish_button.visible = true
				_client.visible = true
				_tattoo_done.visible = false
				_score.visible = false
			"scoring":
				_next_button.visible = true
				_finish_button.visible = false
				_client.visible = false
				_tattoo_done.visible = true
				_score.visible = true

