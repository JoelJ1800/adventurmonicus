class_name ItemData
extends Resource

@export var display_name: String
@export var description: String
@export var max_stack_size: int = 1
@export var icon: Texture
@export var equip_scene: PackedScene
@export var base_price: int

@export_enum(
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
	"NULL",
)
var equip_slot := "HELMET":
	set(value):
		equip_slot = value


func _select_in_inventory(_player: Player, _item_slot: Inventory.ItemSlot):
	pass
