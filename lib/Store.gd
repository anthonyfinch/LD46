extends Node

class_name Store


signal state_changed(state)


var _state = {}
var _machine = null


func create(machine):
	_machine = machine
	_state = _machine.get_state()


func subscribe(target, method):
	connect('state_changed', target, method)


func unsubscribe(target, method):
	disconnect('state_changed', target, method)


func dispatch(action, payload):
	_machine.handle(action, payload)
	var next_state = _machine.get_state()
	_state = next_state
	emit_signal('state_changed', next_state)


func get_state():
	return _state
