extends Node2D

const SlotClass = preload("res://Scripts/Slot.gd")
const sprite = preload("res://Scenes/Sprite.tscn")

var warriorIcon = preload("res://Images/warriorIcon.png")
var wizardIcon = preload("res://Images/wizardIcon.png")
var archerIcon = preload("res://Images/archerIcon.png")
var monkIcon = preload("res://Images/monkIcon.png")
var druidIcon = preload("res://Images/druidIcon.png")
var healerIcon = preload("res://Images/healerIcon.png")
var thievIcon = preload("res://Images/thievIcon.png")
var gunsmithIcon = preload("res://Images/gunsmithIcon.png")
var trapperIcon = preload("res://Images/trapperIcon.png")
var alchemistIcon = preload("res://Images/alchemistIcon.png")
var berserkerIcon = preload("res://Images/bersekerIcon.png")
var shapeshifterIcon = preload("res://Images/shapeshifterIcon.png")
var scribeIcon = preload("res://Images/scribeIcon.png")
var timeMageIcon = preload("res://Images/timeMageIcon.png")

var nightVisionIcon = preload("res://Images/nightVisionIcon.png")
var miningIcon = preload("res://Images/miningIcon.png")
var woodcuttingIcon = preload("res://Images/woodcuttingIcon.png")
var gemIcon = preload("res://Images/GemIcon.png")
var fruitIcon = preload("res://Images/fruitIcon.png")

var healthIcon = preload("res://Images/healthIcon.png")
var healthRegenIcon = preload("res://Images/healthRegenIcon.png")
var manaIcon = preload("res://Images/manaIcon.png")
var manaRegenIcon = preload("res://Images/manaRegenIcon.png")

var swordIcon= preload("res://Images/swordIcon.png")
var WarriorArmorIcon = preload("res://Images/daggerIcon.png")
var wizardArmorIcon = preload("res://Images/staffIcon.png")
var staffIcon = preload("res://Images/scepterIcon.png")
var arrowIcon = preload("res://Images/arrowIcon.png")

var rabbitIcon = preload("res://Images/rabbitIcon.png")
var recycleIcon = preload("res://Images/recycleIcon.png")
var rockIcon = preload("res://Images/rockIcon.png")
var seedIcon = preload("res://Images/seedIcon.png")
var plantIcon = preload("res://Images/plantIcon.png")
var moreIcon = preload("res://Images/moreIcon.png")
var bagIcon = preload("res://Images/bagIcon.png")
var bootsIcon = preload("res://Images/bootsIcon.png")

var redArrowIcon = preload("res://Images/redArrowIcon.png")
var knockbackIcon = preload("res://Images/knockbackIcon.png")
var shieldIcon = preload("res://Images/shieldIcon.png")
var critIcon = preload("res://Images/critIcon.png")

var pickaxeIcon = preload("res://Images/pickaxeIcon.png")
var herbIcon = preload("res://Images/herbIcon.png")
var lootIcon = preload("res://Images/lootIcon.png")
var axeIcon = preload("res://Images/axeIcon.png")

var lastSlot = null
var itens = [null, null]
var choices = [null, null]
var stage

func _ready():
	stage = get_tree().get_current_scene().get_node("/root/stage")
	stage.connect("exp_changed",self,"set_exp")
	connect_slots()
	connect_skill_slots()

func set_exp(value,player):
	$Skills/Class/UIFull.rect_size.x = value * 32
	if $Skills/Class/UIFull.rect_size.x>=320:
		$Skills/Level.text = str(int($Skills/Level.text) + 1)
		value=0
		if player=="player1":
			stage.class_p1=0
		else:
			stage.class_p2=0
		$Skills/Class/UIFull.rect_size.x = value * 32

func connect_slots():
	var slots = $Slots.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slot_index = i

func connect_skill_slots():
	var slots = $Skills/Slots.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slot_index = i

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if slot.name == "Choice1":
				set_choice_slot(slot, 0)
			elif slot.name == "Choice2":
				set_choice_slot(slot, 1)
			elif slot.item == null:
				if $Slots/Slot10.item != null:
					set_skill(slot)
				elif $Slots/Slot11.item != null:
					set_skill(slot)
				elif$Slots/Slot12.item != null:
					set_skill(slot)
				elif $Slots/Slot10.item != null:
					set_skill(slot)
				elif $Slots/Slot11.item != null:
					set_skill(slot)
				elif $Slots/Slot12.item != null:
					set_skill(slot)
				elif $Slots/Slot10.item != null:
					set_skill(slot)
				elif $Slots/Slot11.item != null:
					set_skill(slot)
				elif $Slots/Slot12.item != null:
					set_skill(slot)
				elif slot.name == "Slot10" and int(stage.get_node("UserInterface/Inventory/Skills/Skills/Level").text) >= 5:
					set_skill(slot)
				elif slot.name == "Slot11" and int(stage.get_node("UserInterface/Inventory/Skills/Skills/Level").text) >= 10 and $Slots/Slot10.item != null:
					set_skill(slot)
				elif slot.name == "Slot12" and int(stage.get_node("UserInterface/Inventory/Skills/Skills/Level").text) >= 15 and $Slots/Slot10.item != null and $Slots/Slot11.item != null:
					set_skill(slot)

