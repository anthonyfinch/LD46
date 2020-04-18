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

			# var matrix = []
			# matrix.resize(height + 1)
			# var column_proto = []
			# column_proto.resize(width + 1)

			# for y in range(height + 1):
			# 	matrix[y] = column_proto.duplicate()

			# for point in current_tattoo:
			# 	var x = point.x - lowest.x
			# 	var y = point.y - lowest.y
			# 	matrix[y][x] = true

			# var buffer = PoolByteArray()

			# for y in range(height + 1):
			# 	for x in range(width + 1):
			# 		var value = matrix[y][x]
			# 		buffer.push_back(0)
			# 		buffer.push_back(0)
			# 		buffer.push_back(0)
			# 		if value != null:
			# 			buffer.push_back(255)
			# 		else:
			# 			buffer.push_back(0)


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

			# var p_b = PoolByteArray(buffer)
			# for b in p_b:
			# 	print(b)
			# var err = image.load_png_from_buffer(buffer)
			# print(err)

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

			print(correct)
			print(total_pixels)
			print(float(correct) / float(total_pixels) * 100)
			print("COrrect: ", correct / total_pixels * 100)

