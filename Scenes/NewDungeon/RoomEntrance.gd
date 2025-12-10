class_name RoomEntrance
extends Node2D

@export var direction : Room.Direction = Room.Direction.NORTH
@onready var doorAnim = $DoorGate/DoorGate
@onready var door = $DoorGate
@onready var door_anim = $DoorGate/DoorGate
@onready var door_closed_collider = $DoorGate/col_Door_Closed
@onready var player_spawn = $PlayerSpawn
@onready var exit_trigger: Area2D = $PlayerExit
var neighbor : Room
