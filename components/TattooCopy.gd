extends Component


var _current_tattoo = []
var image = null


func _ready():
	._ready()


func on_state_changed(state: Dictionary)-> void:
	var current_tattoo = state["current_tattoo"]
	if _current_tattoo != current_tattoo:
		_current_tattoo = current_tattoo.duplicate()
		if current_tattoo.size() > 1:

			var lowest = Vector2(current_tattoo[0].x, current_tattoo[0].y)
			var highest = Vector2(0, 0)
			for point in current_tattoo:
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

			image = Image.new()
			image.create(width + 1, height + 1, false, Image.FORMAT_RGBA8)
			image.lock()
			image.fill(Color(0,0,0,0))
			for point in current_tattoo:
				image.lock()
				var x = point.x - lowest.x
				var y = point.y - lowest.y
				for xs in range(x, x+2):
					for ys in range(y, y+2):
						if xs < width + 1 and ys < height + 1:
							image.set_pixel(xs, ys, Color(0,0,0,255))

			var tat = _parent_node.get_node("../Tattoo")
			var real = tat.texture.get_data()

			image.resize(real.get_width(), real.get_height(), 0)
			image.unlock()

			var tex = ImageTexture.new()
			tex.create_from_image(image)

			_parent_node.texture = tex

			var total_pixels = 0
			var correct = 0
			for x in range(real.get_width()):
				for y in range(real.get_height()):
					image.lock()
					real.lock()
					var expected = real.get_pixel(x, y)
					var actual = image.get_pixel(x, y)
					real.unlock()
					image.unlock()

					if expected.a > 0:
						total_pixels += 1

						if actual.a > 0:
							correct += 1

			print(float(correct) / float(total_pixels) * 100)

