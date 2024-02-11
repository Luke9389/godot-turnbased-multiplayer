class_name MoveCommand
extends Command

var _target: Node2D
var _destination: Vector2
var _orig_rest_point: Vector2
var _teleport: bool

func _init(p_target_card: Node2D, p_destination: Vector2, p_should_teleport: bool = false):
	self._target = p_target_card
	self._destination = p_destination
	self._teleport = p_should_teleport
	self.undoable = true


func run(_tree):
	# TODO: Look for pre-move Ability on target
	if _teleport:
		_target.global_position = _destination

	# Save current rest point for later use by undo
	if _target.rest_point:
		self._orig_rest_point = _target.rest_point

	# Set the destination and let the card move there
	_target.rest_point = _destination
	_target.is_on_rest_point = false
	await _target.got_to_rest_point

	self._done()
	# TODO: Look for post-move Ability on target


func undo():
	_target.rest_point = _orig_rest_point
	_target.is_on_rest_point = false
	await _target.got_to_rest_point
	
	self._done()
