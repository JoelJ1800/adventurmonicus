class_name Enemy
extends Character

@export var stop_distance: float = 28.0
@export var chase_distance: float = 100
@export var drop_pool: Dictionary[ItemData, int]

var target_direction: Vector2
var target_distance: float
var world_item_scene: PackedScene = preload("res://Scenes/Other Entities/world_item.tscn")

@onready var target: CharacterBody2D = get_tree().get_first_node_in_group("Player")


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
	_drop_item()
	queue_free()


func _drop_item():
	var item_data: ItemData = _get_item_to_drop()
	var world_item: WorldItem = world_item_scene.instantiate()

	get_parent().add_child.call_deferred(world_item)
	world_item.global_position = global_position

	world_item.set_item(item_data)


func _get_item_to_drop() -> ItemData:
	var total_weight: int = 0

	for key in drop_pool:
		total_weight += drop_pool[key]

	var rand: int = randi_range(0, total_weight)
	var count: int = 0

	for key in drop_pool:
		count += drop_pool[key]

		if rand <= count:
			return key

	return null
