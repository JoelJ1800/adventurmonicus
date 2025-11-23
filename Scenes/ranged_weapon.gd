class_name  RangedWeapon
extends Weapon

@export var projectile_scene : PackedScene
@onready var muzzle : Node2D = $Muzzle

func _use():
	var projectile: Projectile = projectile_scene.instantiate()
	get_tree().root.get_node("/root/Main").add_child(projectile)
	projectile.global_position = muzzle.global_position
	projectile.global_rotation = muzzle.global_rotation
	
	projectile.initialize(owner_character)
