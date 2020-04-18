extends Node2D

class_name Component


var _cached_data = {}
var _actions = null
onready var _parent_node = get_node("..")


func _ready():
	ServiceRegister.on_register("store", self, "on_store_load")
	ServiceRegister.on_register("actions", self, "on_actions_load")


func on_store_load(store):
	store.connect("state_changed", self, "on_state_changed")


func on_actions_load(actions):
	_actions = actions


func on_state_changed(data):
	pass
