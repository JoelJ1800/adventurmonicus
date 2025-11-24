class_name Enemy
extends Character

var target : CharacterBody2D
@export var stop_distance : float = 28.0
@export var chase_distance : float = 100

var target_direction : Vector2
var target_distance : float

func _ready() -> void:
	target = get_tree().get_first_node_in_group("Player")

func _process(_delta: float) -> void:
	if not target:
		return
	
	#Calculate direction and distance to the target
	target_direction = global_position.direction_to(target.global_position)
	target_distance = global_position.distance_to(target.global_position)
	
	look_direction = target_direction
	
	if target_distance > stop_distance and target_distance < chase_distance:
		move_input = target_direction
	else:
		move_input = Vector2.ZERO

func _die():
	queue_free()
