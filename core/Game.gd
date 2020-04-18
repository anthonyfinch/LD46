extends StateMachine


var _gun_on: bool = false
var _mouse_position: Vector2 = Vector2(0, 0)
var _current_tattoo: Array = []


func _init(state: Dictionary)-> void:
	_gun_on = state.get("gun_on", false)
	_mouse_position = state.get("mouse_position", Vector2(0, 0))
	_current_tattoo = state.get("current_tattoo", [])


func get_state() -> Dictionary:
	return {
		"gun_on": _gun_on,
		"mouse_position": _mouse_position,
		"current_tattoo": _current_tattoo
	}


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
