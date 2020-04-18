extends Node

class_name Component


var _cached_data = {}
onready var _parent_node = get_node("..")


func _ready():
	ServiceRegister.on_register("store", self, "on_store_load")


func on_store_load(store):
	store.connect("state_changed", self, "on_state_changed")


func on_state_changed(data):
	pass
