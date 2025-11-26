class_name PortalInteraction
extends Node2D

@export_file("*.tscn") var scene_to_load : String
@export var player_spawn_pos:  Vector2

func _ready() -> void:
	$Interactable.Interact.connect(_on_interact)

func _on_interact(player: Player):
	var scene : PackedScene = load(scene_to_load)
	GameManager.change_scene(scene, player_spawn_pos)
