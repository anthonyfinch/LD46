extends StateMachine


func _init(state: Dictionary)-> void:
	pass


func get_state() -> Dictionary:
	return {}


func handle_update(payload: Dictionary)-> void:
	var delta = payload["delta"]
	print(delta)
