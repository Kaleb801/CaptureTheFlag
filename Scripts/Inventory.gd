extends Node2D

const SlotClass = preload("res://Scripts/Slot.gd")
onready var inventory_slots = $GridContainer
onready var equip_slots = $EquipSlots.get_children()

func _ready():
	var slots = inventory_slots.get_children()
	PlayerInventory.slots2=slots
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slot_index = i
		slots[i].slotType = SlotClass.SlotType.INVENTORY
		
	for i in range(equip_slots.size()):
		equip_slots[i].connect("gui_input", self, "slot_gui_input", [equip_slots[i]])
		equip_slots[i].slot_index = i
	equip_slots[0].slotType = SlotClass.SlotType.HEAD
	equip_slots[1].slotType = SlotClass.SlotType.SHIRT
	equip_slots[2].slotType = SlotClass.SlotType.PANTS
	equip_slots[3].slotType = SlotClass.SlotType.SHOES
	
	initialize_inventory()
	initialize_equips()

func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])

func initialize_equips():
	for i in range(equip_slots.size()):
		if PlayerInventory.equips.has(i):
			equip_slots[i].initialize_item(PlayerInventory.equips[i][0], PlayerInventory.equips[i][1])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if find_parent("UserInterface").holding_item != null:
				if !slot.item:
					left_click_empty_slot(slot)
				else:
					if find_parent("UserInterface").holding_item.item_name != slot.item.item_name:
						left_click_different_item(event, slot)
					else:
						left_click_same_item(slot)
			elif slot.item:
				left_click_not_holding(slot)
				
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var holding_item = find_parent("UserInterface").holding_item
		if holding_item:
			var mouse_position = get_global_mouse_position()
			var slot_clicked = false

			# Verifica se o clique foi em algum dos slots
			for slot in inventory_slots.get_children():
				if is_mouse_over_slot(slot, mouse_position):
					slot_clicked = true
					break
			for slot in find_parent("UserInterface").get_node("Hotbar/HotbarSlots").get_children():
				if is_mouse_over_slot(slot, mouse_position):
					slot_clicked = true
					break
			var player
			if PlayerInventory.player=="player1":
				player=get_tree().get_current_scene().get_node("/root/stage/player1").openchest
			else:
				player=get_tree().get_current_scene().get_node("/root/stage/player2").openchest
				
			if player!=null:
				for slot in player.get_node("GridContainer").get_children():
					if is_mouse_over_slot(slot, mouse_position):
						slot_clicked = true
						break
					
			if not slot_clicked:
				for slot in equip_slots:
					if is_mouse_over_slot(slot, mouse_position):
						slot_clicked = true
						break
						
			if slot_clicked == false:
				find_parent("UserInterface").holding_item.queue_free()
				find_parent("UserInterface").holding_item=null
		
func is_mouse_over_slot(slot: SlotClass, mouse_position: Vector2) -> bool:
	var slot_rect = slot.get_global_rect()
	# Ajusta o retângulo do slot de acordo com a escala
	slot_rect.size *= 2
	return slot_rect.has_point(mouse_position)
		

func able_to_put_into_slot(slot: SlotClass):
	var holding_item = find_parent("UserInterface").holding_item
	if holding_item == null:
		return true
	var holding_item_category = JsonData.item_data[holding_item.item_name]["ItemCategory"]
	
	if slot.slotType == SlotClass.SlotType.HEAD:
		return holding_item_category == "Head"
	elif slot.slotType == SlotClass.SlotType.SHIRT:
		return holding_item_category == "Shirt"
	elif slot.slotType == SlotClass.SlotType.PANTS:
		return holding_item_category == "Pants"
	elif slot.slotType == SlotClass.SlotType.SHOES:
		return holding_item_category == "Shoes"
	return true
		
func left_click_empty_slot(slot: SlotClass):
	if able_to_put_into_slot(slot):
		PlayerInventory.add_item_to_empty_slot(find_parent("UserInterface").holding_item, slot)
		slot.putIntoSlot(find_parent("UserInterface").holding_item)
		find_parent("UserInterface").holding_item = null
	
func left_click_different_item(event: InputEvent, slot: SlotClass):
	if able_to_put_into_slot(slot):
		PlayerInventory.remove_item(slot)
		PlayerInventory.add_item_to_empty_slot(find_parent("UserInterface").holding_item, slot)
		var temp_item = slot.item
		slot.pickFromSlot()
		temp_item.global_position = event.global_position
		slot.putIntoSlot(find_parent("UserInterface").holding_item)
		find_parent("UserInterface").holding_item = temp_item

func left_click_same_item(slot: SlotClass):
	if able_to_put_into_slot(slot):
		var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
		var able_to_add = stack_size - slot.item.item_quantity
		if able_to_add >= find_parent("UserInterface").holding_item.item_quantity:
			PlayerInventory.add_item_quantity(slot, find_parent("UserInterface").holding_item.item_quantity)
			slot.item.add_item_quantity(find_parent("UserInterface").holding_item.item_quantity)
			find_parent("UserInterface").holding_item.queue_free()
			find_parent("UserInterface").holding_item = null
		else:
			PlayerInventory.add_item_quantity(slot, able_to_add)
			slot.item.add_item_quantity(able_to_add)
			find_parent("UserInterface").holding_item.decrease_item_quantity(able_to_add)
		
func left_click_not_holding(slot: SlotClass):
	PlayerInventory.remove_item(slot)
	find_parent("UserInterface").holding_item = slot.item
	slot.pickFromSlot()
	find_parent("UserInterface").holding_item.global_position = get_global_mouse_position()

func _on_Bag_pressed():
	$GridContainer.visible=true
	$EquipSlots.visible=true
	$Bag.disabled=true
	$Class.disabled=false
	$Skills.visible=false

func _on_Class_pressed():
	$GridContainer.visible=false
	$EquipSlots.visible=false
	$Bag.disabled=false
	$Class.disabled=true
	$Skills.visible=true
