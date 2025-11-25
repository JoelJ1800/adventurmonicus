class_name InventoryUI
extends Panel

@export var slots : Array[InventorySlotUI]
@onready var inventory : Inventory = $"../../Inventory"
@onready var player : Player = $"../.."

func _ready() -> void:
	inventory.UpdatedInventory.connect(_update_ui)
	_update_ui()

func _process(delta: float) -> void:
	pass

func _update_ui():
	for i in len(slots):
		slots[i].set_item_slot(inventory.item_slots[i], player)

func _set_info_panel (slot: InventorySlotUI):
	pass

func _hide_info_panel ():
	pass
