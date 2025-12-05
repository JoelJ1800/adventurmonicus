class_name PurchaseInWorld
extends Node2D

signal purchased
@export var cost:int
@export var BuyableNode: NodePath
@export var Buyable: String

func _ready() -> void:
	$Interactable.Interact.connect(_on_interact)

func _on_interact(player: Player):
	var player_gold = int(player.gold)
	print(player_gold)
	if player_gold < cost:
		$Interactable.can_interact = true
		return
	
	if player_gold == null:
		$Interactable.can_interact = true
		return
	
	purchased.emit()
	print ("purchase made")
	$Interactable.can_interact = false
	
	
