class_name Shop
extends Node

@export var items: Array[ItemData]

@export var sell_price_mod: float = 0.8
@export var buy_price_mod: float = 1.2


func try_sell_item(player: Player, item_slot: Inventory.ItemSlot):
	var price : int = get_sell_price(item_slot.item)
	
	player.inventory.remove_item_from_slot(item_slot)
	player.give_gold(price)

func try_buy_item (player : Player, item_data : ItemData):
	var price : int = get_buy_price(item_data)
	if player.gold < price:
		return
	
	var item_added: bool = player.inventory.add_item(item_data)
	if item_added:
		player.take_gold(price)

func get_sell_price (item_data : ItemData) -> int:
	return ceili(float(item_data.base_price) * sell_price_mod)

func get_buy_price (item_data : ItemData) -> int:
	return ceili(float(item_data.base_price) * buy_price_mod)
