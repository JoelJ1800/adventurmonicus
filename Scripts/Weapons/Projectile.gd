class_name Projectile
extends Area2D

@export var damage: int
@export var speed: float
@export var hit_force: float

var owner_character: Character


func _process(delta: float) -> void:
	translate(transform.x * speed * delta)


func initialize(_owner_character: Character):
	self.owner_character = _owner_character


func _on_body_entered(body: Node2D) -> void:
	if body is Character and body != owner_character:
		body.take_damage(damage, transform.x * hit_force)
	queue_free()
