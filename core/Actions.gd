extends Node

var store = null


func dispatch(action: String, payload: Dictionary)-> void:
	if store != null:
		store.dispatch(action, payload)


func update(delta):
	dispatch("update", {"delta": delta})


func gun_on():
	dispatch("gun_on", {})


func gun_off():
	dispatch("gun_off", {})


func set_mouse_position(position):
	dispatch("set_mouse_position", {"position": position})


func finish_tattoo():
	dispatch("finish_tattoo", {})
