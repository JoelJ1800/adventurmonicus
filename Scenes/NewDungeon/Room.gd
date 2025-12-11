class_name Room
extends Node2D

enum Direction {
	NORTH,
	SOUTH,
	EAST,
	WEST,
}

@export var enemy_scenes : Array[PackedScene] = []
@export var min_distance_from_player :float = 200.0
@export var max_enemies : int = 4
@export var doors_always_open: bool = false

@onready var entrance_north: RoomEntrance = $Overworld/EntranceNorth
@onready var entrance_south: RoomEntrance = $Overworld/EntranceSouth
@onready var entrance_east: RoomEntrance = $Overworld/EntranceEast
@onready var entrance_west: RoomEntrance = $Overworld/EntranceWest
@onready var enemy_spawns = $EnemySpawns

var enemies_in_room: int


func _ready():
	pass


func initialize():
	pass


func set_neighbour(neighbour_direction : Direction, neighbour_room : Room):
	if neighbour_direction == Direction.NORTH:
		entrance_north.set_neighbour(neighbour_room)
	elif neighbour_direction == Direction.SOUTH:
		entrance_south.set_neighbour(neighbour_room)
	elif neighbour_direction == Direction.EAST:
		entrance_east.set_neighbour(neighbour_room)
	elif neighbour_direction == Direction.WEST:
		entrance_west.set_neighbour(neighbour_room)


# called when the player enters the room
func player_enter(entry_direction: Direction, player: CharacterBody2D, first_room: bool = false):
	if entry_direction == Direction.NORTH:
		player.global_position = entrance_north.player_spawn.global_position
	elif entry_direction == Direction.SOUTH:
		player.global_position = entrance_south.player_spawn.global_position
	elif entry_direction == Direction.EAST:
		player.global_position = entrance_east.player_spawn.global_position
	elif entry_direction == Direction.WEST:
		player.global_position = entrance_west.player_spawn.global_position

	if first_room:
		player.global_position = global_position + Vector2(400,400)

	if enemies_in_room > 0 and not doors_always_open:
		close_doors()
	else:
		open_doors()
	
	spawn_enemies.call_deferred(player.global_position)
	


func _on_defeat_enemy(enemy):
	pass


func open_doors():
	entrance_north.open_door.call_deferred()
	entrance_south.open_door.call_deferred()
	entrance_east.open_door.call_deferred()
	entrance_west.open_door.call_deferred()


func close_doors():
	entrance_north.close_door.call_deferred()
	entrance_south.close_door.call_deferred()
	entrance_east.close_door.call_deferred()
	entrance_west.close_door.call_deferred()


func spawn_enemies(current_spawn):
	if enemy_scenes.is_empty():
		return
	
	if doors_always_open == true:
		return

	var possible_spawns = []

	# Filter spawn points too close to the player spawn
	for spawn in enemy_spawns.get_children():
		if spawn.global_position.distance_to(current_spawn) >= min_distance_from_player:
			possible_spawns.append(spawn)
	
	print(possible_spawns)

	if possible_spawns.is_empty():
		return

	possible_spawns.shuffle()

	var num_to_spawn = min(max_enemies, possible_spawns.size())

	for i in num_to_spawn:
		var spawn_point = possible_spawns[i]
		var enemy_scene = enemy_scenes.pick_random()
		var enemy = enemy_scene.instantiate()
		enemy.global_position = spawn_point.position
		add_child(enemy)
		print("enemy spawned at " +str(spawn_point) + " " + str(spawn_point.position))
