extends Component


func _ready():
	._ready()
	_parent_node.connect("pressed", self, "handle_button_press")


func handle_button_press():
	_actions.next_day()
