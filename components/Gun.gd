extends Sprite


func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	position = mouse_pos