func set_choice_slot(slot, choice_idx):
	var item = sprite.instance()
	item.texture = itens[choice_idx]
	lastSlot.putIntoSlot(item)
	$Skills/Slots/Choice1.delete()
	$Skills/Slots/Choice2.delete()
	$Labels.visible = true
	$Slots.visible = true
	$Skills.visible = false
	$Skills/Labels/Label.text = ""
	$Skills/Labels/Label2.text = ""
	if lastSlot.name == "Slot1":
		if PlayerInventory.player=="player1":
			stage.skills_p1[0]=choices[choice_idx]
		else:
			stage.skills_p2[0]=choices[choice_idx]
	if lastSlot.name == "Slot2":
		if PlayerInventory.player=="player1":
			stage.skills_p1[1]=choices[choice_idx]
		else:
			stage.skills_p2[1]=choices[choice_idx]
	if lastSlot.name == "Slot3":
		if PlayerInventory.player=="player1":
			stage.skills_p1[2]=choices[choice_idx]
		else:
			stage.skills_p2[2]=choices[choice_idx]
	if lastSlot.name == "Slot4":
		if PlayerInventory.player=="player1":
			stage.skills_p1[3]=choices[choice_idx]
			if stage.skills_p1[3]=="vigorous":
				stage.rpc("set_max_health",stage.max_health_p1+1,"player1")
			elif stage.skills_p1[3]=="vivacious":
				stage.rpc("set_hpregen",1,"player1")
			elif stage.skills_p1[3]=="energetic":
				stage.rpc("set_max_star",stage.max_star_p1+1,"player1")
			elif stage.skills_p1[3]=="strenuous":
				stage.rpc("set_spregen",1,"player1")
		else:
			stage.skills_p2[3]=choices[choice_idx]
			if stage.skills_p2[3]=="vigorous":
				stage.rpc("set_max_health",stage.max_health_p2+1,"player2")
			elif stage.skills_p2[3]=="vivacious":
				stage.rpc("set_hpregen",1,"player2")
			elif stage.skills_p2[3]=="energetic":
				stage.rpc("set_max_star",stage.max_star_p2+1,"player2")
			elif stage.skills_p2[3]=="strenuous":
				stage.rpc("set_spregen",1,"player2")
	if lastSlot.name == "Slot5":
		if PlayerInventory.player=="player1":
			stage.skills_p1[4]=choices[choice_idx]
			if stage.skills_p1[4]=="vigorous":
				stage.rpc("set_max_health",stage.max_health_p1+1,"player1")
			elif stage.skills_p1[4]=="vivacious":
				stage.rpc("set_hpregen",1,"player1")
			elif stage.skills_p1[4]=="energetic":
				stage.rpc("set_max_star",stage.max_star_p1+1,"player1")
			elif stage.skills_p1[4]=="strenuous":
				stage.rpc("set_spregen",1,"player1")
			elif stage.skills_p1[4]=="sprinter":
				stage.rpc("set_speed",1,"player1")
			elif stage.skills_p1[4]=="attacker":
				stage.rpc("set_sword",4,"player1")
			elif stage.skills_p1[4]=="analyzer":
				stage.rpc("set_critical",1,"player1")
			elif stage.skills_p1[4]=="defender":
				stage.rpc("set_shield",4,"player1")
		else:
			stage.skills_p2[4]=choices[choice_idx]
			if stage.skills_p2[4]=="vigorous":
				stage.rpc("set_max_health",stage.max_health_p2+1,"player2")
			elif stage.skills_p2[4]=="vivacious":
				stage.rpc("set_hpregen",1,"player2")
			elif stage.skills_p2[4]=="energetic":
				stage.rpc("set_max_star",stage.max_star_p2+1,"player2")
			elif stage.skills_p2[4]=="strenuous":
				stage.rpc("set_spregen",1,"player2")
			elif stage.skills_p2[4]=="sprinter":
				stage.rpc("set_speed",1,"player2")
			elif stage.skills_p2[4]=="attacker":
				stage.rpc("set_sword",4,"player2")
			elif stage.skills_p2[4]=="analyzer":
				stage.rpc("set_critical",1,"player2")
			elif stage.skills_p2[4]=="defender":
				stage.rpc("set_shield",4,"player2")
	if lastSlot.name == "Slot6":
		if PlayerInventory.player=="player1":
			stage.skills_p1[5]=choices[choice_idx]
			if stage.skills_p1[5]=="vigorous":
				stage.rpc("set_max_health",stage.max_health_p1+1,"player1")
			elif stage.skills_p1[5]=="vivacious":
				stage.rpc("set_hpregen",1,"player1")
			elif stage.skills_p1[5]=="energetic":
				stage.rpc("set_max_star",stage.max_star_p1+1,"player1")
			elif stage.skills_p1[5]=="strenuous":
				stage.rpc("set_spregen",1,"player1")
			elif stage.skills_p1[5]=="sprinter":
				stage.rpc("set_speed",1,"player1")
			elif stage.skills_p1[5]=="attacker":
				stage.rpc("set_sword",4,"player1")
			elif stage.skills_p1[5]=="analyzer":
				stage.rpc("set_critical",1,"player1")
			elif stage.skills_p1[5]=="defender":
				stage.rpc("set_shield",4,"player1")
			
		else:
			stage.skills_p2[5]=choices[choice_idx]
			if stage.skills_p2[5]=="vigorous":
				stage.rpc("set_max_health",stage.max_health_p2+1,"player2")
			elif stage.skills_p2[5]=="vivacious":
				stage.rpc("set_hpregen",1,"player2")
			elif stage.skills_p2[5]=="energetic":
				stage.rpc("set_max_star",stage.max_star_p2+1,"player2")
			elif stage.skills_p2[5]=="strenuous":
				stage.rpc("set_spregen",1,"player2")
			elif stage.skills_p2[5]=="sprinter":
				stage.rpc("set_speed",1,"player2")
			elif stage.skills_p2[5]=="attacker":
				stage.rpc("set_sword",4,"player2")
			elif stage.skills_p2[5]=="analyzer":
				stage.rpc("set_critical",1,"player2")
			elif stage.skills_p2[5]=="defender":
				stage.rpc("set_shield",4,"player2")
	if lastSlot.name == "Slot7":
		if PlayerInventory.player=="player1":
			stage.skills_p1[6]=choices[choice_idx]
		else:
			stage.skills_p2[6]=choices[choice_idx]
	if lastSlot.name == "Slot8":
		if PlayerInventory.player=="player1":
			stage.skills_p1[7]=choices[choice_idx]
		else:
			stage.skills_p2[7]=choices[choice_idx]
	if lastSlot.name == "Slot9":
		if PlayerInventory.player=="player1":
			stage.skills_p1[8]=choices[choice_idx]
		else:
			stage.skills_p2[8]=choices[choice_idx]
	if lastSlot.name == "Slot10":
		if PlayerInventory.player=="player1":
			stage.skills_p1[9]=choices[choice_idx]
		else:
			stage.skills_p2[9]=choices[choice_idx]
	if lastSlot.name == "Slot11":
		if PlayerInventory.player=="player1":
			stage.skills_p1[10]=choices[choice_idx]
		else:
			stage.skills_p2[10]=choices[choice_idx]
	if lastSlot.name == "Slot12":
		if PlayerInventory.player=="player1":
			stage.skills_p1[11]=choices[choice_idx]
		else:
			stage.skills_p2[11]=choices[choice_idx]

