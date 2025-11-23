class_name MeleeWeapon
extends Weapon

@export var damage : int
@export var hit_force : float

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var hit_box : Area2D = $Hitbox


func _use():
	anim.play("attack")

func detect_hits():
	for body in hit_box.get_overlapping_bodies():
		if body == owner_character:
			continue
		if body is not Character:
			continue
		var direction : Vector2 = global_position.direction_to(body.global_position)
		body.take_damage(damage, direction * hit_force)
