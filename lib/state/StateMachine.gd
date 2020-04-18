extends Node

class_name StateMachine


var _internal_state = null


func get_state()-> Dictionary:
	return {
		"state": {},
		"commmands": []
	}


func handle(event: String, payload: Dictionary) -> void:
	var e_name = event.to_lower()
	var h_name = "handle_{0}".format([e_name])

	if self.has_method(h_name):
		self.call(h_name, payload)


func delegate(method: String, args: Dictionary = {})-> void:
	if _internal_state != null and _internal_state.has_method(method):
		var new_state = _internal_state.call(method, args)
		if new_state != null:
			_internal_state.exit()
			new_state.enter(self)
			_internal_state = new_state
