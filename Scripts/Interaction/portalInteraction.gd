class_name PortalInteraction
extends Node2D

@export var scene_to_load : PackedScene
@export var player_spawn_pos:  Vector2

func _ready() -> void:
	$Interactable.Interact.connect(_on_interact)

func _on_interact(player: Player):
	GameManager.change_scene(scene_to_load, player_spawn_pos)
