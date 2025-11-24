class_name InventorySlotUI
extends GameButton

@onready var item_icon : TextureRect = $ItemIcon
@onready var quantity_text : Label = $QuantityText
@onready var equipped : TextureRect = $Equipped

var item_slot : Inventory.ItemSlot
var player : Player

func set_item_slot (item_slot:Inventory.ItemSlot,player:Player):
	self.item_slot = item_slot
	self.player = player
	var is_equipped : bool = false
	# Change is_equipped depending on if we have this item equipped
	equipped.visible = is_equipped
