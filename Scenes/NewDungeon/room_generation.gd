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
