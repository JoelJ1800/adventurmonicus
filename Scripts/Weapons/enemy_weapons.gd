class_name EnemyWeapons
extends CharacterWeapons

@onready var me: Enemy = $".."


func _process(_delta: float) -> void:
	if not current_weapon:
		return
	if me == null:
		print("Error: 'me' (parent Enemy) is null!")
		return

	if me.target == null:
		print("Error: Enemy's target is null!")
		return
	var target_dir: Vector2 = global_position.direction_to(me.target.global_position)
	var target_dist: float = global_position.distance_to(me.target.global_position)

	current_weapon.set_aim_direction(target_dir)
	if target_dist <= current_weapon.weapon_range:
		current_weapon._try_use()
