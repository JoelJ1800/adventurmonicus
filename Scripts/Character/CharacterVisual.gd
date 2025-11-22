class_name CharacterVisual
extends Sprite2D

@export var charater: Character

@export var wobble_speed : float = 15
@export var wobble_amount : float = 5

func _process(delta: float) -> void:
	flip_h = charater.look_direction.x < 0
	
	var target_rot : float = 0
	if charater.velocity.length() > 1:
		var time = Time.get_unix_time_from_system()
		target_rot = sin(time * wobble_speed) * wobble_amount
	rotation_degrees = lerpf(rotation_degrees, target_rot, delta * 20)
