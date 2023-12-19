extends Node2D

onready var craft_slots = $CraftSlots
const SlotClass = preload("res://Scripts/Slot.gd")
var Item = preload("res://Scenes/Item.tscn")
var sprite = preload("res://Scenes/Sprite.tscn")
var tableArea = false
var furnaceArea = false
var anvilArea = false
var currentIndex = 0
var chestCraft = false

var tableCraft = false
var furnaceCraft = false
var vaseCraft = false
var glassCraft = false
var vialCraft = false

var attackPotCraft = false
var criticalPotCraft = false
var defensePotCraft = false
var energyPotCraft = false
var energyRegenPotCraft = false
var healingPotCraft = false
var healthRegenPotCraft = false
var recoilPotCraft = false
var spikesPotCraft = false
var velocityPotCraft = false

var doorCraft = false
var birchdoorCraft = false
var plumdoorCraft = false
var eucalyptusdoorCraft = false
var brazierdoorCraft = false

var woodWallCraft = false
var birchWallCraft = false
var plumWallCraft = false
var eucalyptusWallCraft = false
var brazierWallCraft = false

var copperBarCraft = false
var copperBootsCraft = false
var copperChestPlateCraft = false
var copperHelmetCraft = false
var copperLegsCraft = false
var copperSwordCraft = false

var ironBarCraft = false
var ironBootsCraft = false
var ironChestPlateCraft = false
var ironHelmetCraft = false
var ironLegsCraft = false
var ironSwordCraft = false

var mythrilBarCraft = false
var mythrilBootsCraft = false
var mythrilChestPlateCraft = false
var mythrilHelmetCraft = false
var mythrilLegsCraft = false
var mythrilSwordCraft = false

var adamantBarCraft = false
var adamantBootsCraft = false
var adamantChestPlateCraft = false
var adamantHelmetCraft = false
var adamantLegsCraft = false
var adamantSwordCraft = false

var dragoniteBarCraft = false
var dragoniteBootsCraft = false
var dragoniteChestPlateCraft = false
var dragoniteHelmetCraft = false
var dragoniteLegsCraft = false
var dragoniteSwordCraft = false

var garnetBootsCraft = false
var garnetHatCraft = false
var garnetRobeCraft = false
var garnetSkirtCraft = false
var garnetStaffCraft = false

var opalBootsCraft = false
var opalHatCraft = false
var opalRobeCraft = false
var opalSkirtCraft = false
var opalStaffCraft = false

var sapphireBootsCraft = false
var sapphireHatCraft = false
var sapphireRobeCraft = false
var sapphireSkirtCraft = false
var sapphireStaffCraft = false

var emeraldBootsCraft = false
var emeraldHatCraft = false
var emeraldRobeCraft = false
var emeraldSkirtCraft = false
var emeraldStaffCraft = false

var rubyBootsCraft = false
var rubyHatCraft = false
var rubyRobeCraft = false
var rubySkirtCraft = false
var rubyStaffCraft = false

var orangeclothCraft = false
var grayclothCraft = false
var blueclothCraft = false
var greenclothCraft = false
var redclothCraft = false

var ladderCraft = false
var charcoalCraft = false
var anvilCraft = false

var copperBombCraft = false
var ironBombCraft = false
var mythrilBombCraft = false
var adamantBombCraft = false
var dragoniteBombCraft = false

var copperPickCraft = false
var ironPickCraft = false
var mythrilPickCraft = false
var adamantPickCraft = false
var dragonitePickCraft = false

var copperAxeCraft = false
var ironAxeCraft = false
var mythrilAxeCraft = false
var adamantAxeCraft = false
var dragoniteAxeCraft = false

var woodDoorCraft = false
var birchDoorCraft = false
var plumDoorCraft = false
var eucalyptusDoorCraft = false
var brazierDoorCraft = false

var newpos
var stop = false
var array = [
]
var images = [
	
]
var tilemap
var i = 0
var j = 0

func _ready():
	tilemap = get_tree().get_current_scene().get_node("/root/stage/tile_map")
	var slots = craft_slots.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slot_index = i
		
