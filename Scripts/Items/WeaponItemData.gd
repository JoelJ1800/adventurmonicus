class_name WeaponItemData
extends ItemData

func _select_in_inventory (player : Player, item_slot : Inventory.ItemSlot):
	var is_euipped: bool = player.weapons.weapon_inventory_slot == item_slot
	
	if is_euipped == true:
		player.weapons.unequip_weapon()
		player.weapons.weapon_inventory_slot = null
	else:
		player.weapons.equip_weapon(self)
		player.weapons.weapon_inventory_slot = item_slot
	
	player.inventory.UpdatedInventory.emit()
