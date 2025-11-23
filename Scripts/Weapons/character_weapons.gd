class_name CharacterWeapons
extends Node2D

@export var weapon_to_equip : PackedScene
@export var shield_to_equip : PackedScene

var current_weapon : Weapon
var current_shield : Shield
var has_shield_out : bool

@onready var character : Character = $".."


func _ready ():
	if weapon_to_equip:
		equip_weapon(weapon_to_equip)
	if shield_to_equip:
		equip_shield(shield_to_equip)

func equip_weapon (weapon_scene : PackedScene):
	if current_weapon:
		unequip_weapon()
	
	current_weapon = weapon_scene.instantiate()
	add_child(current_weapon)
	current_weapon.global_position = global_position
	
	current_weapon.owner_character = character
	current_weapon._equip()

func unequip_weapon ():
	if not current_weapon:
		return
	
	current_weapon._unequip()
	current_weapon.queue_free()

func equip_shield(shield_scene:PackedScene):
	if current_shield:
		unequip_shield()
	
	current_shield = shield_scene.instantiate()
	add_child(current_shield)
	current_shield.global_position = global_position
	
	current_shield.owner_character = character
	current_shield._equip()
	current_shield.visible = false

func unequip_shield():
	if not current_shield:
		return
	current_shield._unequip()
	current_shield.queue_free()

func toggle_shield(toggle:bool):
	has_shield_out = toggle
	
	if current_weapon:
		current_weapon.visible = !toggle
		current_weapon.can_use = !toggle
	if current_shield:
		current_shield.visible = toggle

func try_block_direction(direction: Vector2) -> bool:
	if not current_shield:
		return false
	if not has_shield_out:
		return false
	var dot:float = current_shield.transform.x.dot(direction)
	var do_block:bool = dot < -0.8
	
	return do_block
