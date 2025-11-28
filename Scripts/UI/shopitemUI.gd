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
