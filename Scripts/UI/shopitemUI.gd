class_name ShopItemUI
extends GameButton

@export var selling: bool = false

var player: Player
var shop: Shop
var sell_item: Inventory.ItemSlot
var buy_item: ItemData

@onready var item_icon: TextureRect = $ItemBG/ItemIcon
@onready var item_name_text: Label = $ItemName
@onready var price_text: Label = $GoldText


func set_sell_item(playersignal: Player, shopsignal: Shop, item_slot: Inventory.ItemSlot):
	self.player = playersignal
	self.shop = shopsignal
	sell_item = item_slot
	item_icon.texture = item_slot.item.icon
	item_name_text.text = item_slot.item.display_name
	price_text.text = str(shop.get_sell_price(item_slot.item))


func set_buy_item(playersignal: Player, shopsignal: Shop, item_data: ItemData):
	self.player = playersignal
	self.shop = shopsignal
	buy_item = item_data
	item_icon.texture = item_data.icon
	item_name_text.text = item_data.display_name
	price_text.text = str(shop.get_buy_price(item_data))


func _on_pressed():
	super._on_pressed()

	if selling:
		shop.try_sell_item(player, sell_item)
	else:
		shop.try_buy_item(player, buy_item)
