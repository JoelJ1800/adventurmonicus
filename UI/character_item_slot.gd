class_name CharacterItemSlot
extends PanelContainer

@onready var background: TextureRect = $Button
@onready var slotIcon: TextureRect = $Button/SlotIcon
@onready var player = get_tree().get_first_node_in_group("Player")
var hover_sound: AudioStream = preload("res://Audio/UI/Button_Hover.ogg")
var equipped_inventory_slot: Inventory.ItemSlot = null

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
	"MAGIC",
	"RING1",
	"RING2",
)
var slot_name = "HELMET":
	set(value):
		slot_name = value
		update_stat_ui()

var equipped_item: ItemData = null


func _ready() -> void:
	pivot_offset = size / 2
	mouse_entered.connect(hover_on)
	mouse_exited.connect(hover_off)
	update_stat_ui()


func update_stat_ui():
	if not GameManager.SLOTS.has(slot_name):
		return
	if slotIcon == null:
		return

	var slot_data = GameManager.SLOTS[slot_name]

	self.tooltip_text = slot_data.tooltip
	slotIcon.texture = load(slot_data.icon)
	print(slot_data.icon)


func hover_on() -> void:
	self.scale = Vector2(1.05, 1.05)
	background.modulate = Color(0.73, 0.73, 0.73, 1)
	AudioManager.play(hover_sound)


func hover_off() -> void:
	self.scale = Vector2(1, 1)
	background.modulate = Color.WHITE


func _get_drag_data(_at_position: Vector2):
	if equipped_item == null:
		return null
	var preview := TextureRect.new()
	preview.texture = equipped_item.icon
	preview.custom_minimum_size = Vector2(48, 48)
	set_drag_preview(preview)
	return equipped_item


func _can_drop_data(_at_position: Vector2, data) -> bool:
	if not data is Dictionary:
		return false
	if not data.has("item"):
		return false
	var item = data.item
	return item.equip_slot == slot_name


func _drop_data(_pos, data):
	var item = data.item
	var source_ui := data.source as InventorySlotUI
	if player == null or player.weapons == null:
		push_error("CharacterItemSlot not wired to player")
		return
	player.weapons.equip_item_from_inventory(
		item,
		source_ui.item_slot,
		slot_name,
	)
	# Update this slot visually
	set_equipped_slot(source_ui.item_slot)


func equip_item(item: ItemData):
	equipped_item = item
	slotIcon.texture = item.icon


func set_equipped_slot(slot: Inventory.ItemSlot):
	equipped_inventory_slot = slot
	if slot == null or slot.item == null:
		slotIcon.texture = load(GameManager.SLOTS[slot_name].icon)
		return
	slotIcon.texture = slot.item.icon
