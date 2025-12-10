class_name RoomGeneration
extends Node

@export var map_size : int = 7
@export var rooms_to_generate : int = 12
var room_count : int = 0
var map : Array[bool]
var rooms : Array[Room]
var room_pos_offset : float = 160

var first_room_x : int = 3
var first_room_y : int = 3
var first_room : Room

@export var player : CharacterBody2D
var room_scene : PackedScene = preload("res://Scenes/NewDungeon/circular_room.tscn") #temporarily hard coded room

func _ready():
	pass

func _generate():
	pass

func _check_room(x : int, y : int, desired_direction : Vector2, is_first_room : bool = false):
	pass

func _instantiate_rooms ():
	pass