func left_click_not_holding(slot: SlotClass):
	var stage= get_tree().get_current_scene().get_node("/root/stage")
	if slot.item.item_name=="Table":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Log",5)
		delete()
	elif slot.item.item_name=="Furnace":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Stone",9)
		delete()
	elif slot.item.item_name=="Vase":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Stone",7)
		minus("Sap",7)
		delete()
	elif slot.item.item_name=="Anvil":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Bar",3)
		delete()
	elif slot.item.item_name=="Copper Bar":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Stone",5)
		delete()
	elif slot.item.item_name=="Iron Bar":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Iron Stone",5)
		delete()
	elif slot.item.item_name=="Mythril Bar":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Myhril Stone",5)
		delete()
	elif slot.item.item_name=="Adamant Bar":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Adamant Stone",5)
		delete()
	elif slot.item.item_name=="Dragonite Bar":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Dragonite Stone",5)
		delete()
	elif slot.item.item_name=="Charcoal":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Log",3)
		delete()
	elif slot.item.item_name=="Copper Bomb":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Bar",5)
		minus("Charcoal",5)
		delete()
	elif slot.item.item_name=="Iron Bomb":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Iron Bar",5)
		minus("Charcoal",5)
		delete()
	elif slot.item.item_name=="Mythril Bomb":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Mythril Bar",5)
		minus("Charcoal",5)
		delete()
	elif slot.item.item_name=="Adamant Bomb":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Adamant Bar",5)
		minus("Charcoal",5)
		delete()
	elif slot.item.item_name=="Dragonite Bomb":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Dragonite Bar",5)
		minus("Charcoal",5)
		delete()
	elif slot.item.item_name=="Wood Wall":
		PlayerInventory.add_item(slot.item.item_name, 10)
		minus("Log",5)
		delete()
	elif slot.item.item_name=="Wood Door":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Log",5)
		delete()
	elif slot.item.item_name=="Birch Wall":
		PlayerInventory.add_item(slot.item.item_name, 10)
		minus("Birch Log",5)
		delete()
	elif slot.item.item_name=="Birch Door":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Birch Log",5)
		delete()
	elif slot.item.item_name=="Plum Wall":
		PlayerInventory.add_item(slot.item.item_name, 10)
		minus("Plum Log",5)
		delete()
	elif slot.item.item_name=="Plum Door":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Plum Log",5)
		delete()
	elif slot.item.item_name=="Eucalyptus Wall":
		PlayerInventory.add_item(slot.item.item_name, 10)
		minus("Eucalyptus Log",5)
		delete()
	elif slot.item.item_name=="Eucalyptus Door":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Eucalyptus Log",5)
		delete()
	elif slot.item.item_name=="Brazier Wall":
		PlayerInventory.add_item(slot.item.item_name, 10)
		minus("Brazier Log",5)
		delete()
	elif slot.item.item_name=="Brazier Door":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Brazier Log",5)
		delete()
	elif slot.item.item_name=="Copper Helmet":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Bar",5)
		delete()
	elif slot.item.item_name=="Iron Helmet":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Iron Bar",5)
		delete()
	elif slot.item.item_name=="Mythril Helmet":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Mythril Bar",5)
		delete()
	elif slot.item.item_name=="Adamant Helmet":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Adamant Bar",5)
		delete()
	elif slot.item.item_name=="Dragonite Helmet":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Dragonite Bar",5)
		delete()
	elif slot.item.item_name=="Copper ChestPlate":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Bar",5)
		delete()
	elif slot.item.item_name=="Iron ChestPlate":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Iron Bar",5)
		delete()
	elif slot.item.item_name=="Mythril ChestPlate":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Mythril Bar",5)
		delete()
	elif slot.item.item_name=="Adamant ChestPlate":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Adamant Bar",5)
		delete()
	elif slot.item.item_name=="Dragonite ChestPlate":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Dragonite Bar",5)
		delete()
	elif slot.item.item_name=="Copper Legs":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Bar",5)
		delete()
	elif slot.item.item_name=="Iron Legs":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Iron Bar",5)
		delete()
	elif slot.item.item_name=="Mythril Legs":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Mythril Bar",5)
		delete()
	elif slot.item.item_name=="Adamant Legs":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Adamant Bar",5)
		delete()
	elif slot.item.item_name=="Dragonite Legs":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Dragonite Bar",5)
		delete()
	elif slot.item.item_name=="Copper Boots":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Bar",5)
		delete()
	elif slot.item.item_name=="Iron Boots":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Iron Bar",5)
		delete()
	elif slot.item.item_name=="Mythril Boots":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Mythril Bar",5)
		delete()
	elif slot.item.item_name=="Adamant Boots":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Adamant Bar",5)
		delete()
	elif slot.item.item_name=="Dragonite Boots":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Dragonite Bar",5)
		delete()
	elif slot.item.item_name=="Copper Sword":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Bar",5)
		delete()
	elif slot.item.item_name=="Iron Sword":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Bar",5)
		delete()
	elif slot.item.item_name=="Mythril Sword":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Bar",5)
		delete()
	elif slot.item.item_name=="Adamant Sword":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Bar",5)
		delete()
	elif slot.item.item_name=="Dragonite Sword":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Bar",5)
		delete()
	elif slot.item.item_name=="Garnet Staff":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Log",5)
		delete()
	elif slot.item.item_name=="Opal Staff":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Birch Log",5)
		delete()
	elif slot.item.item_name=="Sapphire Staff":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Plum Log",5)
		delete()
	elif slot.item.item_name=="Emerald Staff":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Eucalyptus Log",5)
		delete()
	elif slot.item.item_name=="Ruby Staff":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Brazier Log",5)
		delete()
	elif slot.item.item_name=="Orange CLoth":
		PlayerInventory.add_item(slot.item.item_name, 3)
		minus("Orange Fiber",5)
		delete()
	elif slot.item.item_name=="Gray CLoth":
		PlayerInventory.add_item(slot.item.item_name, 3)
		minus("Gray Fiber",5)
		delete()
	elif slot.item.item_name=="Blue CLoth":
		PlayerInventory.add_item(slot.item.item_name, 3)
		minus("Blue Fiber",5)
		delete()
	elif slot.item.item_name=="Green CLoth":
		PlayerInventory.add_item(slot.item.item_name, 3)
		minus("Green Fiber",5)
		delete()
	elif slot.item.item_name=="Red CLoth":
		PlayerInventory.add_item(slot.item.item_name, 3)
		minus("Red Fiber",5)
		delete()
	elif slot.item.item_name=="Garnet Hat":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Orange Cloth",5)
		delete()
	elif slot.item.item_name=="Opal Hat":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Gray Cloth",5)
		delete()
	elif slot.item.item_name=="Sapphire Hat":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Blue Cloth",5)
		delete()
	elif slot.item.item_name=="Emerald Hat":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Green Cloth",5)
		delete()
	elif slot.item.item_name=="Ruby Hat":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Red Cloth",5)
		delete()
	elif slot.item.item_name=="Garnet Robe":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Orange Cloth",5)
		delete()
	elif slot.item.item_name=="Opal Robe":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Gray Cloth",5)
		delete()
	elif slot.item.item_name=="Sapphire Robe":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Blue Cloth",5)
		delete()
	elif slot.item.item_name=="Emerald Robe":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Green Cloth",5)
		delete()
	elif slot.item.item_name=="Ruby Robe":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Red Cloth",5)
		delete()
	elif slot.item.item_name=="Garnet Skirt":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Orange Cloth",5)
		delete()
	elif slot.item.item_name=="Opal Skirt":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Gray Cloth",5)
		delete()
	elif slot.item.item_name=="Sapphire Skirt":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Blue Cloth",5)
		delete()
	elif slot.item.item_name=="Emerald Skirt":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Green Cloth",5)
		delete()
	elif slot.item.item_name=="Ruby Skirt":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Red Cloth",5)
		delete()
	elif slot.item.item_name=="Garnet Boots":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Orange Cloth",5)
		delete()
	elif slot.item.item_name=="Opal Boots":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Gray Cloth",5)
		delete()
	elif slot.item.item_name=="Sapphire Boots":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Blue Cloth",5)
		delete()
	elif slot.item.item_name=="Emerald Boots":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Green Cloth",5)
		delete()
	elif slot.item.item_name=="Ruby Boots":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Red Cloth",5)
		delete()
	elif slot.item.item_name=="Glass":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Sand",5)
		delete()
	elif slot.item.item_name=="Vial":
		PlayerInventory.add_item(slot.item.item_name, 2)
		minus("Glass",1)
		delete()
	elif slot.item.item_name=="Attack Potion":
		PlayerInventory.add_item(slot.item.item_name, 2)
		minus("Vial",1)
		minus("Pepper",5)
		delete()
	elif slot.item.item_name=="Critical Attack Potion":
		PlayerInventory.add_item(slot.item.item_name, 2)
		minus("Vial",1)
		minus("Pepper",5)
		delete()
	elif slot.item.item_name=="Defense Potion":
		PlayerInventory.add_item(slot.item.item_name, 2)
		minus("Vial",1)
		minus("Beet",5)
		delete()
	elif slot.item.item_name=="Energy Potion":
		PlayerInventory.add_item(slot.item.item_name, 2)
		minus("Vial",1)
		minus("Carrot",5)
		delete()
	elif slot.item.item_name=="Energy Regen Potion":
		PlayerInventory.add_item(slot.item.item_name, 2)
		minus("Vial",1)
		minus("Onion",5)
		delete()
	elif slot.item.item_name=="Healing Potion":
		PlayerInventory.add_item(slot.item.item_name, 2)
		minus("Vial",1)
		minus("Carrot",5)
		delete()
	elif slot.item.item_name=="health Regen Potion":
		PlayerInventory.add_item(slot.item.item_name, 2)
		minus("Vial",1)
		minus("Onion",5)
		delete()
	elif slot.item.item_name=="Strong Energy Potion":
		PlayerInventory.add_item(slot.item.item_name, 2)
		minus("Vial",1)
		minus("Lettuce",5)
		delete()
	elif slot.item.item_name=="Strong Healing Potion":
		PlayerInventory.add_item(slot.item.item_name, 2)
		minus("Vial",1)
		minus("Lettuce",5)
		delete()
	elif slot.item.item_name=="Velocity Potion":
		PlayerInventory.add_item(slot.item.item_name, 2)
		minus("Vial",1)
		minus("Beet",5)
		delete()
	elif slot.item.item_name=="Copper Pickaxe":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Copper Bar",5)
		delete()
	elif slot.item.item_name=="Iron Pickaxe":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Iron Bar",5)
		delete()
	elif slot.item.item_name=="Mythril Pickaxe":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Mythril Bar",5)
		delete()
	elif slot.item.item_name=="Adamant Pickaxe":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Adamant Bar",5)
		delete()
	elif slot.item.item_name=="Dragonite Pickaxe":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Dragonite Bar",5)
		delete()
	elif slot.item.item_name=="Chest":
		PlayerInventory.add_item(slot.item.item_name, 1)
		minus("Log",9)
		delete()
	
	slot.pickFromSlot()
	find_parent("UserInterface").visual()

