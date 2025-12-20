class_name Interactable
extends Area2D

signal Interact(player: Player)

@export var prompt: String = "Pickup Item"
@export var single_use: bool = false
@export var is_shop: bool = false

var can_interact: bool = true


func try_interact(player: Player):
	if not can_interact:
		return

	Interact.emit(player)

	if single_use:
		can_interact = false
