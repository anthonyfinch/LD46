extends Component


var _state: String = ""
var _tattooing = null
var _scoring = null
var _end = null
var _start = null
var _client = null


func _ready():
	._ready()
	_tattooing = _parent_node.get_node("Tattooing")
	_scoring = _parent_node.get_node("Scoring")
	_start = _parent_node.get_node("LevelStart")
	_end = _parent_node.get_node("LevelEnd")
	_client = _parent_node.get_node("ClientContainer")


func on_state_changed(state: Dictionary)-> void:
	var new_state = state["state"]
	if _state != new_state:

		match new_state:
			"tattooing":
				_tattooing.visible = true
				_scoring.visible = false
				_end.visible = false
				_start.visible = false
			"scoring":
				_tattooing.visible = false
				_scoring.visible = true
				_end.visible = false
				_start.visible = false
			"end":
				_tattooing.visible = false
				_scoring.visible = false
				_end.visible = true
				_start.visible = false
			"start":
				_tattooing.visible = false
				_scoring.visible = false
				_end.visible = false
				_start.visible = true
