extends StateMachine


var _gun_on: bool = false
var _mouse_position: Vector2 = Vector2(0, 0)
var _current_tattoo: Array = []
var _current_tattoo_design: String = ""
var _previous_clients: Array = []
var _state: String = ""
var _tattoos: Array = []
var _current_tattoo_image: Image = null


func _init(state: Dictionary)-> void:
	_gun_on = state.get("gun_on", false)
	_mouse_position = state.get("mouse_position", Vector2(0, 0))
	_current_tattoo = state.get("current_tattoo", [])
	_previous_clients = state.get("previous_clients", [])
	_state = state.get("state", "tattooing")
	_tattoos = state.get("tattoos", _get_tattoos())
	_current_tattoo_design = state.get("current_tattoo_design", _choose_tattoo())
	_load_tattoo_design()


func get_state() -> Dictionary:
	return {
		"gun_on": _gun_on,
		"mouse_position": _mouse_position,
		"current_tattoo": _current_tattoo,
		"previous_clients": _previous_clients,
		"tattoos": _tattoos,
		"current_tattoo_design": _current_tattoo_design,
		"state": _state
	}


func _choose_tattoo():
	var idx = rand_range(0, _tattoos.size())
	return _tattoos[idx]


func _load_tattoo_design():
	_current_tattoo_image = load(_current_tattoo_design)
	print(_current_tattoo_image)


func _get_tattoos():
	var dir = Directory.new()
	var tattoos = []
	if dir.open("res://tattoos/") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if file_name != "." and file_name != ".." and not file_name.ends_with("import"):
				tattoos.push_back("res://tattoos/" + file_name)
			file_name = dir.get_next()

	return tattoos


func handle_update(payload: Dictionary)-> void:
	var delta = payload["delta"]
	if _gun_on:
		if not _current_tattoo.has(_mouse_position):
			_current_tattoo.push_back(_mouse_position)


func handle_gun_on(payload: Dictionary)-> void:
	_gun_on = true


func handle_gun_off(payload: Dictionary)-> void:
	_gun_on = false


func handle_set_mouse_position(payload: Dictionary)-> void:
	_mouse_position = payload["position"]


func handle_finish_tattoo(payload: Dictionary)-> void:
	_state = "scoring"


func handle_next_client(payload: Dictionary)-> void:
	_previous_clients.push_back(_current_tattoo)
	_current_tattoo = []
	_state = "tattooing"
