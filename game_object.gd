extends Sprite2D

@export var rest_point: Vector2
@export var is_on_rest_point: bool

signal got_to_rest_point

func _physics_process(_delta):
	if rest_point && is_on_rest_point:
		global_position = rest_point
	
	if rest_point && !is_on_rest_point:
		global_position = lerp(global_position, rest_point, 0.3)
		if global_position.distance_to(rest_point) < 1:
			is_on_rest_point = true
			got_to_rest_point.emit()