func slot_gui_input(event: InputEvent, slot: SlotClass):
	var slots = craft_slots.get_children()
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed && slot.item!=null:
			left_click_not_holding(slot)
				
func _update():
	var slots = craft_slots.get_children()
	var tableArea = false
	var furnaceArea = false
	var logs=0
	var dirt = 0
	var birchlogs=0
	var plumlogs=0
	var eucalyptuslogs=0
	var brazierlogs=0
	var sap=0
	var stones=0
	var copperStone=0
	var copperBar = 0
	var ironStone = 0
	var ironBar = 0
	var mythrilStone = 0
	var mythrilBar = 0
	var adamantStone = 0
	var adamantBar = 0
	var dragoniteStone = 0
	var dragoniteBar = 0
	var garnet = 0
	var opal = 0
	var sapphire = 0
	var emerald = 0
	var ruby = 0
	var orangefiber = 0
	var grayfiber = 0
	var bluefiber = 0
	var greenfiber = 0
	var redfiber = 0
	var OrangeCloth = 0
	var GrayCloth = 0
	var BlueCloth = 0
	var GreenCloth = 0
	var RedCloth = 0
	var carrot = 0
	var onion = 0
	var beet = 0
	var lettuce = 0
	var pepper = 0
	var charcoal = 0
	var sand = 0
	var glass = 0
	var vial = 0
	var stage = get_tree().get_current_scene().get_node("/root/stage")
	var player
	var skills
	
	if PlayerInventory.player=="player1":
		player=stage.get_node("player1")
		skills=stage.skills_p1
	else:
		player=stage.get_node("player2")
		skills=stage.skills_p2
	var ar= player.get_area()
	for area in ar:
		if tilemap.get_cellv(area)==31:
			furnaceArea = true
		if tilemap.get_cellv(area)==30:
			tableArea = true
		if tilemap.get_cellv(area)==35:
			anvilArea = true
		
	for slot in PlayerInventory.hotbar:
		if PlayerInventory.hotbar[slot][0]=="Vial":
			vial+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Glass":
			glass+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Sand":
			sand+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Charcoal":
			charcoal+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Pepper":
			pepper+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Lettuce":
			lettuce+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Beet":
			beet+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Onion":
			carrot+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Carrrot":
			carrot+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Orange Cloth":
			OrangeCloth+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Gray Cloth":
			GrayCloth+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Blue Cloth":
			BlueCloth+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Green Cloth":
			GreenCloth+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Red Cloth":
			RedCloth+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Orange Fiber":
			orangefiber+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Gray Fiber":
			grayfiber+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Blue Fiber":
			bluefiber+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Green Fiber":
			greenfiber+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Red Fiber":
			redfiber+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Dirt":
			dirt+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Log":
			logs+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Birch Log":
			birchlogs+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Plum Log":
			plumlogs+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Eucalyptus Log":
			eucalyptuslogs+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Brazier Log":
			brazierlogs+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Sap":
			sap+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Stone":
			stones+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Copper Stone":
			copperStone+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Copper Bar":
			copperBar+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Iron Stone":
			ironStone+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Iron Bar":
			ironBar+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Mythril Stone":
			mythrilStone+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Mythril Bar":
			mythrilBar+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Adamant Stone":
			adamantStone+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Adamant Bar":
			adamantBar+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Dragonite Stone":
			dragoniteStone+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Dragonite Bar":
			dragoniteBar+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Garnet":
			garnet+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Opal":
			opal+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Sapphire":
			sapphire+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Emerald":
			emerald+=PlayerInventory.hotbar[slot][1]
		if PlayerInventory.hotbar[slot][0]=="Ruby":
			ruby+=PlayerInventory.hotbar[slot][1]
	for slot in PlayerInventory.inventory:
		if PlayerInventory.inventory[slot][0]=="Vial":
			vial+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Glass":
			glass+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Sand":
			sand+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Charcoal":
			charcoal+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Pepper":
			pepper+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Lettuce":
			lettuce+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Beet":
			beet+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Onion":
			onion+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Carrot":
			carrot+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Orange Cloth":
			OrangeCloth+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Gray Cloth":
			GrayCloth+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Blue Cloth":
			BlueCloth+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Green Cloth":
			GreenCloth+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Red Cloth":
			RedCloth+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Orange Fiber":
			orangefiber+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Gray Fiber":
			grayfiber+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Blue Fiber":
			bluefiber+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Green Fiber":
			greenfiber+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Red Fiber":
			redfiber+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Dirt":
			dirt+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Log":
			logs+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Birch Log":
			birchlogs+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Plum Log":
			plumlogs+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Eucalyptus Log":
			eucalyptuslogs+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Brazier Log":
			brazierlogs+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Sap":
			sap+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Stone":
			stones+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Copper Stone":
			copperStone+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Copper Bar":
			copperBar+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Iron Stone":
			ironStone+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Iron Bar":
			ironBar+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Mythril Stone":
			mythrilStone+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Mythril Bar":
			mythrilBar+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Adamant Stone":
			adamantStone+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Adamant Bar":
			adamantBar+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Dragonite Stone":
			dragoniteStone+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Dragonite Bar":
			dragoniteBar+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Garnet":
			garnet+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Opal":
			opal+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Sapphire":
			sapphire+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Emerald":
			emerald+=PlayerInventory.inventory[slot][1]
		if PlayerInventory.inventory[slot][0]=="Ruby":
			ruby+=PlayerInventory.inventory[slot][1]
	for socket in slots:
		socket.clear(socket,0)
		if socket.item==null and tableCraft==false and logs>=5 and space():
			var item = Item.instance()
			item.item_name="Table"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			tableCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and furnaceCraft==false and stones>=9 and tableArea==true:
			var item = Item.instance()
			item.item_name="Furnace"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			furnaceCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and chestCraft==false and logs>=9 and tableArea==true:
			var item = Item.instance()
			item.item_name="Chest"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			chestCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and vaseCraft==false and stones>=7 and sap>=7 and tableArea==true:
			var item = Item.instance()
			item.item_name="Vase"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			vaseCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and anvilCraft==false and logs>=3 and furnaceArea==true:
			var item = Item.instance()
			item.item_name="Charcoal"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			anvilCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and copperBarCraft==false and copperStone>=5 and furnaceArea==true:
			var item = Item.instance()
			item.item_name="Copper Bar"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			copperBarCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and ironBarCraft==false and ironStone>=5 and furnaceArea==true:
			var item = Item.instance()
			item.item_name="Iron Bar"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			ironBarCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and mythrilBarCraft==false and mythrilStone>=5 and furnaceArea==true:
			var item = Item.instance()
			item.item_name="Mythril Bar"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			mythrilBarCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and adamantBarCraft==false and adamantStone>=5 and furnaceArea==true:
			var item = Item.instance()
			item.item_name="Adamant Bar"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			adamantBarCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and dragoniteBarCraft==false and dragoniteStone>=5 and furnaceArea==true:
			var item = Item.instance()
			item.item_name="Adamant Bar"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			dragoniteBarCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and copperBombCraft==false and copperBar>=5 and charcoal>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Copper Bomb"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			copperBombCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and ironBombCraft==false and ironBar>=5 and charcoal>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Iron Bomb"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			ironBombCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and mythrilBombCraft==false and mythrilBar>=5 and charcoal>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Mythril Bomb"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			mythrilBombCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and adamantBombCraft==false and adamantBar>=5 and charcoal>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Adamant Bomb"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			adamantBombCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and dragoniteBombCraft==false and dragoniteBar>=5 and charcoal>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Dragonite Bomb"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			dragoniteBombCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and anvilCraft==false and copperBar>=3 and tableArea==true:
			var item = Item.instance()
			item.item_name="Anvil"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			anvilCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and woodWallCraft==false and logs>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Wood Wall"
			item.item_quantity=10
			item.update()
			socket.putIntoSlot(item)
			woodWallCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and birchWallCraft==false and birchlogs>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Birch Wall"
			item.item_quantity=10
			item.update()
			socket.putIntoSlot(item)
			birchWallCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and plumWallCraft==false and plumlogs>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Plum Wall"
			item.item_quantity=10
			item.update()
			socket.putIntoSlot(item)
			plumWallCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and eucalyptusWallCraft==false and eucalyptuslogs>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Eucalyptus Wall"
			item.item_quantity=10
			item.update()
			socket.putIntoSlot(item)
			eucalyptusWallCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and brazierWallCraft==false and brazierlogs>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Brazier Wall"
			item.item_quantity=10
			item.update()
			socket.putIntoSlot(item)
			brazierWallCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and woodDoorCraft==false and logs>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Wood Door"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			woodDoorCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and birchDoorCraft==false and birchlogs>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Birch Door"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			birchDoorCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and plumDoorCraft==false and plumlogs>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Plum Door"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			plumDoorCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and eucalyptusDoorCraft==false and eucalyptuslogs>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Eucalyptus Door"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			eucalyptusDoorCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and brazierDoorCraft==false and brazierlogs>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Brazier Door"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			brazierDoorCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and copperHelmetCraft==false and copperBar>=5 and anvilArea==true and skills[10]=="warrior":
			var item = Item.instance()
			item.item_name="Copper Helmet"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			copperHelmetCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and ironHelmetCraft==false and ironBar>=5 and anvilArea==true and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Iron Helmet"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			ironHelmetCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and mythrilHelmetCraft==false and mythrilBar>=5 and anvilArea==true  and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Mythril Helmet"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			mythrilHelmetCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and adamantHelmetCraft==false and adamantBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Adamant Helmet"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			adamantHelmetCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and dragoniteHelmetCraft==false and dragoniteBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Dragonite Helmet"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			dragoniteHelmetCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and copperChestPlateCraft==false and copperBar>=5 and anvilArea==true and skills[10]=="warrior":
			var item = Item.instance()
			item.item_name="Copper ChestPlate"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			copperChestPlateCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and ironChestPlateCraft==false and ironBar>=5 and anvilArea==true  and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Iron ChestPlate"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			ironChestPlateCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and mythrilChestPlateCraft==false and mythrilBar>=5 and anvilArea==true and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Mythril ChestPlate"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			mythrilChestPlateCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and adamantChestPlateCraft==false and adamantBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Adamant ChestPlate"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			adamantChestPlateCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and dragoniteChestPlateCraft==false and dragoniteBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Dragonite ChestPlate"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			dragoniteChestPlateCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and copperLegsCraft==false and copperBar>=5 and anvilArea==true and skills[10]=="warrior":
			var item = Item.instance()
			item.item_name="Copper Legs"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			copperLegsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and ironLegsCraft==false and ironBar>=5 and anvilArea==true and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Iron Legs"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			ironLegsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and mythrilLegsCraft==false and mythrilBar>=5 and anvilArea==true and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Mythril Legs"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			mythrilLegsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and adamantLegsCraft==false and adamantBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Adamant Legs"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			adamantLegsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and dragoniteLegsCraft==false and dragoniteBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Dragonite Legs"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			dragoniteLegsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and copperBootsCraft==false and copperBar>=5 and anvilArea==true and skills[10]=="warrior":
			var item = Item.instance()
			item.item_name="Copper Boots"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			copperBootsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and ironBootsCraft==false and ironBar>=5 and anvilArea==true and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Iron Boots"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			ironBootsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and mythrilBootsCraft==false and mythrilBar>=5 and anvilArea==true and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Mythril Boots"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			mythrilBootsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and adamantBootsCraft==false and adamantBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Adamant Boots"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			adamantBootsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and dragoniteBootsCraft==false and dragoniteBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Dragonite Boots"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			dragoniteBootsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and copperSwordCraft==false and copperBar>=5 and anvilArea==true and skills[10]=="warrior":
			var item = Item.instance()
			item.item_name="Copper Sword"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			copperSwordCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and ironSwordCraft==false and ironBar>=5 and anvilArea==true and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Iron Sword"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			ironSwordCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and mythrilSwordCraft==false and mythrilBar>=5 and anvilArea==true and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Mythril Sword"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			mythrilSwordCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and adamantSwordCraft==false and adamantBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Adamant Sword"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			adamantSwordCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and dragoniteSwordCraft==false and dragoniteBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Adamant Sword"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			dragoniteSwordCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and copperAxeCraft==false and copperBar>=5 and anvilArea==true and skills[10]=="warrior" or skills[10]=="wizard":
			var item = Item.instance()
			item.item_name="Copper Axe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			copperAxeCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and ironAxeCraft==false and ironBar>=5 and anvilArea==true and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Iron Axe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			ironAxeCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and mythrilAxeCraft==false and mythrilBar>=5 and anvilArea==true and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Mythril Axe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			mythrilAxeCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and copperAxeCraft==false and adamantBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Adamant Axe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			adamantAxeCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and dragoniteAxeCraft==false and dragoniteBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Dragonite Axe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			dragoniteAxeCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and copperPickCraft==false and copperBar>=5 and anvilArea==true and skills[10]=="warrior" or skills[10]=="wizard":
			var item = Item.instance()
			item.item_name="Copper Pickaxe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			copperPickCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and ironPickCraft==false and ironBar>=5 and anvilArea==true and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Iron Pickaxe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			ironPickCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and  mythrilPickCraft==false and mythrilBar>=5 and anvilArea==true and skills[11]=="hunter" or skills[11]=="engineer":
			var item = Item.instance()
			item.item_name="Mythril Pickaxe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			mythrilPickCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and adamantPickCraft==false and adamantBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Adamant Pickaxe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			adamantPickCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and dragonitePickCraft==false and dragoniteBar>=5 and anvilArea==true and skills[12]=="animalist" or skills[12]=="thief"or skills[12]=="demolisher"or skills[12]=="inventor":
			var item = Item.instance()
			item.item_name="Dragonite Pickaxe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			dragonitePickCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and garnetStaffCraft==false and logs>=5 and tableArea==true  and skills[10]=="wizard":
			var item = Item.instance()
			item.item_name="Garnet Staff"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			garnetStaffCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and opalStaffCraft==false and birchlogs>=5 and tableArea==true and skills[11]=="researcher" or skills[11]=="brewerist":
			var item = Item.instance()
			item.item_name="Opal Staff"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			opalStaffCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and sapphireStaffCraft==false and plumlogs>=5 and tableArea==true and skills[11]=="researcher" or skills[11]=="brewerist":
			var item = Item.instance()
			item.item_name="Sapphire Staff"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			sapphireStaffCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and emeraldStaffCraft==false and eucalyptuslogs>=5 and tableArea==true and skills[12]=="pastWizard" or skills[12]=="archaeologist" or skills[12]=="alchemist" or skills[12]=="shapeshifter":
			var item = Item.instance()
			item.item_name="Emerald Staff"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			emeraldStaffCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and rubyStaffCraft==false and brazierlogs>=5 and tableArea==true and skills[12]=="pastWizard" or skills[12]=="archaeologist" or skills[12]=="alchemist" or skills[12]=="shapeshifter":
			var item = Item.instance()
			item.item_name="Ruby Staff"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			rubyStaffCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and orangeclothCraft==false and orangefiber>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Orange Cloth"
			item.item_quantity=3
			item.update()
			socket.putIntoSlot(item)
			orangeclothCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and grayclothCraft==false and grayfiber>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Gray Cloth"
			item.item_quantity=3
			item.update()
			socket.putIntoSlot(item)
			grayclothCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and blueclothCraft==false and bluefiber>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Blue Cloth"
			item.item_quantity=3
			item.update()
			socket.putIntoSlot(item)
			blueclothCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and greenclothCraft==false and greenfiber>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Green Cloth"
			item.item_quantity=3
			item.update()
			socket.putIntoSlot(item)
			greenclothCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and orangeclothCraft==false and redfiber>=5 and tableArea==true:
			var item = Item.instance()
			item.item_name="Red Cloth"
			item.item_quantity=3
			item.update()
			socket.putIntoSlot(item)
			redclothCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and garnetHatCraft==false and OrangeCloth>=5 and tableArea==true and skills[10]=="wizard":
			var item = Item.instance()
			item.item_name="Garnet Hat"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			garnetHatCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and opalHatCraft==false and GrayCloth>=5 and tableArea==true and skills[11]=="researcher" or skills[11]=="brewerist":
			var item = Item.instance()
			item.item_name="Opal Hat"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			opalHatCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and sapphireHatCraft==false and BlueCloth>=5 and tableArea==true and skills[11]=="researcher" or skills[11]=="brewerist":
			var item = Item.instance()
			item.item_name="Sapphire Hat"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			sapphireHatCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and emeraldHatCraft==false and GreenCloth>=5 and tableArea==true and skills[12]=="pastWizard" or skills[12]=="archaeologist" or skills[12]=="alchemist" or skills[12]=="shapeshifter":
			var item = Item.instance()
			item.item_name="Emerald Hat"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			emeraldHatCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and rubyHatCraft==false and RedCloth>=5 and tableArea==true and skills[12]=="pastWizard" or skills[12]=="archaeologist" or skills[12]=="alchemist" or skills[12]=="shapeshifter":
			var item = Item.instance()
			item.item_name="Ruby Hat"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			rubyHatCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and garnetRobeCraft==false and OrangeCloth>=5 and tableArea==true and skills[10]=="wizard":
			var item = Item.instance()
			item.item_name="Garnet Robe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			garnetRobeCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and opalRobeCraft==false and GrayCloth>=5 and tableArea==true and skills[11]=="researcher" or skills[11]=="brewerist":
			var item = Item.instance()
			item.item_name="Opal Robe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			opalRobeCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and sapphireRobeCraft==false and BlueCloth>=5 and tableArea==true and skills[11]=="researcher" or skills[11]=="brewerist":
			var item = Item.instance()
			item.item_name="Sapphire Robe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			sapphireRobeCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and emeraldRobeCraft==false and GreenCloth>=5 and tableArea==true and skills[12]=="pastWizard" or skills[12]=="archaeologist" or skills[12]=="alchemist" or skills[12]=="shapeshifter":
			var item = Item.instance()
			item.item_name="Emerald Robe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			emeraldRobeCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and rubyRobeCraft==false and RedCloth>=5 and tableArea==true and skills[12]=="pastWizard" or skills[12]=="archaeologist" or skills[12]=="alchemist" or skills[12]=="shapeshifter":
			var item = Item.instance()
			item.item_name="Ruby Robe"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			rubyRobeCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and garnetSkirtCraft==false and OrangeCloth>=5 and tableArea==true and skills[10]=="wizard":
			var item = Item.instance()
			item.item_name="Garnet Skirt"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			garnetSkirtCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and opalSkirtCraft==false and GrayCloth>=5 and tableArea==true and skills[11]=="researcher" or skills[11]=="brewerist":
			var item = Item.instance()
			item.item_name="Opal Skirt"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			opalSkirtCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and sapphireSkirtCraft==false and BlueCloth>=5 and tableArea==true and skills[11]=="researcher" or skills[11]=="brewerist":
			var item = Item.instance()
			item.item_name="Sapphire Skirt"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			sapphireSkirtCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and emeraldSkirtCraft==false and  GreenCloth>=5 and tableArea==true and skills[12]=="pastWizard" or skills[12]=="archaeologist" or skills[12]=="alchemist" or skills[12]=="shapeshifter":
			var item = Item.instance()
			item.item_name="Emerald Skirt"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			emeraldSkirtCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and rubySkirtCraft==false and RedCloth>=5 and tableArea==true and skills[12]=="pastWizard" or skills[12]=="archaeologist" or skills[12]=="alchemist" or skills[12]=="shapeshifter":
			var item = Item.instance()
			item.item_name="Ruby Skirt"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			rubySkirtCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and garnetBootsCraft==false and OrangeCloth>=5 and tableArea==true and skills[10]=="wizard":
			var item = Item.instance()
			item.item_name="Garnet Boots"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			garnetBootsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and opalBootsCraft==false and GrayCloth>=5 and tableArea==true and skills[11]=="researcher" or skills[11]=="brewerist":
			var item = Item.instance()
			item.item_name="Opal Boots"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			opalBootsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and sapphireBootsCraft==false and BlueCloth>=5 and tableArea==true and skills[11]=="researcher" or skills[11]=="brewerist":
			var item = Item.instance()
			item.item_name="Sapphire Boots"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			sapphireBootsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and  emeraldBootsCraft==false and GreenCloth>=5 and tableArea==true and skills[12]=="pastWizard" or skills[12]=="archaeologist" or skills[12]=="alchemist" or skills[12]=="shapeshifter":
			var item = Item.instance()
			item.item_name="Emerald Boots"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			emeraldBootsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and space() and  rubyBootsCraft==false and RedCloth>=5 and tableArea==true and skills[12]=="pastWizard" or skills[12]=="archaeologist" or skills[12]=="alchemist" or skills[12]=="shapeshifter":
			var item = Item.instance()
			item.item_name="Ruby Boots"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			rubyBootsCraft=true
			images.append(item)
			i+=1
		if socket.item==null and glassCraft==false and sand>=5 and furnaceArea==true and space():
			var item = Item.instance()
			item.item_name="Glass"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			glassCraft=true
			images.append(item)
			i+=1
		if socket.item==null and vialCraft==false and glass>=1 and tableArea==true and space():
			var item = Item.instance()
			item.item_name="Vial"
			item.item_quantity=2
			item.update()
			socket.putIntoSlot(item)
			vialCraft=true
			images.append(item)
			i+=1
		if socket.item==null and attackPotCraft==false and vial>=1 and pepper>=5 and tableArea==true and space():
			var item = Item.instance()
			item.item_name="Attack Potion"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			attackPotCraft=true
			images.append(item)
			i+=1
		if socket.item==null and criticalPotCraft==false and vial>=1 and pepper>=5 and tableArea==true and space():
			var item = Item.instance()
			item.item_name="Critical Attack Potion"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			criticalPotCraft=true
			images.append(item)
			i+=1
		if socket.item==null and defensePotCraft==false and vial>=1 and beet>=5 and tableArea==true and space():
			var item = Item.instance()
			item.item_name="Defense Potion"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			defensePotCraft=true
			images.append(item)
			i+=1
		if socket.item==null and energyPotCraft==false and vial>=1 and carrot>=5 and tableArea==true and space():
			var item = Item.instance()
			item.item_name="Energy Potion"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			defensePotCraft=true
			images.append(item)
			i+=1
		if socket.item==null and energyRegenPotCraft==false and vial>=1 and onion>=5 and tableArea==true and space():
			var item = Item.instance()
			item.item_name="Energy Regen Potion"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			energyRegenPotCraft=true
			images.append(item)
			i+=1
		if socket.item==null and healingPotCraft==false and vial>=1 and carrot>=5 and tableArea==true and space():
			var item = Item.instance()
			item.item_name="Healing Potion"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			healingPotCraft=true
			images.append(item)
			i+=1
		if socket.item==null and healthRegenPotCraft==false and vial>=1 and onion>=5 and tableArea==true and space():
			var item = Item.instance()
			item.item_name="health Regen Potion"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			healthRegenPotCraft=true
			images.append(item)
			i+=1
		if socket.item==null and recoilPotCraft==false and vial>=1 and lettuce>=5 and tableArea==true and space():
			var item = Item.instance()
			item.item_name="Strong Energy Potion"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			recoilPotCraft=true
			images.append(item)
			i+=1
		if socket.item==null and spikesPotCraft==false and vial>=1 and lettuce>=5 and tableArea==true and space():
			var item = Item.instance()
			item.item_name="Strong Healing Potion"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			spikesPotCraft=true
			images.append(item)
			i+=1
		if socket.item==null and velocityPotCraft==false and vial>=1 and beet>=5 and tableArea==true and space():
			var item = Item.instance()
			item.item_name="Velocity Potion"
			item.item_quantity=1
			item.update()
			socket.putIntoSlot(item)
			velocityPotCraft=true
			images.append(item)
			i+=1
		j=0

