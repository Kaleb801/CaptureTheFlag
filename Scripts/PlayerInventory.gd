extends Node

signal active_item_updated

const SlotClass = preload("res://Scripts/Slot.gd")
const ItemClass = preload("res://Scripts/Item.gd")
const NUM_INVENTORY_SLOTS = 20
const NUM_HOTBAR_SLOTS = 8

var copperHelmet = preload("res://Images/copperHelmetanim.png")
var copperChest = preload("res://Images/copperchestanim.png")
var copperLegs = preload("res://Images/copperleganim.png")
var copperBoot = preload("res://Images/copperbootsanim.png")

var ironHelmet = preload("res://Images/ironHelmetanim.png")
var ironChest = preload("res://Images/ironchestanim.png")
var ironLegs = preload("res://Images/ironleganim.png")
var ironBoot = preload("res://Images/ironbootsanim.png")

var mythrilHelmet = preload("res://Images/mythrilHelmetanim.png")
var mythrilChest = preload("res://Images/mythrilchestanim.png")
var mythrilLegs = preload("res://Images/mythrilleganim.png")
var mythrilBoot = preload("res://Images/mythrilbootsanim.png")

var adamantHelmet = preload("res://Images/adamantHelmetanim.png")
var adamantChest = preload("res://Images/adamantchestanim.png")
var adamantLegs = preload("res://Images/adamantleganim.png")
var adamantBoot = preload("res://Images/adamantbootsanim.png")

var dragoniteHelmet = preload("res://Images/dragoniteHelmetanim.png")
var dragoniteChest = preload("res://Images/dragonitechestanim.png")
var dragoniteLegs = preload("res://Images/dragoniteleganim.png")
var dragoniteBoot = preload("res://Images/dragonitebootsanim.png")


var orangecloak = preload("res://Images/orangecloakanim.png")
var graycloak = preload("res://Images/graycloakanim.png")
var bluecloak = preload("res://Images/bluecloakanim.png")
var greencloak = preload("res://Images/greencloakanim.png")
var redcloak = preload("res://Images/redcloakanim.png")
var orangehat = preload("res://Images/hatnim.png")
var grayhat = preload("res://Images/grayhatnim.png")
var bluehat = preload("res://Images/bluehatnim.png")
var greenhat = preload("res://Images/greenhatnim.png")
var redhat = preload("res://Images/redhatnim.png")
var orangeskirt=preload("res://Images/skirtanim.png")
var grayskirt=preload("res://Images/grayskirtanim.png")
var blueskirt=preload("res://Images/blueskirtanim.png")
var greenskirt = preload("res://Images/greenkirtanim.png")
var redskirt = preload("res://Images/redkirtanim.png")

var slots
var slots2
var player
var active_item_slot = 0
var stage

var inventory={
	
}

