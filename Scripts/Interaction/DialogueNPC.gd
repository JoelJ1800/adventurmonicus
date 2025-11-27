class_name DialogueNPC
extends Node2D

@export var dialogue : Dialogue
@onready var interactable : Interactable = $Interactable

func _ready() -> void:
	interactable.Interact.connect(_on_interact)

func _on_interact(player: Player):
	player.dialogue_controller.set_dialogue(dialogue)
