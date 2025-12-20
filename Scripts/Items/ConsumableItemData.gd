class_name ConsumableItemData
extends ItemData

@export var health_gain: int = 1
@export var consume_sound: AudioStream


func _select_in_inventory(player: Player, item_slot: Inventory.ItemSlot):
	player.heal(health_gain)
	player.inventory.remove_item_from_slot(item_slot)

	AudioManager.play(consume_sound)
