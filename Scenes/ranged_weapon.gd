class_name  RangedWeapon
extends Weapon

@export var projectile_scene : PackedScene
@export var projectile_item : ItemData
@onready var muzzle : Node2D = $Muzzle

func _has_projectile_item () -> bool:
	#npcs have infinite arrows
	if owner_character is not Player:
		return true
	if (owner_character as Player).inventory.has_item(projectile_item):
		return true
	return false

func _use():
	if not _has_projectile_item():
		return
	
	var projectile: Projectile = projectile_scene.instantiate()
	get_tree().root.get_node("/root/Main").add_child(projectile)
	projectile.global_position = muzzle.global_position
	projectile.global_rotation = muzzle.global_rotation
	projectile.initialize(owner_character)
	AudioManager.play(attack_sound)
	
	if owner_character is Player:
		(owner_character as Player).inventory.remove_item(projectile_item)
