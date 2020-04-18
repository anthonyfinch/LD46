extends Node


var _services = {}
var _listeners = {}


func register(name, service):
	_services[name] = service
	var listeners = _listeners.get(name)
	if listeners != null:
		for listener in listeners:
			listener.call_func(service)


func get(name):
	return _services.get(name)


func on_register(name, object, method):
	var f_ref = funcref(object, method)
	if name in _services:
		f_ref.call_func(get(name))
	else:
		var listeners = _listeners.get(name)
		if listeners == null:
			listeners = []
		listeners.push_back(f_ref)
		_listeners[name] = listeners
