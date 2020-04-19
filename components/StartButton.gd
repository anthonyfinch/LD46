extends TextureButton


func _ready():
	connect("pressed", self, "handle_button_press")


func handle_button_press():
	SceneSwitcher.goto_scene("res://scenes/Level.tscn")
