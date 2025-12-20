# Base file for all characters within the game
class_name Character
extends CharacterBody2D

signal OnTakeDamage(direction: Vector2)
signal OnHealthChange

@export var cur_hp: int = 10
@export var max_hp: int = 10
@export var move_speed: float = 20
@export var force_drag: float = 5
@export var weight: float = 1.0
@export var weapons: CharacterWeapons
@export var damaged_sound: AudioStream

var move_input: Vector2
var look_direction: Vector2
var external_force: Vector2
var can_move: bool = true


func _physics_process(delta):
	if can_move:
		_move(delta)


func take_damage(damage: int, force: Vector2):
	if weapons.try_block_direction(force.normalized()):
		return

	cur_hp -= damage
	add_force(force)
	AudioManager.play(damaged_sound)

	if cur_hp <= 0:
		_die()
	else:
		OnTakeDamage.emit(force)
		OnHealthChange.emit()


func heal(amount: int):
	cur_hp += amount

	if cur_hp > max_hp:
		cur_hp = max_hp

	OnHealthChange.emit()


func add_force(force: Vector2):
	external_force += force / weight


func _move(delta: float):
	external_force = external_force.lerp(Vector2.ZERO, force_drag * delta)

	velocity = move_input * move_speed
	velocity += external_force

	move_and_slide()


func _die():
	pass
