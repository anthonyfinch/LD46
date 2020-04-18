extends Node

var store = null


func dispatch(action: String, payload: Dictionary)-> void:
	if store != null:
		store.dispatch(action, payload)


func update(delta):
	dispatch("update", {"delta": delta})
