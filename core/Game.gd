extends StateMachine


const Names = preload("res://core/Names.gd")
const MIN_MONEY = 40
const MAX_MONEY = 800
const SEC_PER_HOUR = 60  # Time dilation!
const CLOCK_SPEED = 5
const DAY_START = 10 * SEC_PER_HOUR
const DAY_END = 10.2 * SEC_PER_HOUR
const TOTAL_DAYS = 2

var _gun_on: bool = false
var _mouse_position: Vector2 = Vector2(0, 0)
var _current_tattoo: Array = []
var _current_tattoo_design: String = ""
var _previous_clients: Array = []
var _state: String = ""
var _tattoos: Array = []
var _design_image: Image = null
var _current_tattoo_image: Image = null
var _tattoo_price: int = MIN_MONEY
var _money: int = 0
var _day: int = 1
var _client_name: String = ""
var _time: float = DAY_START
var _time_display: String = ""
var _score: int = 0
var _client_info: Dictionary = {}


func _init(state: Dictionary)-> void:
	_gun_on = state.get("gun_on", false)
	_mouse_position = state.get("mouse_position", Vector2(0, 0))
	_current_tattoo = state.get("current_tattoo", [])
	_previous_clients = state.get("previous_clients", [])
	_state = state.get("state", "tattooing")
	_money = state.get("money", 0)
	_day = state.get("day", SharedData.day)
	_time = state.get("time", DAY_START)
	_client_name = state.get("client_name", "")
	_tattoo_price = state.get("tattoo_price", MIN_MONEY)
	_tattoos = state.get("tattoos", _get_tattoos())
	_client_info = state["client"]
	_choose_tattoo()
	_set_time_display()


func _reset():
	_time = DAY_START


func get_state() -> Dictionary:
	return {
		"gun_on": _gun_on,
		"mouse_position": _mouse_position,
		"current_tattoo": _current_tattoo,
		"previous_clients": _previous_clients,
		"tattoos": _tattoos,
		"current_tattoo_design": _current_tattoo_design,
		"current_tattoo_image": _current_tattoo_image,
		"money": _money,
		"day": _day,
		"time": _time,
		"client_name": _client_name,
		"tattoo_price": _tattoo_price,
		"time_display": _time_display,
		"score": _score,
		"state": _state
	}


func _choose_tattoo():
	var idx = round(rand_range(0, _tattoos.size() - 1))
	var tat = _tattoos[idx]

	_current_tattoo_design = tat
	_design_image = load(tat).get_data()

	_tattoo_price = round(rand_range(MIN_MONEY, MAX_MONEY))
	_client_name = Names.get_name()

	return tat


func _get_tattoos():
	var dir = Directory.new()
	var tattoos = []
	if dir.open("res://tattoos/") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if file_name != "." and file_name != ".." and not file_name.ends_with("import"):
				tattoos.push_back("res://tattoos/" + file_name)
			file_name = dir.get_next()

	return tattoos


func _set_time_display():
	var hours = _time / SEC_PER_HOUR
	var minutes = fmod(_time, SEC_PER_HOUR)
	var min_string = String(floor(minutes))
	if minutes < 10:
		min_string = "0" + min_string
	_time_display = String(floor(hours)) + ":" + min_string


func handle_update(payload: Dictionary)-> void:
	var delta = payload["delta"]

	if not ["start", "end"].has(_state):
		_time += delta * CLOCK_SPEED
		_set_time_display()

	if _time >= DAY_END:
		_gun_on = false
		_state = "end"

	if _state == "tattooing":
		if _gun_on:
			if not _current_tattoo.has(_mouse_position):
				_current_tattoo.push_back(_mouse_position)


func handle_gun_on(payload: Dictionary)-> void:
	if _state == "tattooing":
		_gun_on = true


func handle_gun_off(payload: Dictionary)-> void:
	if _state == "tattooing":
		_gun_on = false


func handle_set_mouse_position(payload: Dictionary)-> void:
	_mouse_position = payload["position"]


func handle_finish_tattoo(payload: Dictionary)-> void:
	_state = "scoring"

	if _current_tattoo.size() > 1:
		var lowest = Vector2(_current_tattoo[0].x, _current_tattoo[0].y)
		var highest = Vector2(0, 0)
		for point in _current_tattoo:
			if lowest.x > point.x:
				lowest.x = point.x
			if lowest.y > point.y:
				lowest.y = point.y
			if highest.x < point.x:
				highest.x = point.x
			if highest.y < point.y:
				highest.y = point.y

		var width = highest.x - lowest.x
		var height = highest.y - lowest.y

		var image = Image.new()
		image.create(width + 1, height + 1, false, Image.FORMAT_RGBA8)
		image.lock()
		image.fill(Color(0,0,0,0))
		for point in _current_tattoo:
			image.lock()
			var x = point.x - lowest.x
			var y = point.y - lowest.y
			for xs in range(x, x+2):
				for ys in range(y, y+2):
					if xs < width + 1 and ys < height + 1:
						image.set_pixel(xs, ys, Color(0,0,0,255))



		image.resize(_design_image.get_width(), _design_image.get_height(), 0)
		image.unlock()
		_current_tattoo_image = image

		var total_pixels = 0
		var correct = 0
		for x in range(_design_image.get_width()):
			for y in range(_design_image.get_height()):
				image.lock()
				_design_image.lock()
				var expected = _design_image.get_pixel(x, y)
				var actual = image.get_pixel(x, y)
				_design_image.unlock()
				image.unlock()

				if expected.a > 0:
					total_pixels += 1

					if actual.a > 0:
						correct += 1

		var pc = float(correct) / float(total_pixels)
		_score =  pc * 100
		_money += pc * _tattoo_price
	else:
		_score = 0


func handle_next_client(payload: Dictionary)-> void:
	if _current_tattoo.size() > 0:
		_previous_clients.push_back(_current_tattoo)
		_current_tattoo = []
		_current_tattoo_image = null
	_choose_tattoo()
	_state = "tattooing"


func handle_next_day(payload: Dictionary)-> void:
	match _state:
		"end":
			_day += 1
			if _day > TOTAL_DAYS:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				ServiceRegister.clear()
				SceneSwitcher.goto_scene("res://scenes/End.tscn")
			_state = "start"
			_reset()

		"start":
			handle_next_client({})
