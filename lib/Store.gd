extends Node

class_name Store


var _state = {}
var _machine = null


signal state_changed(state)
signal on_command(command)


func create(machine):
	_machine = machine
	_state = _machine.get_state()["state"]


func subscribe(target, method):
	connect('state_changed', target, method)


func unsubscribe(target, method):
	disconnect('state_changed', target, method)


func dispatch(action, payload):
	_machine.handle(action, payload)
	var result = _machine.get_state()

	var next_state = result.get("state")
	var commands = result["commands"]
	if _state != null:
		_state = next_state
		emit_signal('state_changed', next_state)
	if commands.size() > 0:
		for command in commands:
			emit_signal("on_command", command)


func get_state():
	return _state
