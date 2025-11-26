class_name Interactable
extends Area2D

signal Interact (player:Player)

@export var prompt : String = "Pickup Item"
@export var single_use : bool = false
var can_interact : bool = true
