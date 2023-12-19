extends KinematicBody2D

const ACCELERATION = 800
const MAX_SPEED = 550
var velocity = Vector2.ZERO
var item_name = ""
var player = null
var being_picked_up = false
var dirt = preload("res://Images/Dirt.png")
var logs = preload("res://Images/Log.png")
var birchlogs = preload("res://Images/Birch Log.png")
var plumlogs = preload("res://Images/Plum Log.png")
var eucalyptuslogs = preload("res://Images/Eucalyptus Log.png")
var brazierlogs = preload("res://Images/Brazier Log.png")
var stone = preload("res://Images/Stone.png")
var copper = preload("res://Images/Copper Stone.png")
var iron = preload("res://Images/Iron Stone.png")
var mythril = preload("res://Images/Mythril Stone.png")
var adamant = preload("res://Images/Adamant Stone.png")
var dragonite = preload("res://Images/Dragonite Stone.png")
var carrot = preload("res://Images/Carrot.png")
var onion = preload("res://Images/Onion.png")
var beet = preload("res://Images/Beet.png")
var lettuce = preload("res://Images/Lettuce.png")
var pepper= preload("res://Images/Pepper.png")
var sap = preload("res://Images/Sap.png")
var woodWall = preload("res://Images/Wood Wall.png")
var birchWall = preload("res://Images/Birch Wall.png")
var plumWall = preload("res://Images/Plum Wall.png")
var eucalyptusWall = preload("res://Images/Eucalyptus Wall.png")
var brazierWall = preload("res://Images/Brazier Wall.png")
var vase = preload("res://Images/Vase.png")
var beetseed = preload("res://Images/Beet seed.png")
var birchseed = preload ("res://Images/Birch seed.png")
var brazierseed = preload("res://Images/Brazier seed.png")
var carrotseed = preload("res://Images/Carrot seed.png")
var eucalyptusseed = preload("res://Images/Eucalyptus seed.png")
var lettucesseed = preload("res://Images/Lettuce seed.png")
var onionseed = preload("res://Images/Onion seed.png")
var pepperseed = preload("res://Images/Pepper seed.png")
var plumseed = preload("res://Images/Plum seed.png")
var woodseed = preload("res://Images/Wood seed.png")
var orangefiber = preload("res://Images/Orange Fiber.png")
var grayfiber = preload("res://Images/Gray Fiber.png")
var bluefiber = preload("res://Images/Blue Fiber.png")
var greenfiber = preload("res://Images/Green Fiber.png")
var redfiber = preload("res://Images/Red Fiber.png")
var furnace = preload("res://Images/Furnace.png")
var table = preload("res://Images/Table.png")
var chest = preload("res://Images/Chest.png")
var sand= preload("res://Images/Sand.png")

func _ready():
	var stage = get_tree().get_current_scene().get_node("/root/stage")
	stage.itens.append(self)
	update()

func _physics_process(delta):
	if being_picked_up == false:
		pass
	else:
		var direction = global_position.direction_to(player.global_position)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		var distance = global_position.distance_to(player.global_position)
		if distance < 4:
			PlayerInventory.add_item(item_name, 1)
			player.pickup(self)
	velocity = move_and_slide(velocity, Vector2.UP)

func space():
	for slot in PlayerInventory.slots2:
		if slot.item==null:
			return true
	return false

func pick_up_item(body):
	if space():
		player = body
		being_picked_up = true
	
func update():
	if item_name=="Dirt":
		$Sprite.texture=dirt
	elif item_name=="Log":
		$Sprite.texture=logs
	elif item_name=="Birch Log":
		$Sprite.texture=birchlogs
	elif item_name=="Plum Log":
		$Sprite.texture=plumlogs
	elif item_name=="Eucalyptus Log":
		$Sprite.texture=eucalyptuslogs
	elif item_name=="Brazier Log":
		$Sprite.texture=brazierlogs
	elif item_name=="Stone":
		$Sprite.texture=stone
	elif item_name=="Copper Stone":
		$Sprite.texture=copper
	elif item_name=="Iron Stone":
		$Sprite.texture=iron
	elif item_name=="Mythril Stone":
		$Sprite.texture=mythril
	elif item_name=="Adamant Stone":
		$Sprite.texture=adamant
	elif item_name=="Dragonite Stone":
		$Sprite.texture=dragonite
	elif item_name=="Carrot":
		$Sprite.texture=carrot
	elif item_name=="Onion":
		$Sprite.texture=onion
	elif item_name=="Beet":
		$Sprite.texture=beet
	elif item_name=="Lettuce":
		$Sprite.texture=lettuce
	elif item_name=="Pepper":
		$Sprite.texture=pepper
	elif item_name=="Sap":
		$Sprite.texture=sap
	elif item_name=="Wood Wall":
		$Sprite.texture=woodWall
	elif item_name=="Birch Wall":
		$Sprite.texture=birchWall
	elif item_name=="Plum Wall":
		$Sprite.texture=plumWall
	elif item_name=="Eucalyptus Wall":
		$Sprite.texture=eucalyptusWall
	elif item_name=="Brazier Wall":
		$Sprite.texture=brazierWall
	elif item_name=="Vase":
		$Sprite.texture=vase
	elif item_name=="Beet Seed":
		$Sprite.texture=beetseed
	elif item_name=="Birch Seed":
		$Sprite.texture=birchseed
	elif item_name=="Brazier Seed":
		$Sprite.texture=brazierseed
	elif item_name=="Carrot Seed":
		$Sprite.texture=carrotseed
	elif item_name=="Eucalyptus Seed":
		$Sprite.texture=eucalyptusseed
	elif item_name=="Lettuce Seed":
		$Sprite.texture=lettucesseed
	elif item_name=="Onion Seed":
		$Sprite.texture=onionseed
	elif item_name=="Pepper Seed":
		$Sprite.texture=pepperseed
	elif item_name=="Plum Seed":
		$Sprite.texture=plumseed
	elif item_name=="Wood Seed":
		$Sprite.texture=woodseed
	elif item_name=="Orange Fiber":
		$Sprite.texture=orangefiber
	elif item_name=="Gray Fiber":
		$Sprite.texture=grayfiber
	elif item_name=="Blue Fiber":
		$Sprite.texture=bluefiber
	elif item_name=="Green Fiber":
		$Sprite.texture=greenfiber
	elif item_name=="Red Fiber":
		$Sprite.texture=redfiber
	elif item_name=="Table":
		$Sprite.texture=table
	elif item_name=="Furnace":
		$Sprite.texture=furnace
	elif item_name=="Chest":
		$Sprite.texture=chest
	elif item_name=="Sand":
		$Sprite.texture=sand
	

