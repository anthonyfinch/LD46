extends SceneTree


var image_matrix = []


func _init():
	var tex = load("res://components/test-image.png")
	var img = tex.get_data()
	print(img.get_format())

	image_matrix.resize(img.get_width())
	for x in range(img.get_width()):
		var new_col = []
		new_col.resize(img.get_height())
		image_matrix[x] = new_col
		for y in range(img.get_height()):
			image_matrix[x][y] = false

	print(image_matrix)
	var bs = img.get_data()

	print(bs.size())
	print("Bytes")
	for b in bs:
		print(b)
