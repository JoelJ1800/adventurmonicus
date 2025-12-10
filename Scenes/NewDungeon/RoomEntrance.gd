class_name RoomEntrance
extends Node2D

@export var direction: Room.Direction = Room.Direction.NORTH
@onready var door = $DoorGate
@onready var door_anim = $DoorGate/DoorGate
@onready var door_closed_collider = $DoorGate/col_Door_Closed
@onready var player_spawn = $PlayerSpawn
@onready var exit_trigger: Area2D = $PlayerExit
@onready var barrier = $DoorGate/Barrier
var neighbour: Room


func _ready() -> void:
	exit_trigger.body_entered.connect(_on_body_entered_exit_trigger)
	toggle_barrier(true)


func set_neighbor(neighbour_room: Room):
	neighbour = neighbour_room
	toggle_barrier(false)


func _get_neighbour_entry_direction() -> Room.Direction: # determine what entrance the player has come from to spawn at the entry listed
	if direction == Room.Direction.NORTH:
		return Room.Direction.SOUTH
	if direction == Room.Direction.SOUTH:
		return Room.Direction.NORTH
	if direction == Room.Direction.EAST:
		return Room.Direction.WEST
	else:
		return Room.Direction.EAST


func toggle_barrier(toggle: bool):
	barrier.visible = toggle
	door_anim.visible = !toggle


func open_door():
	if barrier.visible:
		return
	door_anim.play("DoorOpen") # plays open animation
	door_closed_collider.disabled = true # removes collider over the doorway


func close_door():
	if barrier.visible:
		return
	door_anim.play("DoorClose") # plays close animation
	door_closed_collider.disabled = false # adds collider over the doorway, default collider is on


func _on_body_entered_exit_trigger(body: Node2D) -> void:
	pass
