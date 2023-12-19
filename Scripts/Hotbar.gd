extends Node2D

const SlotClass = preload("res://Scripts/Slot.gd")
onready var hotbar_slots = $HotbarSlots
onready var active_item_label = $ActiveItemLabel
onready var slots = hotbar_slots.get_children()
var stage
var copperAxe = preload("res://Images/copperaxeanim.png")
var copperPickaxe = preload("res://Images/copperpickaxeanim.png")
var copperSword = preload("res://Images/copperswordanim.png")
var ironAxe = preload("res://Images/ironaxeanim.png")
var ironPickaxe = preload("res://Images/ironpickaxeanim.png")
var ironSword = preload("res://Images/ironswordanim.png")
var mythrilAxe = preload("res://Images/mythrilaxeanim.png")
var mythrilPickaxe = preload("res://Images/mythrilpickaxeanim.png")
var mythrilSword = preload("res://Images/mythrilswordanim.png")
var adamantAxe = preload("res://Images/adamantaxeanim.png")
var adamantPickaxe = preload("res://Images/adamantpickaxeanim.png")
var adamantSword = preload("res://Images/adamantswordanim.png")
var dragoniteAxe = preload("res://Images/dragoniteaxeanim.png")
var dragonitePickaxe = preload("res://Images/dragonitepickaxeanim.png")
var dragoniteSword = preload("res://Images/dragoniteswordanim.png")
var orangeStaff = preload("res://Images/staffanim.png")
var grayStaff = preload("res://Images/graystaffanim.png")
var blueStaff = preload("res://Images/bluestaffanim.png")
var greenStaff = preload("res://Images/greenstaffanim.png")
var redStaff = preload("res://Images/redstaffanim.png")
var attack1=0
var attack2=0
var newattack1=0
var newattack2=0


func _ready():
	stage = get_tree().get_current_scene().get_node("/root/stage")
	PlayerInventory.slots=slots
#	for i in range(slots.size()):
#		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
#		slots[i].slot_index = i
	PlayerInventory.connect("active_item_updated", self, "update_active_item_label")
	for i in range(slots.size()):
		PlayerInventory.connect("active_item_updated", slots[i], "refresh_style")
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slotType = SlotClass.SlotType.HOTBAR
		slots[i].slot_index = i
	initialize_hotbar()
	update_active_item_label()

