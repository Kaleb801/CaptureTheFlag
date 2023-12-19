extends Node

signal active_item_updated

const SlotClass = preload("res://Scripts/Slot.gd")
const ItemClass = preload("res://Scripts/Item.gd")
const NUM_INVENTORY_SLOTS = 20
const NUM_HOTBAR_SLOTS = 8

var slots
var active_item_slot = 0

var inventory={
	
}

var hotbar={
0: ["Copper pickaxe", 1],
1: ["Copper axe", 1],
}

var equips={
	
}

# TODO: First try to add to hotbar
func add_item(item_name, item_quantity):
	var slot_indices: Array = inventory.keys()
	slot_indices.sort()
	for item in slot_indices:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				inventory[item][1] += item_quantity
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				return
			else:
				inventory[item][1] += able_to_add
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				item_quantity = item_quantity - able_to_add
	
	# item doesn't exist in inventory yet, so add it to an empty slot
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			update_slot_visual(i, inventory[i][0], inventory[i][1])
			return

# TODO: Make compatible with hotbar as well
func update_slot_visual(slot_index, item_name, new_quantity):
	var slot = get_tree().root.get_node("/root/stage/UserInterface/Inventory/GridContainer/Slot" + str(slot_index + 1))
	if slot.item != null:
		slot.item.set_item(item_name, new_quantity)
	else:
		slot.initialize_item(item_name, new_quantity)

func remove_item(slot: SlotClass):
	if slot.slotType==0:
		hotbar.erase(slot.slot_index)
	elif slot.slotType==1:
		inventory.erase(slot.slot_index)
	elif slot.slotType==2:
		equips.erase(slot.slot_index)

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	if slot.slotType==0:
		hotbar[slot.slot_index] = [item.item_name, item.item_quantity]
	elif slot.slotType==1:
		inventory[slot.slot_index] = [item.item_name, item.item_quantity]
	elif  slot.slotType==2:
		equips[slot.slot_index] = [item.item_name, item.item_quantity]

func add_item_quantity(slot: SlotClass, quantity_to_add: int):
	if slot.slotType==0:
		var item_name = hotbar[slot.slot_index][0]
		hotbar[slot.slot_index][1] += quantity_to_add
		var quantity = hotbar[slot.slot_index][1]
		if hotbar[slot.slot_index][1]==0:
			remove_item(slot)
		if quantity_to_add<=0:
			slot.clear(item_name,quantity)
	elif slot.slotType==1:
		inventory[slot.slot_index][1] += quantity_to_add
	elif slot.slotType==2:
		equips[slot.slot_index][1] += quantity_to_add
###
### Hotbar Related Functions
func active_item_scroll_up() -> void:
	active_item_slot = 2
	emit_signal("active_item_updated")

func active_item_scroll_down() -> void:
	if active_item_slot == 0:
		active_item_slot = 2
	else:
		active_item_slot -= 1
	emit_signal("active_item_updated")
