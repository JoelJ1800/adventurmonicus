class_name ShopItemUI
extends GameButton

@export var selling : bool = false

@onready var item_icon : TextureRect = $ItemBG/ItemIcon
@onready var item_name_text : Label = $ItemName
@onready var price_text : Label = $GoldText

var player : Player
var shop : Shop
var sell_item : Inventory.ItemSlot
var buy_item : ItemData

func _on_pressed ():
	super._on_pressed()
	
	if selling:
		shop.try_sell_item(player, sell_item)
	else:
		shop.try_buy_item(player, buy_item)

func set_sell_item (player : Player, shop : Shop, item_slot : Inventory.ItemSlot):
	self.player = player
	self.shop = shop
	sell_item = item_slot
	item_icon.texture = item_slot.item.icon
	item_name_text.text = item_slot.item.display_name
	price_text.text = str(shop.get_sell_price(item_slot.item))

func set_buy_item (player : Player, shop : Shop, item_data : ItemData):
	self.player = player
	self.shop = shop
	buy_item = item_data
	item_icon.texture = item_data.item.icon
	item_name_text.text = item_data.item.display_name
	price_text.text = str(shop.get_buy_price(item_data))
