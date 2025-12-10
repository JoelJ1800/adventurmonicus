class_name RoomGeneration
extends Node

@export var map_size: int = 10
@export var rooms_to_generate: int = 10
var room_count: int = 0
var map: Array[bool]
var rooms: Array[Room]
var room_pos_offset: float = 1800

var first_room_x: int = 5
var first_room_y: int = 5
var first_room: Room

@export var player: CharacterBody2D
var room_scene: PackedScene = preload("res://Scenes/NewDungeon/circular_room.tscn") #temporarily hard coded room


func _ready():
	_generate() # on load the scene run the generation function
	
		# generate preview
	for x in range(map_size):
		var line:String
		for y in range(map_size):
			line += "#" if _get_map(x,y) else "O"
		print(line)


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
	_set_map(x,y,true)
	
	# 80% chance to follow the desired direction 20% chance to choose another
	var go_north: bool = randf() > (0.4 if desired_direction == Vector2.UP else 0.6)
	var go_south: bool = randf() > (0.4 if desired_direction == Vector2.DOWN else 0.6)
	var go_east: bool = randf() > (0.4 if desired_direction == Vector2.RIGHT else 0.6)
	var go_west: bool = randf() > (0.4 if desired_direction == Vector2.LEFT else 0.6)
	
	# go compassDir if its the first room, else go desiredDir
	if go_north or is_first_room:
		_check_room(x, y-1, Vector2.UP if is_first_room else desired_direction)
	if go_south or is_first_room:
		_check_room(x, y+1, Vector2.DOWN if is_first_room else desired_direction) 
	if go_east or is_first_room:
		_check_room(x + 1, y, Vector2.RIGHT if is_first_room else desired_direction) 
	if go_west or is_first_room:
		_check_room(x - 1, y, Vector2.LEFT if is_first_room else desired_direction) 
	


func _get_map(x: int, y: int) -> bool: # helper function to check if there is a room on the checked slot
	return map[x + y * map_size]


func _set_map(x: int, y: int, value: bool): # sets the map array with boolean value if room is present
	map[x + y * map_size] = value

func _get_map_index(room: Room) -> Vector2i: # find where the room is
	return Vector2i(room.global_position / room_pos_offset)

func _instantiate_rooms():
	for x in range(map_size):
		for y in range(map_size):
			if _get_map(x,y) == false:
				continue
			
			var room : Room = room_scene.instantiate()
			var is_first_room : bool = first_room_x == x and first_room_y == y
			get_tree().root.add_child.call_deferred(room)
			rooms.append(room)
			
			room.global_position = Vector2(x,y) * room_pos_offset
			if is_first_room:
				first_room = room
			
			room.initialize()
