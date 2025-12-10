class_name Room
extends Node2D

enum Direction
{
	NORTH,
	SOUTH,
	EAST,
	WEST
}

@export var doors_always_open : bool = false

@onready var entrance_north : RoomEntrance = $Entrance_North
@onready var entrance_south : RoomEntrance = $Entrance_South
@onready var entrance_east : RoomEntrance = $Entrance_East
@onready var entrance_west : RoomEntrance = $Entrance_West

var enemies_in_room : int
