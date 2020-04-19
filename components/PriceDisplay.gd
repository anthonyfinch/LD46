extends Component


var _tattoo_price: int = 0


func _ready():
	._ready()
	_parent_node.text = "Price: " + String(_tattoo_price)


func on_state_changed(state: Dictionary)-> void:
	var new_tattoo_price = state["tattoo_price"]
	if new_tattoo_price != _tattoo_price:
		_tattoo_price = new_tattoo_price
		_parent_node.text = "Price: " + String(new_tattoo_price)
