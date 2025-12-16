class_name ItemData
extends Resource

@export var display_name: String
@export var description: String
@export var max_stack_size: int = 1
@export var icon: Texture
@export var equip_scene: PackedScene

@export_enum (
	"HELMET",
	"CHEST",
	"BELT",
	"BOOTS",
	"BRACER",
	"GLOVES",
	"MAINHAND",
	"OFFHAND",
	"AMMO",
	"MAGIC2",
	"RING1",
	"RING2",
	"NULL"
)
var equip_slot:= "HELMET":
	set(value):
		equip_slot = value

@export var base_price: int

func _select_in_inventory (player:Player, item_slot: Inventory.ItemSlot):
	pass
