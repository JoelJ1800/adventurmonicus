class_name RoomGeneration
extends Node

@export var map_size: int = 7
@export var rooms_to_generate: int = 12
var room_count: int = 0
var map: Array[bool]
var rooms: Array[Room]
var room_pos_offset: float = 160

var first_room_x: int = 3
var first_room_y: int = 3
var first_room: Room

@export var player: CharacterBody2D
var room_scene: PackedScene = preload("res://Scenes/NewDungeon/circular_room.tscn") #temporarily hard coded room


func _ready():
	_generate() # on load the scene run the generation function


func _generate():
	room_count = 0
	map.resize(map_size * map_size)

	# start the check room chain at the center of the grid
	_check_room(first_room_x, first_room_y, Vector2.ZERO, true)

	# defined map -> spawn in the room scenes
	_instantiate_rooms()


func _check_room(x: int, y: int, desired_direction: Vector2, is_first_room: bool = false):
	if room_count >= rooms_to_generate:
		return # stop generating if there are enough rooms
	if x < 0 or x > map_size - 1 or y < 0 or y > map_size - 1:
		return # stop generating if the next space to place is outside the map size
	if _get_map(x, y):
		return # stop generating if attempting to spawn on an existing room
	room_count += 1


func _get_map(x: int, y: int) -> bool: # helper function to check if there is a room on the checked slot
	return map[x + y * map_size]


func _set_map(x: int, y: int, value: bool): # sets the map array with boolean value if room is present
	map[x + y * map_size] = value


func _instantiate_rooms():
	pass
