class_name Room
extends Node2D

enum Direction {
	NORTH,
	SOUTH,
	EAST,
	WEST,
}

@export var doors_always_open: bool = false

@onready var entrance_north: RoomEntrance = $Entrance_North
@onready var entrance_south: RoomEntrance = $Entrance_South
@onready var entrance_east: RoomEntrance = $Entrance_East
@onready var entrance_west: RoomEntrance = $Entrance_West

var enemies_in_room: int


func _ready():
	pass


func initialize():
	pass


func set_neighbor(neighbor_direction: Direction, neighbor_room: Room):
	pass


# called when the player enters the room
func player_enter(entry_direction: Direction, player: CharacterBody2D, first_room: bool = false):
	pass


func _on_defeat_enemy(enemy):
	pass


func open_doors():
	entrance_north.open_door()
	entrance_south.open_door()
	entrance_east.open_door()
	entrance_west.open_door()


func close_doors():
	entrance_north.close_door()
	entrance_south.close_door()
	entrance_east.close_door()
	entrance_west.close_door()
