class_name ShopNPC
extends Node2D

@onready var shop : Shop = $Shop
@onready var interactable : Interactable = $Interactable

func _ready() -> void:
	interactable.Interact.connect(_on_interact)

func _on_interact ( player:Player):
	player.shop_ui.set_shop(shop)
