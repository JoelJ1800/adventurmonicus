class_name RoomEntrance
extends Node2D

@export var direction: Room.Direction = Room.Direction.NORTH
@onready var door = $DoorGate
@onready var door_anim = $DoorGate/DoorGate
@onready var door_closed_collider = $DoorGate/col_Door_Closed
@onready var player_spawn = $PlayerSpawn
@onready var exit_trigger: Area2D = $PlayerExit
var neighbor: Room


func _ready() -> void:
	exit_trigger.body_entered.connect(_on_body_entered_exit_trigger)


func set_neightbour(neighbour_room: Room):
	pass


func toggle_barrier(toggle: bool):
	pass


func open_door():
	door_anim.play("DoorOpen") # plays open animation
	door_closed_collider.disabled = true # removes collider over the doorway


func close_door():
	door_anim.play("DoorClose") # plays close animation
	door_closed_collider.disabled = false # adds collider over the doorway, default collider is on


func _on_body_entered_exit_trigger(body: Node2D) -> void:
	pass
