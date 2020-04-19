extends Node


func build_state(state: Dictionary)-> Dictionary:
	var view_mappers = get_tree().get_nodes_in_group("has_view_data")
	for mapper in view_mappers:
		state = mapper.build_data(state)

	return state
