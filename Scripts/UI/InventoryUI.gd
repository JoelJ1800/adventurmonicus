class_name InventoryUI
extends Panel

@export var slots : Array[InventorySlotUI]
@onready var inventory : Inventory = $"../../Inventory"
@onready var player : Player = $"../.."

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _update_ui():
	pass

func _set_info_panel (slot: InventorySlotUI):
	pass

func _hide_info_panel ():
	pass