func set_skill(slot):
	if slot.name=="Slot1":
		if PlayerInventory.player == "player1":
			if stage.skills_p1[9] == "warrior":
				itens[0] = miningIcon
				choices[0] = "miner"
				itens[1] = woodcuttingIcon
				choices[1] = "woodcutter"
				set_choice_labels("Mining velocity +20%.", "Miner", "Woodcutting velocity +20%.", "Woodcutter",slot)
			elif stage.skills_p1[9] == "wizard":
				itens[0] = plantIcon
				choices[0] = "miner"
				itens[1] = rabbitIcon
				choices[1] = "woodcutter"
				set_choice_labels("Mining velocity +20%.", "Miner", "Woodcutting velocity +20%.", "Woodcutter",slot)
		else:
			if stage.skills_p2[9] == "warrior":
				itens[0] = miningIcon
				choices[0] = "miner"
				itens[1] = woodcuttingIcon
				choices[1] = "woodcutter"
				set_choice_labels("Mining velocity +20%.", "Miner", "Woodcutting velocity +20%.", "Woodcutter",slot)
			elif stage.skills_p2[9] == "wizard":
				itens[0] = plantIcon
				choices[0] = "miner"
				itens[1] = rabbitIcon
				choices[1] = "woodcutter"
				set_choice_labels("Mining velocity +20%.", "Miner", "Woodcutting velocity +20%.", "Woodcutter",slot)
	elif slot.name=="Slot2":
		if PlayerInventory.player == "player1":
			if stage.skills_p1[10] == "hunter":
				itens[0] = nightVisionIcon
				choices[0] = "cat"
				itens[1] = plantIcon
				choices[1] = "farmer"
				set_choice_labels("See more in the dark", "Woodcutter", "Plant growth speed + 20%","Farmer",slot)
			elif stage.skills_p1[10] == "engineer":
				itens[0] = bagIcon
				choices[0] = "herbologist"
				itens[1] = miningIcon
				choices[1] = "farmer"
				set_choice_labels("Chance to find extra herbs after collecting +20%", "Treasure Finder", "Farmer", "Plantologist",slot)
			elif stage.skills_p1[10] == "researcher":
				itens[0] = rabbitIcon
				choices[0] = "looter"
				itens[1] = recycleIcon
				choices[1] = "recycler"
				set_choice_labels("Chance of finding extra loot +20%.", "Looter", "Chance to find rarer itenss after recycling 20%.", "Recycler",slot)
			elif stage.skills_p1[10] == "researcher":
				itens[0] = seedIcon
				choices[0] = "farmer"
				itens[1] = plantIcon
				choices[1] = "plantologist"
				set_choice_labels("Plant growth speed + 20%", "Farmer", "chance to find rarer herbs 20%.", "Plantologist",slot)
		else:
			if stage.skills_p2[10] == "hunter":
				itens[0] = woodcuttingIcon
				choices[0] = "woodcutter"
				itens[1] = nightVisionIcon
				choices[1] = "cat"
				set_choice_labels("Woodcutting velocity +20%.", "Woodcutter", "See more in the dark","Cat",slot)
			elif stage.skills_p2[10] == "engineer":
				itens[0] = bagIcon
				choices[0] = "treasureFinder"
				itens[1] = miningIcon
				choices[1] = "miner"
				set_choice_labels("Chance to find rare itens after collecting +20%", "Treasure Finder", "Mining velocity +20%.", "Miner",slot)
			elif stage.skills_p2[10] == "researcher":
				itens[0] = rabbitIcon
				choices[0] = "looter"
				itens[1] = recycleIcon
				choices[1] = "recycler"
				set_choice_labels("Chance of finding extra loot +20%.", "Looter", "Chance to find rarer itenss after recycling 20%.", "Recycler",slot)
			elif stage.skills_p2[10] == "researcher":
				itens[0] = seedIcon
				choices[0] = "farmer"
				itens[1] = plantIcon
				choices[1] = "plantologist"
				set_choice_labels("Plant growth speed + 20%", "Farmer", "chance to find rare herbs 20%.", "Plantologist",slot)
	elif slot.name=="Slot3":
		if PlayerInventory.player == "player1":
			if stage.skills_p1[11] == "animalist":
				itens[0] = bagIcon
				choices[0] = "treasureFinder"
				itens[1] = woodcuttingIcon
				choices[1] = "woodcutter"
				set_choice_labels("Chance to find rare itens after collecting +20%", "Treasure Finder", "Woodcutting velocity +20%.","Woodcutter",slot)
			elif stage.skills_p1[11] == "thief":
				itens[0] = miningIcon
				choices[0] = "miner"
				itens[1] = nightVisionIcon
				choices[1] = "cat"
				set_choice_labels("Mining velocity +20%.", "Treasure Finder", "See more in the dark", "Cat",slot)
			elif stage.skills_p1[11] == "demolisher":
				itens[0] = woodcuttingIcon
				choices[0] = "woodcutter"
				itens[1] = bagIcon
				choices[1] = "treasureFinder"
				set_choice_labels("Woodcutting velocity +20%.", "Woodcutter", "Chance to find rare itens after collecting +20%.", "Treasure Finder",slot)
			elif stage.skills_p1[11] == "inventor":
				itens[0] = nightVisionIcon
				choices[0] = "cat"
				itens[1] =  miningIcon
				choices[1] = "miner"
				set_choice_labels("See more in the dark", "Cat", "Mining velocity +20%.", "Miner",slot)
			elif stage.skills_p1[11] == "pastWizard":
				itens[0] = seedIcon
				choices[0] = "farmer"
				itens[1] = recycleIcon
				choices[1] = "recycler"
				set_choice_labels("Plant growth speed + 20%", "Farmer", "Chance to find rarer itenss after recycling 20%.", "Recycler",slot)
			elif stage.skills_p1[11] == "brewerist":
				itens[0] = plantIcon
				choices[0] = "plantologist"
				itens[1] = rabbitIcon
				choices[1] = "looter"
				set_choice_labels("chance to find rarer herbs 20%.", "Plantologist", "Chance of finding extra loot +20%", "Looter",slot)
			elif stage.skills_p1[11] == "timeWizard":
				itens[0] = recycleIcon
				choices[0] = "recycler"
				itens[1] = seedIcon
				choices[1] = "farmer"
				set_choice_labels("Chance to find rarer itenss after recycling 20%.", "Recycler", "Plant growth speed + 20%", "Farmer",slot)
			elif stage.skills_p1[11] == "scribe":
				itens[0] = rabbitIcon
				choices[0] = "looter"
				itens[1] = plantIcon
				choices[1] = "plantologist"
				set_choice_labels("Chance of finding extra loot +20%", "Looter", "chance to find rarer herbs 20%.", "Plantologist",slot)
		else:
			if stage.skills_p2[11] == "animalist":
				itens[0] = bagIcon
				choices[0] = "treasureFinder"
				itens[1] = woodcuttingIcon
				choices[1] = "woodcutter"
				set_choice_labels("Chance to find rare itens after collecting +20%", "Treasure Finder", "Woodcutting velocity +20%.","Woodcutter",slot)
			elif stage.skills_p2[11] == "thief":
				itens[0] = miningIcon
				choices[0] = "miner"
				itens[1] = nightVisionIcon
				choices[1] = "cat"
				set_choice_labels("Mining velocity +20%.", "Treasure Finder", "See more in the dark", "Cat",slot)
			elif stage.skills_p2[11] == "demolisher":
				itens[0] = woodcuttingIcon
				choices[0] = "woodcutter"
				itens[1] = bagIcon
				choices[1] = "treasureFinder"
				set_choice_labels("Woodcutting velocity +20%.", "Woodcutter", "Chance to find rare itens after collecting +20%.", "Treasure Finder",slot)
			elif stage.skills_p2[11] == "inventor":
				itens[0] = nightVisionIcon
				choices[0] = "cat"
				itens[1] =  miningIcon
				choices[1] = "miner"
				set_choice_labels("See more in the dark", "Cat", "Mining velocity +20%.", "Miner",slot)
			elif stage.skills_p2[11] == "pastWizard":
				itens[0] = seedIcon
				choices[0] = "farmer"
				itens[1] = recycleIcon
				choices[1] = "recycler"
				set_choice_labels("Plant growth speed + 20%", "Farmer", "Chance to find rarer itenss after recycling 20%.", "Recycler",slot)
			elif stage.skills_p2[11] == "brewerist":
				itens[0] = plantIcon
				choices[0] = "plantologist"
				itens[1] = rabbitIcon
				choices[1] = "looter"
				set_choice_labels("chance to find rarer herbs 20%.", "Plantologist", "Chance of finding extra loot +20%", "Looter",slot)
			elif stage.skills_p2[11] == "timeWizard":
				itens[0] = recycleIcon
				choices[0] = "recycler"
				itens[1] = seedIcon
				choices[1] = "farmer"
				set_choice_labels("Chance to find rarer itenss after recycling 20%.", "Recycler", "Plant growth speed + 20%", "Farmer",slot)
			elif stage.skills_p2[11] == "scribe":
				itens[0] = rabbitIcon
				choices[0] = "looter"
				itens[1] = plantIcon
				choices[1] = "plantologist"
				set_choice_labels("Chance of finding extra loot +20%", "Looter", "chance to find rarer herbs 20%.", "Plantologist",slot)
	elif slot.name=="Slot4":
		if PlayerInventory.player == "player1":
			if stage.skills_p1[9] == "warrior":
				itens[0] = healthIcon
				choices[0] = "vigorous"
				itens[1] = healthRegenIcon
				choices[1] = "vivacious"
				set_choice_labels("Health +10%.", "Vigorous", "Health regeneration +10%.", "Vivacious",slot)
			elif stage.skills_p1[9] == "wizard":
				itens[0] = manaIcon
				choices[0] = "energetic"
				itens[1] = manaRegenIcon
				choices[1] = "strenuous"
				set_choice_labels("Mana +10%.", "Energetic", "Mana regeneration +10%.", "Strenuous",slot)
		else:
			if stage.skills_p2[9] == "warrior":
				itens[0] = healthIcon
				choices[0] = "vigorous"
				itens[1] = healthRegenIcon
				choices[1] = "vivacious"
				set_choice_labels("Health +10%.", "Vigorous", "Health regeneration +10%.", "Vivacious",slot)
			elif stage.skills_p2[9] == "wizard":
				itens[0] = manaIcon
				choices[0] = "energetic"
				itens[1] = manaRegenIcon
				choices[1] = "strenuous"
				set_choice_labels("Mana +10%.", "Energetic", "Mana regeneration +10%.", "Strenuous",slot)
	elif slot.name=="Slot5":
		if PlayerInventory.player == "player1":
			if stage.skills_p1[10] == "hunter":
				itens[0] = bootsIcon
				choices[0] = "sprinter"
				itens[1] = healthRegenIcon
				choices[1] = "vivacious"
				set_choice_labels("Movement speed +10%", "Sprinter", "Health regeneration +10%.", "Vivacious",slot)
			elif stage.skills_p1[10] == "engineer":
				itens[0] = knockbackIcon
				choices[0] = "attacker"
				itens[1] = healthIcon
				choices[1] = "vigorous"
				set_choice_labels("Attack +10%", "Attacker", "Health +10%.", "Vigorous",slot)
			elif stage.skills_p1[10] == "researcher":
				itens[0] = shieldIcon
				choices[0] = "defender"
				itens[1] = manaRegenIcon
				choices[1] = "strenuous"
				set_choice_labels("Defense + 20%", "Defender", "Mana regeneration +10%.", "Atrenuous",slot)
			elif stage.skills_p1[10] == "brewerist":
				itens[0] = critIcon
				choices[0] = "analyzer"
				itens[1] = manaIcon
				choices[1] = "energetic"
				set_choice_labels("Critical attack +10%", "Analyzer", "Mana +10%", "Energetic",slot)
		else:
			if stage.skills_p2[10] == "hunter":
				itens[0] = bootsIcon
				choices[0] = "sprinter"
				itens[1] = healthRegenIcon
				choices[1] = "vivacious"
				set_choice_labels("Movement speed +10%", "Sprinter", "Health regeneration +10%.", "Vivacious",slot)
			elif stage.skills_p2[10] == "engineer":
				itens[0] = knockbackIcon
				choices[0] = "attacker"
				itens[1] = healthIcon
				choices[1] = "vigorous"
				set_choice_labels("Attack +10%", "Attacker", "Health +10%.", "Vigorous",slot)
			elif stage.skills_p2[10] == "researcher":
				itens[0] = shieldIcon
				choices[0] = "defender"
				itens[1] = manaRegenIcon
				choices[1] = "strenuous"
				set_choice_labels("Defense + 20%", "Defender", "Mana regeneration +10%.", "Atrenuous",slot)
			elif stage.skills_p2[10] == "brewerist":
				itens[0] = critIcon
				choices[0] = "analyzer"
				itens[1] = manaIcon
				choices[1] = "energetic"
				set_choice_labels("Critical attack +10%", "Analyzer", "Mana +10%", "Energetic",slot)
	elif slot.name=="Slot6":
		if PlayerInventory.player == "player1":
			if stage.skills_p1[11] == "animalist":
				itens[0] = knockbackIcon
				choices[0] = "attacker"
				itens[1] = bootsIcon
				choices[1] = "sprinter"
				set_choice_labels("Attack +10%", "Attacker", "Movement speed +10%", "Sprinter",slot)
			elif stage.skills_p1[11] == "thief":
				itens[0] = healthIcon
				choices[0] = "vigorous"
				itens[1] = healthRegenIcon
				choices[1] = "vivacious"
				set_choice_labels("Health +10%.", "Vigorous", "Health regeneration +10%.", "Vivacious",slot)
			elif stage.skills_p1[11] == "demolisher":
				itens[0] = bootsIcon
				choices[0] = "sprinter"
				itens[1] = knockbackIcon
				choices[1] = "attacker"
				set_choice_labels("Movement speed +10%", "Sprinter", "Attack +10%", "Attacker",slot)
			elif stage.skills_p1[11] == "inventor":
				itens[0] = healthRegenIcon
				choices[0] = "vivacious"
				itens[1] = healthIcon
				choices[1] = "vigorous"
				set_choice_labels("Health regeneration +10%.", "Vivacious", "Health +10%", "Vigorous",slot)
			elif stage.skills_p1[11] == "pastWizard":
				itens[0] = critIcon
				choices[0] = "analyzer"
				itens[1] = shieldIcon
				choices[1] = "defender"
				set_choice_labels("Critical attack +10%", "Analyzer", "Defense +10%.", "Defender",slot)
			elif stage.skills_p1[11] == "archaeologist":
				itens[0] = manaIcon
				choices[0] = "energetic"
				itens[1] = manaRegenIcon
				choices[1] = "strenuous"
				set_choice_labels("Mana +10%.", "Energetic", "Mana regeneration +10%.", "Strenuous",slot)
			elif stage.skills_p1[11] == "alchemist":
				itens[0] = shieldIcon
				choices[0] = "defender"
				itens[1] = critIcon
				choices[1] = "analyzer"
				set_choice_labels("Defense + 20%", "Defender", "Critical attack +10%", "Analyzer",slot)
			elif stage.skills_p1[11] == "shapeshifter":
				itens[0] = manaRegenIcon
				choices[0] = "strenuous"
				itens[1] =  manaIcon
				choices[1] = "energetic"
				set_choice_labels("Mana regeneration +10%.", "Atrenuous", "Mana +10%", "Energetic",slot)
		else:
			if stage.skills_p2[11] == "animalist":
				itens[0] = knockbackIcon
				choices[0] = "attacker"
				itens[1] = bootsIcon
				choices[1] = "sprinter"
				set_choice_labels("Attack +10%", "Attacker", "Movement speed +10%", "Sprinter",slot)
			elif stage.skills_p2[11] == "thief":
				itens[0] = healthIcon
				choices[0] = "vigorous"
				itens[1] = healthRegenIcon
				choices[1] = "vivacious"
				set_choice_labels("Health +10%.", "Vigorous", "Health regeneration +10%.", "Vivacious",slot)
			elif stage.skills_p2[11] == "demolisher":
				itens[0] = bootsIcon
				choices[0] = "sprinter"
				itens[1] = knockbackIcon
				choices[1] = "attacker"
				set_choice_labels("Movement speed +10%", "Sprinter", "Attack +10%", "Attacker",slot)
			elif stage.skills_p2[11] == "inventor":
				itens[0] = healthRegenIcon
				choices[0] = "vivacious"
				itens[1] = healthIcon
				choices[1] = "vigorous"
				set_choice_labels("Health regeneration +10%.", "Vivacious", "Health +10%", "Vigorous",slot)
			elif stage.skills_p2[11] == "pastWizard":
				itens[0] = critIcon
				choices[0] = "analyzer"
				itens[1] = shieldIcon
				choices[1] = "defender"
				set_choice_labels("Critical attack +10%", "Analyzer", "Defense +10%.", "Defender",slot)
			elif stage.skills_p2[11] == "archaeologist":
				itens[0] = manaIcon
				choices[0] = "energetic"
				itens[1] = manaRegenIcon
				choices[1] = "strenuous"
				set_choice_labels("Mana +10%.", "Energetic", "Mana regeneration +10%.", "Strenuous",slot)
			elif stage.skills_p2[11] == "alchemist":
				itens[0] = shieldIcon
				choices[0] = "defender"
				itens[1] = critIcon
				choices[1] = "analyzer"
				set_choice_labels("Defense + 20%", "Defender", "Critical attack +10%", "Analyzer",slot)
			elif stage.skills_p2[11] == "shapeshifter":
				itens[0] = manaRegenIcon
				choices[0] = "strenuous"
				itens[1] =  manaIcon
				choices[1] = "energetic"
				set_choice_labels("Mana regeneration +10%.", "Atrenuous", "Mana +10%", "Energetic",slot)
	elif slot.name=="Slot7":
		if PlayerInventory.player == "player1":
			if stage.skills_p1[9] == "warrior":
				itens[0] = pickaxeIcon
				choices[0] = "coppersmither"
				itens[1] = axeIcon
				choices[1] = "woodcarpinter"
				set_choice_labels("Copper equipament, copper bomber, cure potion", "Smither", "Copper equipament, wood wall, energy potion", "Carpinter",slot)
			elif stage.skills_p1[9] == "wizard":
				itens[0] = herbIcon
				choices[0] = "brewerist"
				itens[1] = lootIcon
				choices[1] = "craftsman"
				set_choice_labels("Copper equipament, copper bomber, cure potion", "Smither", "Copper equipament, wood wall, energy potion", "Carpinter",slot)
		else:
			if stage.skills_p2[9] == "warrior":
				itens[0] = pickaxeIcon
				choices[0] = "coppersmither"
				itens[1] = axeIcon
				choices[1] = "woodcarpinter"
				set_choice_labels("Copper equipament, copper bomber, cure potion", "Smither", "Copper equipament, wood wall, energy potion", "Carpinter",slot)
			elif stage.skills_p2[9] == "wizard":
				itens[0] = herbIcon
				choices[0] = "brewerist"
				itens[1] = lootIcon
				choices[1] = "craftsman"
				set_choice_labels("Copper equipament, copper bomber, cure potion", "Smither", "Copper equipament, wood wall, energy potion", "Carpinter",slot)
	elif slot.name=="Slot8":
		if PlayerInventory.player == "player1":
			if stage.skills_p1[10] == "hunter":
				itens[0] = pickaxeIcon
				choices[0] = "smither"
				itens[1] = axeIcon
				choices[1] = "carpinter"
				set_choice_labels("Iron and mytrhil equipament, birch wall, defense potion", "Smither", "Iron and mytrhil equipament, mythril bomb, health regen", "Carpinter",slot)
			elif stage.skills_p1[10] == "engineer":
				itens[0] = axeIcon
				choices[0] = "carpinter"
				itens[1] = herbIcon
				choices[1] = "brewerist"
				set_choice_labels("Iron and mytrhil equipament, plum wall, energy regen potion", "Smither", "Iron and mytrhil equipament, iron bomb, velocity potion", "Carpinter",slot)
			elif stage.skills_p1[10] == "researcher":
				itens[0] = axeIcon
				choices[0] = "carpinter"
				itens[1] = lootIcon
				choices[1] = "craftsman"
				set_choice_labels("Iron and mytrhil equipament, birch wall, defense potion", "Smither", "Iron and mytrhil equipament, mythril bomb, health regen", "Carpinter",slot)
			elif stage.skills_p1[10] == "researcher":
				itens[0] = herbIcon
				choices[0] = "brewerist"
				itens[1] = lootIcon
				choices[1] = "craftsman"
				set_choice_labels("Iron and mytrhil equipament, plum wall, energy regen potion", "Smither", "Iron and mytrhil equipament, iron bomb, velocity potion", "Carpinter",slot)
		else:
			if stage.skills_p2[10] == "hunter":
				itens[0] = pickaxeIcon
				choices[0] = "smither"
				itens[1] = axeIcon
				choices[1] = "carpinter"
				set_choice_labels("Iron and mytrhil equipament, birch wall, defense potion", "Smither", "Iron and mytrhil equipament, mythril bomb, health regen", "Carpinter",slot)
			elif stage.skills_p2[10] == "engineer":
				itens[0] = axeIcon
				choices[0] = "carpinter"
				itens[1] = herbIcon
				choices[1] = "brewerist"
				set_choice_labels("Iron and mytrhil equipament, plum wall, energy regen potion", "Smither", "Iron and mytrhil equipament, iron bomb, velocity potion", "Carpinter",slot)
			elif stage.skills_p2[10] == "researcher":
				itens[0] = axeIcon
				choices[0] = "carpinter"
				itens[1] = lootIcon
				choices[1] = "craftsman"
				set_choice_labels("Iron and mytrhil equipament, birch wall, defense potion", "Smither", "Iron and mytrhil equipament, mythril bomb, health regen", "Carpinter",slot)
			elif stage.skills_p2[10] == "brewerist":
				itens[0] = herbIcon
				choices[0] = "brewerist"
				itens[1] = lootIcon
				choices[1] = "craftsman"
				set_choice_labels("Iron and mytrhil equipament, plum wall, energy regen potion", "Smither", "Iron and mytrhil equipament, iron bomb, velocity potion", "Carpinter",slot)
	elif slot.name=="Slot9":
		if PlayerInventory.player == "player1":
			if stage.skills_p1[11] == "animalist":
				itens[0] = pickaxeIcon
				choices[0] = "smither"
				itens[1] = axeIcon
				choices[1] = "carpinter"
				set_choice_labels("Adamant and dragonite equipament, attack potion", "Smither", "Adamant and dragonite equipament, adamant bomb", "Carpinter",slot)
			elif stage.skills_p1[11] == "thief":
				itens[0] = pickaxeIcon
				choices[0] = "smither"
				itens[1] = herbIcon
				choices[1] = "brewerist"
				set_choice_labels("Adamant and dragonite equipament, dragonite bomb", "Smither", "Adamant and dragonite equipament, recoil potion", "Carpinter",slot)
			elif stage.skills_p1[11] == "demolisher":
				itens[0] = pickaxeIcon
				choices[0] = "smither"
				itens[1] = herbIcon
				choices[1] = "defender"
				set_choice_labels("Adamant and dragonite equipament, brazier wall", "Smither", "Adamant and dragonite equipament, spike potion", "Carpinter",slot)
			elif stage.skills_p1[11] == "inventor":
				itens[0] = axeIcon
				choices[0] = "carpinter"
				itens[1] = herbIcon
				choices[1] = "brewerist"
				set_choice_labels("Adamant and dragonite equipament, critical attack potion", "Smither", "Adamant and dragonite equipament, eucalyptus wall", "Carpinter",slot)
			elif stage.skills_p1[11] == "pastWizard":
				itens[0] =axeIcon
				choices[0] = "carpinter"
				itens[1] = herbIcon
				choices[1] = "brewerist"
				set_choice_labels("Adamant and dragonite equipament, attack potion", "Smither", "Adamant and dragonite equipament, adamant bomb", "Carpinter",slot)
			elif stage.skills_p1[11] == "archaeologist":
				itens[0] = axeIcon
				choices[0] = "carpinter"
				itens[1] = lootIcon
				choices[1] = "craftsman"
				set_choice_labels("Adamant and dragonite equipament, dragonite bomb", "Smither", "Adamant and dragonite equipament, recoil potion", "Carpinter",slot)
			elif stage.skills_p1[11] == "alchemist":
				itens[0] = axeIcon
				choices[0] = "carpinter"
				itens[1] = lootIcon
				choices[1] = "craftsman"
				set_choice_labels("Adamant and dragonite equipament, brazier wall", "Smither", "Adamant and dragonite equipament, spike potion", "Carpinter",slot)
			elif stage.skills_p1[11] == "shapeshifter":
				itens[0] = herbIcon
				choices[0] = "brewerist"
				itens[1] = lootIcon
				choices[1] = "craftsman"
				set_choice_labels("Adamant and dragonite equipament, critical attack potion", "Smither", "Adamant and dragonite equipament, eucalyptus wall", "Carpinter",slot)
		else:
			if stage.skills_p2[11] == "animalist":
				itens[0] = pickaxeIcon
				choices[0] = "smither"
				itens[1] = axeIcon
				choices[1] = "carpinter"
				set_choice_labels("Adamant and dragonite equipament, attack potion", "Smither", "Adamant and dragonite equipament, adamant bomb", "Carpinter",slot)
			elif stage.skills_p2[11] == "thief":
				itens[0] = pickaxeIcon
				choices[0] = "smither"
				itens[1] = herbIcon
				choices[1] = "brewerist"
				set_choice_labels("Adamant and dragonite equipament, dragonite bomb", "Smither", "Adamant and dragonite equipament, recoil potion", "Carpinter",slot)
			elif stage.skills_p2[11] == "demolisher":
				itens[0] = pickaxeIcon
				choices[0] = "smither"
				itens[1] = herbIcon
				choices[1] = "defender"
				set_choice_labels("Adamant and dragonite equipament, brazier wall", "Smither", "Adamant and dragonite equipament, spike potion", "Carpinter",slot)
			elif stage.skills_p2[11] == "inventor":
				itens[0] = axeIcon
				choices[0] = "carpinter"
				itens[1] = herbIcon
				choices[1] = "brewerist"
				set_choice_labels("Adamant and dragonite equipament, critical attack potion", "Smither", "Adamant and dragonite equipament, eucalyptus wall", "Carpinter",slot)
			elif stage.skills_p2[11] == "pastWizard":
				itens[0] =axeIcon
				choices[0] = "carpinter"
				itens[1] = herbIcon
				choices[1] = "brewerist"
				set_choice_labels("Adamant and dragonite equipament, attack potion", "Smither", "Adamant and dragonite equipament, adamant bomb", "Carpinter",slot)
			elif stage.skills_p2[11] == "archaeologist":
				itens[0] = axeIcon
				choices[0] = "carpinter"
				itens[1] = lootIcon
				choices[1] = "craftsman"
				set_choice_labels("Adamant and dragonite equipament, dragonite bomb", "Smither", "Adamant and dragonite equipament, recoil potion", "Carpinter",slot)
			elif stage.skills_p2[11] == "alchemist":
				itens[0] = axeIcon
				choices[0] = "carpinter"
				itens[1] = lootIcon
				choices[1] = "craftsman"
				set_choice_labels("Adamant and dragonite equipament, brazier wall", "Smither", "Adamant and dragonite equipament, spike potion", "Carpinter",slot)
			elif stage.skills_p2[11] == "shapeshifter":
				itens[0] = herbIcon
				choices[0] = "brewerist"
				itens[1] = lootIcon
				choices[1] = "craftsman"
				set_choice_labels("Adamant and dragonite equipament, critical attack potion", "Smither", "Adamant and dragonite equipament, eucalyptus wall", "Carpinter",slot)
	elif slot.name == "Slot10":
		itens[0] = warriorIcon
		choices[0] = "warrior"
		itens[1] = wizardIcon
		choices[1] = "wizard"
		set_choice_labels("Hability: Dash with 'Q'.", "Warrior", "Hability: Levitate with 'Q'.", "Wizard",slot)
	elif slot.name == "Slot11":
		if PlayerInventory.player == "player1":
			if stage.skills_p1[9] == "warrior":
				itens[0] = archerIcon
				choices[0] = "hunter"
				itens[1] = monkIcon
				choices[1] = "engineer"
				set_choice_labels("Controls an eagle with 'E'.", "Hunter", "create a shield with 'E'.", "Engineer",slot)
			elif stage.skills_p1[9] == "wizard":
				itens[0] = healerIcon
				choices[0] = "researcher"
				itens[1] = druidIcon
				choices[1] = "brewerist"
				set_choice_labels("Copies an enemy's lv1 or lv2 skill with 'E'.", "Researcher", "Throw potions with 'E'.", "Brewerist",slot)
		elif PlayerInventory.player == "player2":
			if stage.skills_p2[9] == "warrior":
				itens[0] = archerIcon
				choices[0] = "hunter"
				itens[1] = monkIcon
				choices[1] = "engineer"
				set_choice_labels("Controls an eagle with 'E'.", "Hunter", "create a shield with 'E'.", "Engineer",slot)
			elif stage.skills_p2[9] == "wizard":
				itens[0] = healerIcon
				choices[0] = "researcher"
				itens[1] = druidIcon
				choices[1] = "brewerist"
				set_choice_labels("Copies an enemy's lv1 or lv2 skill with 'E'.", "Researcher", "Throw potions with 'E'.", "Brewerist",slot)
	elif slot.name == "Slot12":
		if PlayerInventory.player == "player1":
			if stage.skills_p1[10] == "hunter":
				itens[0] = thievIcon
				choices[0] = "animalist"
				itens[1] = gunsmithIcon
				choices[1] = "thief"
				set_choice_labels("Becomes a strong werewolf with 'R'.", "Animalist", "Small chance to steal an item from the enemy with 'R'.", "Thief",slot)
			elif stage.skills_p1[10] =="engineer":
				itens[0] = berserkerIcon
				choices[0] = "demolisher"
				itens[1] = trapperIcon
				choices[1] = "inventor"
				set_choice_labels("Plant a c4 bomb with 'R'.", "Demolisher", "Create a small robot with 'R'.", "Inventor",slot)
			elif stage.skills_p1[10] =="researcher":
				itens[0] = shapeshifterIcon
				choices[0] = "pastWizard"
				itens[1] = alchemistIcon
				choices[1] = "archaeologist"
				set_choice_labels("Teleport to a point marked in the past with 'R'.", "Past Wizard", "Summon a golem with 'R'.", "Archaeologist",slot)
			elif stage.skills_p1[10] =="brewerist":
				itens[0] = timeMageIcon
				choices[0] = "alchemist"
				itens[1] = scribeIcon
				choices[1] = "shapeshifter"
				set_choice_labels("turns blocks into others with 'R'.", "Alchemist", "Turns into an object with 'R'.", "Shapeshifter",slot)
		if PlayerInventory.player == "player2":
			if stage.skills_p2[10] == "hunter":
				itens[0] = thievIcon
				choices[0] = "animalist"
				itens[1] = gunsmithIcon
				choices[1] = "thief"
				set_choice_labels("Becomes a strong werewolf with 'R'.", "Animalist", "Small chance to steal an item from the enemy with 'R'.", "Thief",slot)
			elif stage.skills_p2[10] =="engineer":
				itens[0] = berserkerIcon
				choices[0] = "demolisher"
				itens[1] = trapperIcon
				choices[1] = "inventor"
				set_choice_labels("Plant a c4 bomb with 'R'.", "Demolisher", "Create a small robot with 'R'.", "Inventor",slot)
			elif stage.skills_p2[10] =="researcher":
				itens[0] = shapeshifterIcon
				choices[0] = "pastWizard"
				itens[1] = alchemistIcon
				choices[1] = "archaeologist"
				set_choice_labels("Teleport to a point marked in the past with 'R'.", "Past Wizard", "Summon a golem with 'R'.", "Archaeologist",slot)
			elif stage.skills_p2[10] =="brewerist":
				itens[0] = timeMageIcon
				choices[0] = "alchemist"
				itens[1] = scribeIcon
				choices[1] = "shapeshifter"
				set_choice_labels("turns blocks into others with 'R'.", "Alchemist", "Turns into an object with 'R'.", "Shapeshifter",slot)

func set_choice_labels(labelText1, labelValue1, labelText2, labelValue2,slot):
	var item = sprite.instance()
	item.texture = itens[0]
	$Skills/Slots/Choice1.putIntoSlot(item)
	$Skills/Labels/Label.text = labelText1
	$Skills/Labels/Label3.text = labelValue1

	item = sprite.instance()
	item.texture = itens[1]
	$Skills/Slots/Choice2.putIntoSlot(item)
	$Skills/Labels/Label2.text = labelText2
	$Skills/Labels/Label4.text = labelValue2

	$Labels.visible = false
	$Slots.visible = false
	$Skills.visible = true
	lastSlot = slot
