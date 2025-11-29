class_name  ShopUI
extends Panel

@onready var player_items_container : VBoxContainer = $ShopPanel/PlayerPanel/PlayerItems
@onready var shop_items_container : VBoxContainer = $ShopPanel/ShopPanel/ShopItems

@onready var player : Player = $"../.."
@onready var inventory : Inventory = $"../../Inventory"

var shop : Shop
var player_items : Array[ShopItemUI]
var shop_items : Array[ShopItemUI]
