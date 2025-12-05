class_name PurchaseInWorld
extends Node2D

signal purchased
@export var cost:int
@export var BuyableNode: NodePath
@export var Buyable: String
var sale_sound : AudioStream = preload("res://Audio/Shop/Shop_Sale.ogg")

func _ready() -> void:
	$Interactable.Interact.connect(_on_interact)
	if GameManager.brdge_built == true:
		$Interactable.can_interact = false

func _on_interact(player: Player):
	var player_gold = int(player.gold)
	if player_gold < cost:
		$Interactable.can_interact = true
		return
	
	if player_gold == null:
		$Interactable.can_interact = true
		return
	
	purchased.emit()

	player.take_gold(cost)
	AudioManager.play(sale_sound)
	$Interactable.can_interact = false
	
	
