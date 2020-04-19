extends Component


var _money: int = 0


func _ready():
	._ready()
	_parent_node.text = "Money: " + String(_money) + " / 1000"


func on_state_changed(state: Dictionary)-> void:
	var new_money = state["money"]
	if new_money != _money:
		_money = new_money
		_parent_node.text = "Money: " + String(new_money) + " / 1000"
