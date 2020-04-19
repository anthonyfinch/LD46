extends Node


const Store = preload('res://lib/Store.gd')
const Actions = preload('res://core/Actions.gd')
const Game = preload('res://core/Game.gd')
const ViewMapper = preload("res://core/ViewMapper.gd")
onready var _input = get_node("Input")
var _actions: Actions = null
var _view_mapper: ViewMapper = null


func _ready():
	randomize()

	var state = {}
	_view_mapper = ViewMapper.new()
	add_child(_view_mapper) # So it can have access to the tree
	_view_mapper.build_state(state)

	var machine = Game.new(state)
	var store = Store.new()
	_actions = Actions.new()

	store.create(machine)
	ServiceRegister.register("store", store)

	_actions.store = store
	ServiceRegister.register("actions", _actions)

	_input.actions = _actions

	store.subscribe(self, "handle_change")


func _process(delta):
	_actions.update(delta)


func handle_change(state):
	pass