func space():
	for slot in PlayerInventory.slots2:
		if slot.item==null:
			return true
	return false

func minus(prop,i):
	for slot in PlayerInventory.hotbar:
		var valid = false	
		if PlayerInventory.hotbar[slot][0]==prop and slot==PlayerInventory.slots[slot].slot_index:
			while PlayerInventory.slots[slot].item!=null:
				PlayerInventory.add_item_quantity(PlayerInventory.slots[slot],-1)
				i-=1
				if i<=0:
					return
	for slot in PlayerInventory.inventory:
		if PlayerInventory.inventory[slot][0]==prop and slot==PlayerInventory.slots2[slot].slot_index:
			while PlayerInventory.slots2[slot].item!=null:
				PlayerInventory.add_item_quantity(PlayerInventory.slots2[slot],-1)
				i-=1
				if i<=0:
					return


func delete():
	var slots = craft_slots.get_children()
	for socket in slots:
		socket.delete()
	for im in images:
		im.queue_free()
	images.clear()
	tableCraft = false
	furnaceCraft = false
	copperBarCraft = false
	copperBootsCraft = false
	copperChestPlateCraft = false
	copperHelmetCraft = false
	copperLegsCraft = false
	copperSwordCraft = false
	ironBarCraft = false
	ironBootsCraft = false
	ironChestPlateCraft = false
	ironHelmetCraft = false
	ironLegsCraft = false
	ironSwordCraft = false
	mythrilBarCraft = false
	mythrilBootsCraft = false
	mythrilChestPlateCraft = false
	mythrilHelmetCraft = false
	mythrilLegsCraft = false
	mythrilSwordCraft = false
	adamantBarCraft = false
	adamantBootsCraft = false
	adamantChestPlateCraft = false
	adamantHelmetCraft = false
	adamantLegsCraft = false
	adamantSwordCraft = false
	dragoniteBarCraft = false
	dragoniteBootsCraft = false
	dragoniteChestPlateCraft = false
	dragoniteHelmetCraft = false
	dragoniteLegsCraft = false
	dragoniteSwordCraft = false
	garnetBootsCraft = false
	garnetHatCraft = false
	garnetRobeCraft = false
	garnetSkirtCraft = false
	garnetStaffCraft = false
	opalBootsCraft = false
	opalHatCraft = false
	opalRobeCraft = false
	opalSkirtCraft = false
	opalStaffCraft = false
	sapphireBootsCraft = false
	sapphireHatCraft = false
	sapphireRobeCraft = false
	sapphireSkirtCraft = false
	sapphireStaffCraft = false
	emeraldBootsCraft = false
	emeraldHatCraft = false
	emeraldRobeCraft = false
	emeraldSkirtCraft = false
	emeraldStaffCraft = false
	rubyBootsCraft = false
	rubyHatCraft = false
	rubyRobeCraft = false
	rubySkirtCraft = false
	rubyStaffCraft = false
	woodWallCraft = false
	birchWallCraft = false
	plumWallCraft = false
	eucalyptusWallCraft = false
	brazierWallCraft = false
	doorCraft = false
	birchdoorCraft = false
	plumdoorCraft = false
	eucalyptusdoorCraft = false
	brazierdoorCraft = false
	vaseCraft = false
	orangeclothCraft = false
	grayclothCraft = false
	blueclothCraft = false
	greenclothCraft = false
	redclothCraft = false
	ladderCraft = false
	charcoalCraft = false
	anvilCraft = false
	copperBombCraft = false
	ironBombCraft = false
	mythrilBombCraft = false
	adamantBombCraft = false
	dragoniteBombCraft = false
	woodDoorCraft = false
	birchDoorCraft = false
	plumDoorCraft = false
	eucalyptusDoorCraft = false
	brazierDoorCraft = false
	glassCraft = false
	vialCraft = false
	attackPotCraft = false
	criticalPotCraft = false
	defensePotCraft = false
	energyPotCraft = false
	energyRegenPotCraft = false
	healingPotCraft = false
	healthRegenPotCraft = false
	recoilPotCraft = false
	spikesPotCraft = false
	velocityPotCraft = false
	copperPickCraft = false
	ironPickCraft = false
	mythrilPickCraft = false
	adamantPickCraft = false
	dragonitePickCraft = false
	copperAxeCraft = false
	ironAxeCraft = false
	mythrilAxeCraft = false
	adamantAxeCraft = false
	dragoniteAxeCraft = false
	chestCraft = false
	
func _on_Button_pressed():
	j = (j - 1 + images.size()) % images.size()
	updateslot()

func _on_Button2_pressed():
	j = (j + 1) % images.size()
	updateslot()

func updateslot():
	var slots = craft_slots.get_children()
	
	for slot in slots:
		slot.clear(slot,0)
	
	var k = j
	for slot in slots:
		if images.size() > 0:
			slot.putIntoSlot(images[k])
			k = (k + 1) % images.size()






