class_name DialogueNPC
extends Node2D

@export var dialogue : Dialogue
@onready var interactable : Interactable = $Interactable
@onready var shop : Shop = $Shop

func _ready() -> void:
	interactable.Interact.connect(_on_interact)

func _on_interact(player: Player):
	if interactable.is_shop:
		player.shop_ui.set_shop(shop)
	else:
		player.dialogue_controller.set_dialogue(dialogue)
