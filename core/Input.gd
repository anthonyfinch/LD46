extends Node


var actions = null


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _input(event):
	if (event.is_action_pressed("ui_cancel")):
		get_tree().quit()


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				actions.gun_on()
			else:
				actions.gun_off()


func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	actions.set_mouse_position(mouse_pos)
