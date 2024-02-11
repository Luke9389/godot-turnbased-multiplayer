class_name Command
extends Node

signal complete

@export var undoable = false


func _done():
	complete.emit()
