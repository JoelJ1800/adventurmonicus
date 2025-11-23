class_name PlayerWeapons
extends CharacterWeapons


func _process (_delta : float):
	var mouse_pos : Vector2 = get_global_mouse_position()
	var mouse_dir : Vector2 = global_position.direction_to(mouse_pos)
	
	if current_weapon:
		current_weapon.set_aim_direction(mouse_dir)

		
		if Input.is_action_just_pressed("attack"):
			current_weapon._try_use()
	
	if current_shield:
		current_shield.set_aim_direction(mouse_dir)
		
		if Input.is_action_just_pressed("block"):
			toggle_shield(true)
		elif Input.is_action_just_released("block"):
			toggle_shield(false)