func update_active_item_label():
	var playerNode
	if PlayerInventory.player=="player1":
		playerNode=stage.get_node("player1")
	else:
		playerNode=stage.get_node("player2")
	if slots[PlayerInventory.active_item_slot].item != null:
		active_item_label.text = slots[PlayerInventory.active_item_slot].item.item_name
		if slots[PlayerInventory.active_item_slot].item.item_name=="Torch":
			playerNode.light(true,PlayerInventory.player)
		else:
			playerNode.light(false,PlayerInventory.player)
		if slots[PlayerInventory.active_item_slot].item.item_name=="Copper axe":
			if PlayerInventory.player=="player1":
				attack1=1
			else:
				attack2=1
			update()
			playerNode.get_node("Animations/ToolBase").texture=copperAxe
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Copper pickaxe":
			if PlayerInventory.player=="player1":
				attack1=1
			else:
				attack2=1
			update()
			playerNode.get_node("Animations/ToolBase").texture=copperPickaxe
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Copper Sword":
			if PlayerInventory.player=="player1":
				attack1=2
			else:
				attack2=2
			update()
			playerNode.get_node("Animations/Sword").texture=copperSword
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Iron axe":
			if PlayerInventory.player=="player1":
				attack1=2
			else:
				attack2=2
			update()
			playerNode.get_node("Animations/ToolBase").texture=ironAxe
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Iron pickaxe":
			if PlayerInventory.player=="player1":
				attack1=2
			else:
				attack2=2
			update()
			playerNode.get_node("Animations/ToolBase").texture=ironPickaxe
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Iron Sword":
			if PlayerInventory.player=="player1":
				attack1=3
			else:
				attack2=3
			update()
			playerNode.get_node("Animations/Sword").texture=ironSword
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Mythril axe":
			if PlayerInventory.player=="player1":
				attack1=3
			else:
				attack2=3
			update()
			playerNode.get_node("Animations/ToolBase").texture=mythrilAxe
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Mythril pickaxe":
			if PlayerInventory.player=="player1":
				attack1=3
			else:
				attack2=3
			update()
			playerNode.get_node("Animations/ToolBase").texture=mythrilPickaxe
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Mythril Sword":
			if PlayerInventory.player=="player1":
				attack1=4
			else:
				attack2=4
			update()
			playerNode.get_node("Animations/Sword").texture=mythrilSword
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Adamant axe":
			if PlayerInventory.player=="player1":
				attack1=4
			else:
				attack2=4
			update()
			playerNode.get_node("Animations/ToolBase").texture=adamantAxe
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Adamant pickaxe":
			if PlayerInventory.player=="player1":
				attack1=4
			else:
				attack2=4
			update()
			playerNode.get_node("Animations/ToolBase").texture=adamantPickaxe
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Adamant Sword":
			if PlayerInventory.player=="player1":
				attack1=5
			else:
				attack2=5
			update()
			playerNode.get_node("Animations/Sword").texture=adamantSword
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Dragonite axe":
			if PlayerInventory.player=="player1":
				attack1=5
			else:
				attack2=5
			update()
			playerNode.get_node("Animations/ToolBase").texture=dragoniteAxe
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Dragonite pickaxe":
			if PlayerInventory.player=="player1":
				attack1=5
			else:
				attack2=5
			update()
			playerNode.get_node("Animations/ToolBase").texture=dragonitePickaxe
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Dragonite Sword":
			if PlayerInventory.player=="player1":
				attack1=6
			else:
				attack2=6
			update()
			playerNode.get_node("Animations/Sword").texture=dragoniteSword
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Garnet Staff":
			if PlayerInventory.player=="player1":
				attack1=2
			else:
				attack2=2
			update()
			playerNode.get_node("Animations/Staff").texture=orangeStaff
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Opal Staff":
			if PlayerInventory.player=="player1":
				attack1=3
			else:
				attack2=3
			update()
			playerNode.get_node("Animations/Staff").texture=grayStaff
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Sapphire Staff":
			if PlayerInventory.player=="player1":
				attack1=4
			else:
				attack2=4
			update()
			playerNode.get_node("Animations/Staff").texture=blueStaff
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Emerald Staff":
			if PlayerInventory.player=="player1":
				attack1=5
			else:
				attack2=5
			update()
			playerNode.get_node("Animations/Staff").texture=greenStaff
		elif slots[PlayerInventory.active_item_slot].item.item_name=="Ruby Staff":
			if PlayerInventory.player=="player1":
				attack1=6
			else:
				attack2=6
			update()
			playerNode.get_node("Animations/Staff").texture=redStaff
		else:
			attack1=0
			attack2=0
			update()
	else:
		active_item_label.text = ""
		attack1=0
		attack2=0
		update()

func update():
	if PlayerInventory.player=="player1" and attack1!=newattack1:
		stage.rpc("set_sword",-newattack1,PlayerInventory.player)
		newattack1=attack1
		stage.rpc("set_sword",newattack1,PlayerInventory.player)
	elif PlayerInventory.player=="player2" and attack2!=newattack2:
		stage.rpc("set_sword",-newattack2,PlayerInventory.player)
		newattack2=attack2
		stage.rpc("set_sword",newattack2,PlayerInventory.player)
func initialize_hotbar():
	for i in range(slots.size()):
		if PlayerInventory.hotbar.has(i):
			slots[i].initialize_item(PlayerInventory.hotbar[i][0], PlayerInventory.hotbar[i][1])

func _input(event):
	if find_parent("UserInterface").holding_item:
		find_parent("UserInterface").holding_item.global_position = get_global_mouse_position()

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
			update_active_item_label()

func left_click_empty_slot(slot: SlotClass):
	PlayerInventory.add_item_to_empty_slot(find_parent("UserInterface").holding_item, slot)
	slot.putIntoSlot(find_parent("UserInterface").holding_item)
	find_parent("UserInterface").holding_item = null
	
func left_click_different_item(event: InputEvent, slot: SlotClass):
	PlayerInventory.remove_item(slot)
	PlayerInventory.add_item_to_empty_slot(find_parent("UserInterface").holding_item, slot)
	var temp_item = slot.item
	slot.pickFromSlot()
	temp_item.global_position = event.global_position
	slot.putIntoSlot(find_parent("UserInterface").holding_item)
	find_parent("UserInterface").holding_item = temp_item

func left_click_same_item(slot: SlotClass):
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
