class_name ItemData
extends Resource

@export var display_name: String
@export var description: String
@export var max_stack_size: int = 1
@export var icon: Texture
@export var equip_scene: PackedScene

@export var base_price: int

func _select_in_inventory (player:Player, item_slot: Inventory.ItemSlot):
	pass
