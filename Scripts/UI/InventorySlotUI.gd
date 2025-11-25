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
	
	#set icon
	if item_slot.item:
		item_icon.texture = item_slot.item.icon
	else:
		item_icon.texture = null
		quantity_text.text = ""
		return
	
	#set quantity text if > 1
	if item_slot.quantity > 1:
		quantity_text.text =str(item_slot.quantity)
	else: 
		quantity_text.text = ""

func _on_pressed():
	super._on_pressed()
	
	# return if no item
	if not item_slot or not item_slot.item:
		return
	
	# Click on the item and then trigger whatever it does
	item_slot.item._select_in_inventory(player, item_slot)
