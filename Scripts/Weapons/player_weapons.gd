class_name PlayerWeapons
extends CharacterWeapons

func _ready ():
	super._ready()
	
	$"../Inventory".UpdatedSlot.connect(_on_updated_inventory_slot)

func _process (_delta : float):
	if not can_use:
		return
	var mouse_pos : Vector2 = get_global_mouse_position()
	var mouse_dir : Vector2 = global_position.direction_to(mouse_pos)
	
	if current_weapon:
		current_weapon.set_aim_direction(mouse_dir)

		
		if Input.is_action_just_pressed("attack"):
			if get_viewport().gui_get_hovered_control() == null:
				current_weapon._try_use()
	
	if current_shield:
		current_shield.set_aim_direction(mouse_dir)
		
		if Input.is_action_just_pressed("block"):
			toggle_shield(true)
		elif Input.is_action_just_released("block"):
			toggle_shield(false)

func _on_updated_inventory_slot (slot : Inventory.ItemSlot):
	if slot == weapon_inventory_slot and not slot.item:
		unequip_weapon()
		weapon_inventory_slot = null
	
	if slot == shield_inventory_slot and not slot.item:
		unequip_shield()
		weapon_inventory_slot = null

func equip_item_from_inventory(
	item: ItemData,
	inventory_slot: Inventory.ItemSlot,
	slot_name: String
):
	match slot_name:
		"MAINHAND":
			weapon_inventory_slot = inventory_slot
			equip_weapon(item)
		"OFFHAND":
			shield_inventory_slot = inventory_slot
			equip_shield(item)
