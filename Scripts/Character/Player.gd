class_name Player
extends Character

func _process(_delta: float) -> void:
	move_input = Input.get_vector("move_left","move_right","move_up","move_down")
	
	var mouse_pos: Vector2 = get_global_mouse_position()
	look_direction = global_position.direction_to(mouse_pos)
