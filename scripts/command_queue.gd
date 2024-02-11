class_name CommandQueue
extends Command

signal sub_command_complete

var tree: SceneTree

var _queue: Array[Command] = []
var _history: Array[Command] = []

func _init(scene_tree):
	self.tree = scene_tree
	self.connect("sub_command_complete", check_for_next)


# Where the current command is running
func run():
	# Run the command, providing tree context
	var command := _queue[0]
	command.run(tree)
	await command.complete

	# Add to history if undoable
	if command.undoable:
		_history.push_front(command)
	else:
		_history.clear()

	# Remove from queue
	_queue.remove_at(0)

	emit_signal("sub_command_complete")


func undo():
	if !_history.size():
		return
	var command = _history[0]
	if !command.undoable:
		return
	command.undo()
	await command.complete
	_history.remove_at(0)


# How to add new commands
func queue_up(command: Command):
	self._queue.push_back(command)


# Allows the continuation of running the queue or signals completion
func check_for_next():
	if _queue.size():
		run()
	else:
		self._done()
