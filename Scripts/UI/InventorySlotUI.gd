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
	
	if player.weapons.weapon_inventory_slot == item_slot:
		is_equipped = true
	elif player.weapons.shield_inventory_slot == item_slot:
		is_equipped = true
	
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

	if is_dragging():
		return

	if not item_slot or not item_slot.item:
		return

	item_slot.item._select_in_inventory(player, item_slot)


func _get_drag_data(_at_position: Vector2):
	if not item_slot or not item_slot.item:
		return null

	var preview := TextureRect.new()
	preview.texture = item_slot.item.icon
	preview.custom_minimum_size = Vector2(48, 48)
	preview.expand = true
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	set_drag_preview(preview)

	return {
		"source": self,
		"item": item_slot.item
	}


func _can_drop_data(_at_position: Vector2, data) -> bool:
	if not data is Dictionary:
		return false
	if not data.has("source"):
		return false

	return data.source is InventorySlotUI and data.source != self


func _drop_data(_at_position: Vector2, data):
	var source_slot_ui := data.source as InventorySlotUI
	if not source_slot_ui:
		return

	var source_slot := source_slot_ui.item_slot
	var target_slot := item_slot

	if not source_slot or not target_slot:
		return

	player.inventory.swap_slots(source_slot, target_slot)



func is_dragging() -> bool:
	return get_viewport().gui_is_dragging()
