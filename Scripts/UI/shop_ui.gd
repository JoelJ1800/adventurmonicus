class_name ShopUI
extends Panel

var shop: Shop
var player_items: Array[ShopItemUI]
var shop_items: Array[ShopItemUI]

@onready var player_items_container: VBoxContainer = $ShopPanel/PlayerPanel/PlayerItems
@onready var shop_items_container: VBoxContainer = $ShopPanel/ShopPanel/ShopItems
@onready var player: Player = $"../.."
@onready var inventory: Inventory = $"../../Inventory"


func _ready():
	close_shop()
	inventory.UpdatedInventory.connect(_update_player_items)

	for child in player_items_container.get_children():
		if child is not ShopItemUI:
			continue

		player_items.append(child)

	for child in shop_items_container.get_children():
		if child is not ShopItemUI:
			continue

		shop_items.append(child)


func _process(_delta: float) -> void:
	if not visible:
		return

	if Input.is_action_just_pressed("ui_cancel"):
		close_shop()


func set_shop(shopsignal: Shop):
	self.shop = shopsignal
	visible = true
	player.toggle_usability(false)

	_update_player_items()

	for i in len(shop_items):
		if i >= len(shop.items):
			shop_items[i].visible = false
			continue

		shop_items[i].visible = true
		shop_items[i].set_buy_item(player, shop, shop.items[i])


func close_shop():
	visible = false
	player.toggle_usability(true)


func _update_player_items():
	if not visible or not shop:
		return
	for i in len(player_items):
		if i >= inventory.size or not inventory.item_slots[i].item:
			player_items[i].visible = false
			continue

		player_items[i].visible = true
		player_items[i].set_sell_item(player, shop, inventory.item_slots[i])