var hotbar={
0: ["Copper pickaxe", 1],
1: ["Copper axe", 1],
2: ["Torch", 5]
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
	stage = get_tree().get_current_scene().get_node("/root/stage")
	var playerNode
	var shield
	if player=="player1":
		shield=stage.shield1
		playerNode=stage.get_node("player1")
	else:
		shield=stage.shield2
		playerNode=stage.get_node("player2")
	if slot.slotType==0:
		hotbar.erase(slot.slot_index)
	elif slot.slotType==1:
		inventory.erase(slot.slot_index)
	elif slot.slotType==2:
		if equips[slot.slot_index][0]=="Copper Helmet":
			stage.rpc("set_shield",-1,player)
		if equips[slot.slot_index][0]=="Iron Helmet":
			stage.rpc("set_shield",-2,player)
		if equips[slot.slot_index][0]=="Mythril Helmet":
			stage.rpc("set_shield",-3,player)
		if equips[slot.slot_index][0]=="Adamant Helmet":
			stage.rpc("set_shield",-4,player)
		if equips[slot.slot_index][0]=="Dragonite Helmet":
			stage.rpc("set_shield",-5,player)
		if equips[slot.slot_index][0]=="Garnet Hat":
			stage.rpc("set_shield",-1,player)
		if equips[slot.slot_index][0]=="Opal Hat":
			stage.rpc("set_shield",-2,player)
		if equips[slot.slot_index][0]=="Sapphire Hat":
			stage.rpc("set_shield",-3,player)
		if equips[slot.slot_index][0]=="Emerald Hat":
			stage.rpc("set_shield",-4,player)
		if equips[slot.slot_index][0]=="Ruby Hat":
			stage.rpc("set_shield",-5,player)
		equips.erase(slot.slot_index)
		playerNode.get_node("Animations/HatBase").visible=false
	elif slot.slotType==3:
		if equips[slot.slot_index][0]=="Copper ChestPlate":
			stage.rpc("set_shield",-1,player)
		if equips[slot.slot_index][0]=="Iron ChestPlate":
			stage.rpc("set_shield",-2,player)
		if equips[slot.slot_index][0]=="Mythril ChestPlate":
			stage.rpc("set_shield",-3,player)
		if equips[slot.slot_index][0]=="Adamant ChestPlate":
			stage.rpc("set_shield",-4,player)
		if equips[slot.slot_index][0]=="Dragonite ChestPlate":
			stage.rpc("set_shield",-5,player)
		if equips[slot.slot_index][0]=="Garnet Robe":
			stage.rpc("set_shield",-1,player)
		if equips[slot.slot_index][0]=="Opal Robe":
			stage.rpc("set_shield",-2,player)
		if equips[slot.slot_index][0]=="Sapphire Robe":
			stage.rpc("set_shield",-3,player)
		if equips[slot.slot_index][0]=="Emerald Robe":
			stage.rpc("set_shield",-4,player)
		if equips[slot.slot_index][0]=="Ruby Robe":
			stage.rpc("set_shield",-5,player)
		equips.erase(slot.slot_index)
		playerNode.get_node("Animations/ChestsBase").visible=false
	elif slot.slotType==4:
		if equips[slot.slot_index][0]=="Copper Legs":
			stage.rpc("set_shield",-1,player)
		if equips[slot.slot_index][0]=="Iron Legs":
			stage.rpc("set_shield",-2,player)
		if equips[slot.slot_index][0]=="Mythril Legs":
			stage.rpc("set_shield",-3,player)
		if equips[slot.slot_index][0]=="Adamant Legs":
			stage.rpc("set_shield",-4,player)
		if equips[slot.slot_index][0]=="Dragonite Legs":
			stage.rpc("set_shield",-5,player)
		if equips[slot.slot_index][0]=="Garnet Skirt":
			stage.rpc("set_shield",-1,player)
		if equips[slot.slot_index][0]=="Opal Skirt":
			stage.rpc("set_shield",-2,player)
		if equips[slot.slot_index][0]=="Sapphire Skirt":
			stage.rpc("set_shield",-3,player)
		if equips[slot.slot_index][0]=="Emerald Skirt":
			stage.rpc("set_shield",-4,player)
		if equips[slot.slot_index][0]=="Ruby Skirt":
			stage.rpc("set_shield",-5,player)
		equips.erase(slot.slot_index)
		playerNode.get_node("Animations/LegsBase").visible=false
	elif slot.slotType==5:
		if equips[slot.slot_index][0]=="Copper Boots":
			stage.rpc("set_shield",-1,player)
		if equips[slot.slot_index][0]=="Iron Boots":
			stage.rpc("set_shield",-2,player)
		if equips[slot.slot_index][0]=="Mythril Boots":
			stage.rpc("set_shield",-3,player)
		if equips[slot.slot_index][0]=="Adamant Boots":
			stage.rpc("set_shield",-4,player)
		if equips[slot.slot_index][0]=="Dragonite Boots":
			stage.rpc("set_shield",-5,player)
		if equips[slot.slot_index][0]=="Garnet Shoes":
			stage.rpc("set_shield",-1,player)
		if equips[slot.slot_index][0]=="Opal Shoes":
			stage.rpc("set_shield",-2,player)
		if equips[slot.slot_index][0]=="Sapphire Shoes":
			stage.rpc("set_shield",-3,player)
		if equips[slot.slot_index][0]=="Emerald Shoes":
			stage.rpc("set_shield",-4,player)
		if equips[slot.slot_index][0]=="Ruby Shoes":
			stage.rpc("set_shield",-5,player)
		equips.erase(slot.slot_index)
		playerNode.get_node("Animations/BootsBase").visible=false

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	stage = get_tree().get_current_scene().get_node("/root/stage")
	var playerNode
	if player=="player1":
		playerNode=stage.get_node("player1")
	else:
		playerNode=stage.get_node("player2")
	if slot.slotType==0:
		hotbar[slot.slot_index] = [item.item_name, item.item_quantity]
	elif slot.slotType==1:
		inventory[slot.slot_index] = [item.item_name, item.item_quantity]
	elif slot.slotType==2:
		equips[slot.slot_index] = [item.item_name, item.item_quantity]
		if item.item_name=="Copper Helmet":
			stage.rpc("set_shield",1,player)
			playerNode.get_node("Animations/HatBase").texture=copperHelmet
			playerNode.get_node("Animations/HatBase").visible=true
		if item.item_name=="Iron Helmet":
			stage.rpc("set_shield",2,player)
			playerNode.get_node("Animations/HatBase").texture=ironHelmet
			playerNode.get_node("Animations/HatBase").visible=true
		if item.item_name=="Mythril Helmet":
			stage.rpc("set_shield",3,player)
			playerNode.get_node("Animations/HatBase").texture=mythrilHelmet
			playerNode.get_node("Animations/HatBase").visible=true
		if item.item_name=="Adamant Helmet":
			stage.rpc("set_shield",4,player)
			playerNode.get_node("Animations/HatBase").texture=adamantHelmet
			playerNode.get_node("Animations/HatBase").visible=true
		if item.item_name=="Dragonite Helmet":
			stage.rpc("set_shield",5,player)
			playerNode.get_node("Animations/HatBase").texture=dragoniteHelmet
			playerNode.get_node("Animations/HatBase").visible=true
		if item.item_name=="Garnet Hat":
			stage.rpc("set_shield",1,player)
			playerNode.get_node("Animations/HatBase").texture=orangehat
			playerNode.get_node("Animations/HatBase").visible=true
		if item.item_name=="Opal Hat":
			stage.rpc("set_shield",2,player)
			playerNode.get_node("Animations/HatBase").texture=grayhat
			playerNode.get_node("Animations/HatBase").visible=true
		if item.item_name=="Sapphire Hat":
			stage.rpc("set_shield",3,player)
			playerNode.get_node("Animations/HatBase").texture=bluehat
			playerNode.get_node("Animations/HatBase").visible=true
		if item.item_name=="Emerald Hat":
			stage.rpc("set_shield",4,player)
			playerNode.get_node("Animations/HatBase").texture=greenhat
			playerNode.get_node("Animations/HatBase").visible=true
		if item.item_name=="Ruby Hat":
			stage.rpc("set_shield",5,player)
			playerNode.get_node("Animations/HatBase").texture=redhat
			playerNode.get_node("Animations/HatBase").visible=true
	elif slot.slotType==3:
		equips[slot.slot_index] = [item.item_name, item.item_quantity]
		if item.item_name=="Copper ChestPlate":
			stage.rpc("set_shield",1,player)
			playerNode.get_node("Animations/ChestsBase").texture=copperChest
			playerNode.get_node("Animations/ChestsBase").visible=true
		if item.item_name=="Iron ChestPlate":
			stage.rpc("set_shield",2,player)
			playerNode.get_node("Animations/ChestsBase").texture=ironChest
			playerNode.get_node("Animations/ChestsBase").visible=true
		if item.item_name=="Mythril ChestPlate":
			stage.rpc("set_shield",3,player)
			playerNode.get_node("Animations/ChestsBase").texture=mythrilChest
			playerNode.get_node("Animations/ChestsBase").visible=true
		if item.item_name=="Adamant ChestPlate":
			stage.rpc("set_shield",4,player)
			playerNode.get_node("Animations/ChestsBase").texture=adamantChest
			playerNode.get_node("Animations/ChestsBase").visible=true
		if item.item_name=="Dragonite ChestPlate":
			stage.rpc("set_shield",5,player)
			playerNode.get_node("Animations/ChestsBase").texture=dragoniteChest
			playerNode.get_node("Animations/ChestsBase").visible=true
		if item.item_name=="Garnet Robe":
			stage.rpc("set_shield",1,player)
			playerNode.get_node("Animations/ChestsBase").texture=orangecloak
			playerNode.get_node("Animations/ChestsBase").visible=true
		if item.item_name=="Opal Robe":
			stage.rpc("set_shield",2,player)
			playerNode.get_node("Animations/ChestsBase").texture=graycloak
			playerNode.get_node("Animations/ChestsBase").visible=true
		if item.item_name=="Sapphire Robe":
			stage.rpc("set_shield",3,player)
			playerNode.get_node("Animations/ChestsBase").texture=bluecloak
			playerNode.get_node("Animations/ChestsBase").visible=true
		if item.item_name=="Emerald Robe":
			stage.rpc("set_shield",4,player)
			playerNode.get_node("Animations/ChestsBase").texture=greencloak
			playerNode.get_node("Animations/ChestsBase").visible=true
		if item.item_name=="Ruby Robe":
			stage.rpc("set_shield",5,player)
			playerNode.get_node("Animations/ChestsBase").texture=redcloak
			playerNode.get_node("Animations/ChestsBase").visible=true
	elif slot.slotType==4:
		equips[slot.slot_index] = [item.item_name, item.item_quantity]
		if item.item_name=="Copper Legs":
			stage.rpc("set_shield",1,player)
			playerNode.get_node("Animations/LegsBase").texture=copperLegs
			playerNode.get_node("Animations/LegsBase").visible=true
		if item.item_name=="Iron Legs":
			stage.rpc("set_shield",2,player)
			playerNode.get_node("Animations/LegsBase").texture=ironLegs
			playerNode.get_node("Animations/LegsBase").visible=true
		if item.item_name=="Mythril Legs":
			stage.rpc("set_shield",3,player)
			playerNode.get_node("Animations/LegsBase").texture=mythrilLegs
			playerNode.get_node("Animations/LegsBase").visible=true
		if item.item_name=="Adamant Legs":
			stage.rpc("set_shield",4,player)
			playerNode.get_node("Animations/LegsBase").texture=adamantLegs
			playerNode.get_node("Animations/LegsBase").visible=true
		if item.item_name=="Dragonite Legs":
			stage.rpc("set_shield",5,player)
			playerNode.get_node("Animations/LegsBase").texture=dragoniteLegs
			playerNode.get_node("Animations/LegsBase").visible=true
		if item.item_name=="Garnet Skirt":
			stage.rpc("set_shield",1,player)
			playerNode.get_node("Animations/LegsBase").texture=orangeskirt
			playerNode.get_node("Animations/LegsBase").visible=true
		if item.item_name=="Opal Skirt":
			stage.rpc("set_shield",2,player)
			playerNode.get_node("Animations/LegsBase").texture=grayskirt
			playerNode.get_node("Animations/LegsBase").visible=true
		if item.item_name=="Sapphire Skirt":
			stage.rpc("set_shield",3,player)
			playerNode.get_node("Animations/LegsBase").texture=blueskirt
			playerNode.get_node("Animations/LegsBase").visible=true
		if item.item_name=="Emerald Skirt":
			stage.rpc("set_shield",4,player)
			playerNode.get_node("Animations/LegsBase").texture=greenskirt
			playerNode.get_node("Animations/LegsBase").visible=true
		if item.item_name=="Ruby Skirt":
			stage.rpc("set_shield",5,player)
			playerNode.get_node("Animations/LegsBase").texture=redskirt
			playerNode.get_node("Animations/LegsBase").visible=true
	elif slot.slotType==5:
		equips[slot.slot_index] = [item.item_name, item.item_quantity]
		if item.item_name=="Copper Boots" or item.item_name=="Garnet Shoes":
			stage.rpc("set_shield",1,player)
			playerNode.get_node("Animations/BootsBase").texture=copperBoot
			playerNode.get_node("Animations/BootsBase").visible=true
		if item.item_name=="Iron Boots" or item.item_name=="Opal Shoes":
			stage.rpc("set_shield",2,player)
			playerNode.get_node("Animations/BootsBase").texture=ironBoot
			playerNode.get_node("Animations/BootsBase").visible=true
		if item.item_name=="Mythril Boots" or item.item_name=="Sapphire Shoes":
			stage.rpc("set_shield",3,player)
			playerNode.get_node("Animations/BootsBase").texture=mythrilBoot
			playerNode.get_node("Animations/BootsBase").visible=true
		if item.item_name=="Adamant Boots" or item.item_name=="Emerald Shoes":
			stage.rpc("set_shield",4,player)
			playerNode.get_node("Animations/BootsBase").texture=adamantBoot
			playerNode.get_node("Animations/BootsBase").visible=true
		if item.item_name=="Dragonite Boots" or item.item_name=="Ruby Shoes":
			stage.rpc("set_shield",5,player)
			playerNode.get_node("Animations/BootsBase").texture=dragoniteBoot
			playerNode.get_node("Animations/BootsBase").visible=true

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
		var item_name =inventory[slot.slot_index][0]
		inventory[slot.slot_index][1] += quantity_to_add
		var quantity =inventory[slot.slot_index][1]
		if inventory[slot.slot_index][1]==0:
			remove_item(slot)
		if quantity_to_add<=0:
			slot.clear(item_name,quantity)
	else:
		equips[slot.slot_index][1] += quantity_to_add

###
### Hotbar Related Functions
func active_item_scroll() -> void:
	if Input.is_action_pressed("1"):
		active_item_slot=0
	elif Input.is_action_pressed("2"):
		active_item_slot=1
	elif Input.is_action_pressed("3"):
		active_item_slot=2
	elif Input.is_action_pressed("4"):
		active_item_slot=3
	elif Input.is_action_pressed("5"):
		active_item_slot=4
	elif Input.is_action_pressed("6"):
		active_item_slot=5
	elif Input.is_action_pressed("7"):
		active_item_slot=6
	elif Input.is_action_pressed("8"):
		active_item_slot=7
		
	emit_signal("active_item_updated")
