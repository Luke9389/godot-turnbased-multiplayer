extends Node2D

@onready var location = $Location
@onready var location_2 = $Location2
@onready var location_3 = $Location3

var command_queue: CommandQueue

# Called when the node enters the scene tree for the first time.
func _ready():
	command_queue = CommandQueue.new(get_tree())


func _on_move_to_one_pressed():
	_queue_move_command.rpc(location.global_position)

func _on_move_to_two_pressed():
	_queue_move_command.rpc(location_2.global_position)


func _on_move_to_three_pressed():
	_queue_move_command.rpc(location_3.global_position)

@rpc('any_peer', 'call_local')
func _queue_move_command(_location):
	var _destination = _location + Vector2(70, 140)
	var command = MoveCommand.new($GameObject, _destination)
	command_queue.queue_up(command)


func _on_go_button_pressed():
	_run_queue.rpc()
	

@rpc('any_peer', 'call_local')
func _run_queue():
	command_queue.run()
