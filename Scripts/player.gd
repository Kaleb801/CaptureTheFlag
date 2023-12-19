extends KinematicBody2D

onready var Item = preload("res://Scenes/ItemDrop.tscn")
onready var Wood = preload("res://Scenes/Tree.tscn")
onready var Birch = preload("res://Scenes/Birch.tscn")
onready var Plum = preload("res://Scenes/Plum.tscn")
onready var Eucalyptus = preload("res://Scenes/Eucalyptus.tscn")
onready var Brazier = preload("res://Scenes/Brazier.tscn")
onready var Carrot = preload("res://Scenes/Carrot.tscn")
onready var Onion = preload("res://Scenes/Onion.tscn")
onready var Beet = preload("res://Scenes/Beet.tscn")
onready var Lettuce = preload("res://Scenes/Lettuce.tscn")
onready var Pepper = preload("res://Scenes/Pepper.tscn")
onready var Bird = preload("res://Scenes/Bird.tscn")
onready var normalWalk = preload("res://Images/Walkanim.png")
onready var werewolfWalk = preload("res://Images/wolfWalk.png")
onready var shield = preload("res://Scenes/Shield.tscn")

var openchest =null
var musicChange = false
var inventory
var thiefbody = null
var c4
var teleportPoint
var teleport = false
var shape=false
var zone=false
var dash = false
var summon
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 25.0
const MIN_ONAIR_TIME = 0.1
var WALK_SPEED = 160 # pixels/sec
var JUMP_SPEED = 340
const SIDING_CHANGE_SPEED = 10
const BULLET_VELOCITY = 1000
const SHOOT_TIME_SHOW_WEAPON = 0.2
const CAMERA_MOVE_DISTANCE = 16
const CLIMB_SPEED = 150

var bomb = false
var bird =false
var jump = false
var climb = false
var GRAVITY_VEC = Vector2(0, 900)
var flag = false
var stage
var new_anim
var player
var linear_vel = Vector2()
var onair_time = 0 #
var on_floor = false
var shoot_time=99999 #time since last shot
var motion = 0
var anim=""
var dir = "left"
var connect_anim = "null"
var camera
var tilemap
var tilemap2
var ui_node
var newpos
var pos
var skills
var original_opacity = 1.0

var criticalPot = 0
var attackPot = 0
var defensePot = 0
var hpregenPot=0
var energyregenPot=0
var speedPot=0


#cache the sprite here for fast access (we will set scale to flip it often)
onready var sprite = $sprite
#This updates the position on the other end, along with linear velocity for animation calculations.

func blink():
	self.modulate = Color(1, 1, 1, 0)  # Define a transparência para metade (pode ajustar conforme desejado)
	yield(get_tree().create_timer(0.1), "timeout")  # Aguarda o tempo de piscar
	self.modulate = Color(1, 1, 1, original_opacity)  # Restaura a opacidade original
	yield(get_tree().create_timer(0.1), "timeout")  # Aguarda o tempo de piscar
	self.modulate = Color(1, 1, 1, 0)  # Define a transparência para metade (pode ajustar conforme desejado)
	yield(get_tree().create_timer(0.1), "timeout")  # Aguarda o tempo de piscar
	self.modulate = Color(1, 1, 1, original_opacity)  # Restaura a opacidade original

func light(num,player):
	if PlayerInventory.player==player:
		$Torch.visible=num
		rpc("light_change",num)
	
slave func light_change(num):
	if num==true:
		$Torch.visible=true
	else:
		$Torch.visible=false

slave func steal(player,rand):
	if player=="player1":
		stage.get_node("player2").thief(rand)
	else:
		stage.get_node("player1").thief(rand)

slave func explosion():
	$Animations/Explosion.visible=true
	$Animations/Explosion.play("default")

slave func set_pos_and_motion(p_pos,p_motion,_anim,timer,wait,direction):
	dir=direction
	position=p_pos
	linear_vel=p_motion
	new_anim=_anim
	if timer==false:
		$Weapon_timer.wait_time=wait
		$Weapon_timer.start()
	else:
		$Weapon_timer.stop()

#This function shoots bullets from the player on its own screen and on the other player's screen.
func _ready():
	$SpRegen.start()
	$HpRegen.start()
	inventory=PlayerInventory.slots
	ui_node = get_tree().get_current_scene().get_node("/root/stage/UserInterface")
	tilemap = get_tree().get_current_scene().get_node("/root/stage/tile_map")
	tilemap2 = get_tree().get_current_scene().get_node("/root/stage/tile_map_collect")
	stage= get_tree().get_current_scene().get_node("/root/stage")
	if name=="player1":
		camera= stage.get_node("camera1")
		$Flag.play("red")
	else:
		camera= stage.get_node("camera2")
		$Flag.play("blue")
	$Axe.player=self.name
	$Pickaxe.player=self.name
	$Sword.player=self.name
	
func _physics_process(delta):
	if stage.get_node("UserInterface/End").visible==false:
		pos = tilemap.world_to_map(position)
		if pos.y<90 and musicChange==false:
			musicChange=true
			stage.music(1,name)
		elif pos.y>=90 and musicChange==true:
			musicChange=false
			stage.music(2,name)
		stage.get_node("UserInterface/Hotbar").update_active_item_label()
		pos = tilemap.world_to_map(get_global_mouse_position())
		if pos!=newpos and PlayerInventory.slots[PlayerInventory.active_item_slot].item!=null:
			pos=newpos
			if PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Table":
				stage.get_node("item").clear()
				stage.get_node("item").set_cellv(stage.get_node("item").world_to_map(get_global_mouse_position()),0)
			elif PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Anvil":
				stage.get_node("item").clear()
				stage.get_node("item").set_cellv(stage.get_node("item").world_to_map(get_global_mouse_position()),5)
			elif PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Furnace":
				stage.get_node("item").clear()
				stage.get_node("item").set_cellv(stage.get_node("item").world_to_map(get_global_mouse_position()),1)
			elif PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Vase":
				stage.get_node("item").clear()
				stage.get_node("item").set_cellv(stage.get_node("item").world_to_map(get_global_mouse_position()),2)
			elif PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Chest":
				stage.get_node("item").clear()
				stage.get_node("item").set_cellv(stage.get_node("item").world_to_map(get_global_mouse_position()),4)
			elif PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Wood Door":
				stage.get_node("item").clear()
				stage.get_node("item").set_cellv(stage.get_node("item").world_to_map(get_global_mouse_position()),6)
			elif PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Birch Door":
				stage.get_node("item").clear()
				stage.get_node("item").set_cellv(stage.get_node("item").world_to_map(get_global_mouse_position()),7)
			elif PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Plum Door":
				stage.get_node("item").clear()
				stage.get_node("item").set_cellv(stage.get_node("item").world_to_map(get_global_mouse_position()),8)
			elif PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Eucalyptus Door":
				stage.get_node("item").clear()
				stage.get_node("item").set_cellv(stage.get_node("item").world_to_map(get_global_mouse_position()),9)
			elif PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Brazier Door":
				stage.get_node("item").clear()
				stage.get_node("item").set_cellv(stage.get_node("item").world_to_map(get_global_mouse_position()),10)
			elif "Seed" in PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name:
				stage.get_node("item").clear()
				stage.get_node("item").set_cellv(stage.get_node("item").world_to_map(get_global_mouse_position()),3)
			elif shape==false:
				stage.get_node("item").clear()
		if bird==false:
			if linear_vel.x != 0 or linear_vel.y != 0:
				camera.get_node("Tween").interpolate_property(camera, "position", camera.position, tilemap.map_to_world(tilemap.world_to_map(position)), 0.3, 0.1, Tween.TRANS_LINEAR, 0)
				camera.get_node("Tween").start()
				if openchest!=null:
					openchest.visible=false
					openchest=null
		else:
			camera.get_node("Tween").interpolate_property(camera, "position", camera.position, tilemap.map_to_world(tilemap.world_to_map(stage.get_node(summon.name).position)), 0.3, 0.1, Tween.TRANS_LINEAR, 0)
			camera.get_node("Tween").start()

		onair_time += delta

		### MOVEMENT ###

		# Apply Gravity
		linear_vel += delta * GRAVITY_VEC
		var vel
		if PlayerInventory.player=="player1":
			vel=stage.speed1
		else:
			vel=stage.speed2
		# Move and Slide
		linear_vel = move_and_slide(linear_vel*((Vector2(1,1)+Vector2(vel,vel)/100)), FLOOR_NORMAL, SLOPE_SLIDE_STOP)

		# Detect Floor
		if is_on_floor():
			jump=false
			onair_time = 0

		var on_floor = onair_time < MIN_ONAIR_TIME

		### CONTROL ###
		if is_network_master():
			# Horizontal Movement
			var target_speed = 0
			pos = tilemap.world_to_map(position)
			if dir == "right" and tilemap.get_cellv(Vector2(pos.x+1,pos.y-1))==16 and tilemap.openDoor(Vector2(pos.x+1,pos.y-1),name):
				tilemap.set_cellv(Vector2(pos.x+1,pos.y-1),17)
			elif dir == "left" and tilemap.get_cellv(Vector2(pos.x-1,pos.y-1))==16 and tilemap.openDoor(Vector2(pos.x-1,pos.y-1),name):
				tilemap.set_cellv(Vector2(pos.x-1,pos.y-1),17)
			elif dir == "right" and tilemap.get_cellv(Vector2(pos.x+1,pos.y-1))==20 and tilemap.openDoor(Vector2(pos.x+1,pos.y-1),name):
				tilemap.set_cellv(Vector2(pos.x+1,pos.y-1),21)
			elif dir == "left" and tilemap.get_cellv(Vector2(pos.x-1,pos.y-1))==20 and tilemap.openDoor(Vector2(pos.x-1,pos.y-1),name):
				tilemap.set_cellv(Vector2(pos.x-1,pos.y-1),21)
			elif dir == "right" and tilemap.get_cellv(Vector2(pos.x+1,pos.y-1))==22 and tilemap.openDoor(Vector2(pos.x+1,pos.y-1),name):
				tilemap.set_cellv(Vector2(pos.x+1,pos.y-1),23)
			elif dir == "left" and tilemap.get_cellv(Vector2(pos.x-1,pos.y-1))==22 and tilemap.openDoor(Vector2(pos.x-1,pos.y-1),name):
				tilemap.set_cellv(Vector2(pos.x-1,pos.y-1),23)
			elif dir == "right" and tilemap.get_cellv(Vector2(pos.x+1,pos.y-1))==24 and tilemap.openDoor(Vector2(pos.x+1,pos.y-1),name):
				tilemap.set_cellv(Vector2(pos.x+1,pos.y-1),25)
			elif dir == "left" and tilemap.get_cellv(Vector2(pos.x-1,pos.y-1))==24 and tilemap.openDoor(Vector2(pos.x-1,pos.y-1),name):
				tilemap.set_cellv(Vector2(pos.x-1,pos.y-1),25)
			elif dir == "right" and tilemap.get_cellv(Vector2(pos.x+1,pos.y-1))==26 and tilemap.openDoor(Vector2(pos.x+1,pos.y-1),name):
				tilemap.set_cellv(Vector2(pos.x+1,pos.y-1),27)
			elif dir == "left" and tilemap.get_cellv(Vector2(pos.x-1,pos.y-1))==26 and tilemap.openDoor(Vector2(pos.x-1,pos.y-1),name):
				tilemap.set_cellv(Vector2(pos.x-1,pos.y-1),27)
			
			if dir == "right" and tilemap.get_cellv(Vector2(pos.x-1,pos.y-1))==17:
				tilemap.set_cellv(Vector2(pos.x-1,pos.y-1),16)
			elif dir == "left" and tilemap.get_cellv(Vector2(pos.x+1,pos.y-1))==17:
				tilemap.set_cellv(Vector2(pos.x+1,pos.y-1),16)
			elif dir == "right" and tilemap.get_cellv(Vector2(pos.x-1,pos.y-1))==21:
				tilemap.set_cellv(Vector2(pos.x-1,pos.y-1),20)
			elif dir == "left" and tilemap.get_cellv(Vector2(pos.x+1,pos.y-1))==21:
				tilemap.set_cellv(Vector2(pos.x+1,pos.y-1),20)
			elif dir == "right" and tilemap.get_cellv(Vector2(pos.x-1,pos.y-1))==23:
				tilemap.set_cellv(Vector2(pos.x-1,pos.y-1),22)
			elif dir == "left" and tilemap.get_cellv(Vector2(pos.x+1,pos.y-1))==23:
				tilemap.set_cellv(Vector2(pos.x+1,pos.y-1),22)
			elif dir == "left" and tilemap.get_cellv(Vector2(pos.x+1,pos.y-1))==27:
				tilemap.set_cellv(Vector2(pos.x+1,pos.y-1),26)
			elif dir == "left" and tilemap.get_cellv(Vector2(pos.x+1,pos.y-1))==27:
				tilemap.set_cellv(Vector2(pos.x+1,pos.y-1),26)
			
				
			if bird==false:
				if tilemap.get_cellv(Vector2(pos.x, pos.y + 2))== 33 and jump==false:
					GRAVITY_VEC=Vector2.ZERO
				else:
					climb = false
					GRAVITY_VEC=Vector2(0, 900)
				if tilemap.get_cellv(pos) == 33 or tilemap.get_cellv(Vector2(pos.x, pos.y + 1)) == 33 :
					if Input.is_action_pressed("ui_up"):
						new_anim="player_climb"
						climb = true
						GRAVITY_VEC=Vector2.ZERO
						position.y-=1
					elif Input.is_action_pressed("ui_down"):
						new_anim="player_climb"
						climb = true
						GRAVITY_VEC=Vector2.ZERO
						position.y+=1
					else:
						new_anim="player_idle_climb"
			
			var input=Vector2.ZERO
			if Input.is_action_pressed("ui_left") and !stage.get_node("UserInterface/Inventory").visible==true:
				input.x=-1
				dir="left"
				target_speed = -WALK_SPEED
			if Input.is_action_pressed("ui_right") and !stage.get_node("UserInterface/Inventory").visible==true:
				input.x=+1
				dir="right"
				target_speed = WALK_SPEED
			if Input.is_action_pressed("ui_up"):
				input.y=-1
			if Input.is_action_pressed("ui_down"):
				input.y=1
			if bird==false and dash==false:
				linear_vel.x = target_speed
			elif bird==true:
				stage.rpc("move_summon",summon.name,input)
			
			if bird==false:
				if Input.is_action_pressed("q") and $Cooldownq.is_stopped():
					if name=="player1":
						skills=stage.skills_p1
					else:
						skills=stage.skills_p2
					if skills[9]=="warrior":
						$Weapon/CollisionShape2D.disabled=false
						dash=true
						if dir =="left":
							linear_vel.x=-520
						else:
							linear_vel.x=520
						$Cooldownq.wait_time=15
						$Cooldownq.start()
						$Habilityq.wait_time=0.3
						$Habilityq.start()
					elif skills[9]=="wizard":
						stage.rpc("create_tornado",name,get_global_mouse_position())
						$Cooldownq.wait_time=15
						$Cooldownq.start()
						$Habilityq.wait_time=5
						$Habilityq.start()
				
				if Input.is_action_pressed("e") and $Cooldownq.is_stopped():
					if name=="player1":
						skills=stage.skills_p1
					else:
						skills=stage.skills_p2
					if skills[10]=="hunter":
						stage.rpc("update_stage_summon","bird",name,position)
						$Cooldowne.wait_time=60
						$Cooldowne.start()
						$Habilitye.wait_time=15
						$Habilitye.start()
					if skills[10]=="engineer":
						var item = shield.instance()
						stage.add_child(item)
						item.position = position
						$Cooldowne.wait_time=60
						$Cooldowne.start()
						$Habilitye.wait_time=15
						$Habilitye.start()
					if skills[10]=="healer":
						stage.rpc("create_healing",name,pos)
						$Cooldowne.wait_time=60
						$Cooldowne.start()
						$Habilitye.wait_time=15
						$Habilitye.start()
				
				if Input.is_action_pressed("r") and $Cooldownr.is_stopped():
					if name=="player1":
						skills=stage.skills_p1
					else:
						skills=stage.skills_p2
					if skills[11]=="animalist":
						$Cooldownr.wait_time=60
						$Cooldownr.start()
						$Habilityr.wait_time=30
						$Habilityr.start()
						$Animations/WalkBase.texture=werewolfWalk
					if skills[11]=="thief" and thiefbody!=null:
						randomize()
						var rand = randi() % 7
						if name=="player1":
							receive(stage.get_node("player2").inventory[rand])
						else:
							receive(stage.get_node("player1").inventory[rand])
						rpc("steal",name,rand)
						$Cooldownr.wait_time=60
						$Cooldownr.start()
						$Habilityr.wait_time=30
						$Habilityr.start()
					if skills[11]=="demolisher":
						if bomb==false:
							bomb=true
							stage.rpc("create_c4",name,pos)
							$Cooldownr.wait_time=3
							$Cooldownr.start()
						elif bomb==true:
							bomb=false
							stage.rpc("explosion_c4",c4)
							$Cooldownr.wait_time=60
							$Cooldownr.start()
							$Habilityr.wait_time=30
							$Habilityr.start()
					if skills[11]=="inventor":
						stage.rpc("create_drone",name,position)
						$Cooldownr.wait_time=60
						$Cooldownr.start()
						$Habilityr.wait_time=30
						$Habilityr.start()
					if skills[11]=="shapeshifter":
						if tilemap.get_cellv(tilemap.world_to_map(get_global_mouse_position()))==9:
							$Animations/WalkBase.visible=false
							stage.get_node("item").set_cellv(tilemap.world_to_map(Vector2(position.x-1,position.y-6)),1)
						$Cooldownr.wait_time=60
						$Cooldownr.start()
						$Habilityr.wait_time=30
						$Habilityr.start()
						$Animations/WalkBase.texture=werewolfWalk
						shape=true
					if skills[11]=="pastWizard":
						if teleport==false:
							teleport=true
							stage.rpc("create_portal",name,pos)
							$Cooldownr.wait_time=3
							$Cooldownr.start()
						elif teleport==true:
							teleport=false
							position=stage.get_node(teleportPoint).position
							$Cooldownr.wait_time=60
							$Cooldownr.start()
							$Habilityr.wait_time=30
							$Habilityr.start()
							stage.get_node(teleportPoint).queue_free()
						
				if Input.is_action_pressed("scroll_down") or Input.is_action_pressed("scroll_up") and get_tree().get_current_scene().get_node("/root/stage/UserInterface/Inventory").visible==true:
					get_tree().get_current_scene().get_node("/root/stage/serInterface/Craft").scroll()
				
				if on_floor and Input.is_action_just_pressed("jump") and stage.get_node("UserInterface/Inventory").visible==false:
					$sound_jump.play()
					jump=true
					linear_vel.y = -JUMP_SPEED
					
				if $PickupZone.items_in_range.size() > 0:
					var pickup_item = $PickupZone.items_in_range.values()[0]
					pickup_item.pick_up_item(self)
					$PickupZone.items_in_range.erase(pickup_item)
				
				if Input.is_action_pressed("ui_accept") and $Weapon_timer.is_stopped() and get_tree().get_current_scene().get_node("/root/stage/UserInterface").holding_item == null and zone==false and stage.get_node("UserInterface/Inventory").visible==false:
					pos = tilemap.world_to_map(get_global_mouse_position())
					var valid = PlayerInventory.active_item_slot in PlayerInventory.hotbar
					if valid:
						var item_name = PlayerInventory.hotbar[PlayerInventory.active_item_slot][0]
						var dir = "left" if position.x - get_global_mouse_position().x >= 0 else "right"
						if item_name.find("Attack Potion") != -1:
							if $PotsTimer/Attack.is_stopped():
								stage.rpc("set_sword",4,name)
							else:
								$PotsTimer/Attack.start()
							PlayerInventory.add_item_quantity(PlayerInventory.slots[PlayerInventory.active_item_slot], -1)
						if item_name.find("Critical Attack Potion") != -1:
							if $PotsTimer/Critical.is_stopped():
								stage.rpc("set_critical",1,name)
							else:
								$PotsTimer/Critical.start()
							PlayerInventory.add_item_quantity(PlayerInventory.slots[PlayerInventory.active_item_slot], -1)
						if item_name.find("Defense Potion") != -1:
							if $PotsTimer/Defense.is_stopped():
								stage.rpc("set_shield",4,name)
							else:
								$PotsTimer/Defense.start()
							PlayerInventory.add_item_quantity(PlayerInventory.slots[PlayerInventory.active_item_slot], -1)
						if item_name.find("Energy Potion") != -1:
							if $PotsTimer/SP.is_stopped():
								stage.rpc("set_star",1,name)
								$PotsTimer/SP.start()
								PlayerInventory.add_item_quantity(PlayerInventory.slots[PlayerInventory.active_item_slot], -1)
						if item_name.find("Energy Regen Potion Potion") != -1:
							if $PotsTimer/SpRegenPot.is_stopped():
								stage.rpc("set_spregen",1,name)
							else:
								$PotsTimer/SpRegenPot.start()
							PlayerInventory.add_item_quantity(PlayerInventory.slots[PlayerInventory.active_item_slot], -1)
						if item_name.find("Healing Potion") != -1:
							if $PotsTimer/hp.is_stopped():
								stage.rpc("set_health",1,name)
								$PotsTimer/hp.start()
								PlayerInventory.add_item_quantity(PlayerInventory.slots[PlayerInventory.active_item_slot], -1)
						if item_name.find("health Regen Potion") != -1:
							if $PotsTimer/HpRegenPot.is_stopped():
								stage.rpc("set_hpregen",1,name)
							else:
								$PotsTimer/HpRegenPot.start()
							PlayerInventory.add_item_quantity(PlayerInventory.slots[PlayerInventory.active_item_slot], -1)
						if item_name.find("Velocity Potion") != -1:
							if $PotsTimer/Speed.is_stopped():
								stage.rpc("set_speed",1,name)
							else:
								$PotsTimer/Speed.start()
							PlayerInventory.add_item_quantity(PlayerInventory.slots[PlayerInventory.active_item_slot], -1)
						if item_name.find("Strong Energy Potion") != -1:
							if $PotsTimer/hp.is_stopped():
								stage.rpc("set_star",2,name)
								$PotsTimer/hp.start()
								PlayerInventory.add_item_quantity(PlayerInventory.slots[PlayerInventory.active_item_slot], -1)
						if item_name.find("Strong Healing Potion") != -1:
							if $PotsTimer/hp.is_stopped():
								stage.rpc("set_health",2,name)
								$PotsTimer/hp.start()
								PlayerInventory.add_item_quantity(PlayerInventory.slots[PlayerInventory.active_item_slot], -1)
						if item_name.find("pickaxe") != -1:
							randomize()
							var crit = 1
							var critical
							var attack
							if name=="player1":
								critical=stage.critical1
								attack=stage.sword1
							else:
								critical=stage.critical2
								attack=stage.sword2
							var rand = randi() % (10 - critical) + critical
							if rand == 0:
								crit=1.5
							$Pickaxe.damage=attack*crit
							$swing.play()
							_handle_pickaxe(dir, pos, tilemap)
						elif item_name.find("axe") != -1:
							randomize()
							var crit = 1
							var critical
							var attack
							if name=="player1":
								critical=stage.critical1
								attack=stage.sword1
							else:
								critical=stage.critical2
								attack=stage.sword2
							var rand = randi() % (10 - critical) + critical
							if rand == 0:
								crit=1.5
							$Axe.damage=attack*crit
							$swing.play()
							_handle_axe(dir)
						elif item_name.find("Ruby Staff") != -1:
							stage.rpc("create_firebal",name,get_global_mouse_position())
							$Weapon_timer.wait_time = 0.6
							$Weapon_timer.start()
							if dir =="left":
								$Animations/Player.play("player_cast_left")
							else:
								$Animations/Player.play("player_cast_right")
						elif item_name.find("Emerald Staff") != -1:
							stage.rpc("create_firebal",name,get_global_mouse_position())
							$Weapon_timer.wait_time = 0.6
							$Weapon_timer.start()
							if dir =="left":
								$Animations/Player.play("player_cast_left")
							else:
								$Animations/Player.play("player_cast_right")
						elif item_name.find("Sapphire Staff") != -1:
							stage.rpc("create_firebal",name,get_global_mouse_position())
							$Weapon_timer.wait_time = 0.6
							$Weapon_timer.start()
							if dir =="left":
								$Animations/Player.play("player_cast_left")
							else:
								$Animations/Player.play("player_cast_right")
						elif item_name.find("Opal Staff") != -1:
							stage.rpc("create_firebal",name,get_global_mouse_position())
							$Weapon_timer.wait_time = 0.6
							$Weapon_timer.start()
							if dir =="left":
								$Animations/Player.play("player_cast_left")
							else:
								$Animations/Player.play("player_cast_right")
						elif item_name.find("Garnet Staff") != -1:
							stage.rpc("create_firebal",name,get_global_mouse_position())
							$Weapon_timer.wait_time = 0.6
							$Weapon_timer.start()
							if dir =="left":
								$Animations/Player.play("player_cast_left")
							else:
								$Animations/Player.play("player_cast_right")
						elif item_name.find("Sword") != -1:
							var star =0
							if name=="player1":
								star = stage.star_p1
							else:
								star = stage.star_p2
							if star>=1:
								randomize()
								var crit = 1
								var critical
								var attack
								if name=="player1":
									critical=stage.critical1
									attack=stage.sword1
								else:
									critical=stage.critical2
									attack=stage.sword2
								var rand = randi() % (10 - critical) + critical
								if rand == 0:
									crit=1.5
								$Sword.damage=attack*crit
								stage.rpc("set_star",-1,name)
								$swing.play()
								if dir =="right":
									$Sword/CollisionShape2D.position.x=28
								else:
									$Sword/CollisionShape2D.position.x=-28
								$Sword/CollisionShape2D.disabled = false
								$Weapon_timer.wait_time = 0.6
								$Weapon_timer.start()
								new_anim = "player_weapon_" + dir
								$Animations/Sword.visible=true
				elif Input.is_action_pressed("ui_select") :
					pos = tilemap.world_to_map(get_global_mouse_position())
					_handle_placing(PlayerInventory.hotbar, PlayerInventory.active_item_slot, pos, tilemap)
					openChest()


	### ANIMATION ###
	
	if $Weapon_timer.is_stopped() and climb == false and bird==false:
		if linear_vel.x<=10 and linear_vel.x>=-10:
			new_anim="player_idle_"+dir
		elif linear_vel.x < -SIDING_CHANGE_SPEED:
			new_anim = "player_walk_left"
			dir = "left"
		elif linear_vel.x > SIDING_CHANGE_SPEED:
			dir = "right"
			new_anim = "player_walk_right"

	if new_anim != anim:
		anim = new_anim
		$Animations/Player.play(anim)
	rpc("set_pos_and_motion",position,linear_vel,anim,$Weapon_timer.is_stopped(),$Weapon_timer.wait_time,dir)

func openChest():
	var childs = stage.get_node("UserInterface").get_children()
	for child in childs:
		if "pos" in child:
			if tilemap.get_cellv(pos)==34 and child.pos == pos:
				child.visible=true
				openchest=child
			elif tilemap.get_cellv(Vector2(pos.x-1,pos.y))==34 and child.pos == Vector2(pos.x-1,pos.y):
				child.visible=true
				openchest=child
			elif tilemap.get_cellv(Vector2(pos.x,pos.y-1))==34 and child.pos ==Vector2(pos.x,pos.y-1):
				child.visible=true
				openchest=child
			elif tilemap.get_cellv(Vector2(pos.x-1,pos.y-1))==34 and child.pos == Vector2(pos.x-1,pos.y-1):
				child.visible=true
				openchest=child

func deleteChest():
	var childs = stage.get_node("UserInterface").get_children()
	for child in childs:
		if "pos" in child:
			if tilemap.get_cellv(pos)==34 and child.pos == pos:
				child.queue_free()
			elif tilemap.get_cellv(Vector2(pos.x-1,pos.y))==34 and child.pos == Vector2(pos.x-1,pos.y):
				child.queue_free()
			elif tilemap.get_cellv(Vector2(pos.x,pos.y-1))==34 and child.pos ==Vector2(pos.x,pos.y-1):
				child.queue_free()
			elif tilemap.get_cellv(Vector2(pos.x-1,pos.y-1))==34 and child.pos == Vector2(pos.x-1,pos.y-1):
				child.queue_free()


func _handle_pickaxe(dir, pos, tilemap):
	$Pickaxe/CollisionShape2D.disabled = false
	if dir =="right":
		$Pickaxe/CollisionShape2D.position.x=28
	else:
		$Pickaxe/CollisionShape2D.position.x=-28
	$Weapon_timer.wait_time = 0.6
	$Weapon_timer.start()
	new_anim = "player_weapon_" + dir
	$Animations/ToolBase.visible=true
	var area = get_area()
	var force = 0
	for local in area:
		if local == pos:
			if PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Copper pickaxe":
				force=0.5
			if PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Iron pickaxe":
				force=1
			if PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Mythril pickaxe":
				force=1.5
			if PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Adamant pickaxe":
				force=2
			if PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Dragonite pickaxe":
				force=2.5
			deleteChest()
			tilemap.set_cell_hp(force,pos,name)
			tilemap.delete_furniture(pos)

func _handle_axe(dir):
	if dir =="right":
		$Axe/CollisionShape2D.position.x=28
	else:
		$Axe/CollisionShape2D.position.x=-28
	if PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Copper Axe":
		$Axe.damage=0.5
	if PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Iron Axe":
		$Axe.damage=0.5
	if PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Mythril Axe":
		$Axe.damage=0.5
	if PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Adamant Axe":
		$Axe.damage=0.5
	if PlayerInventory.slots[PlayerInventory.active_item_slot].item.item_name=="Dragonite Axe":
		$Axe.damage=0.5
	$Axe/CollisionShape2D.disabled = false
	$Weapon_timer.wait_time = 0.6
	$Weapon_timer.start()
	new_anim = "player_weapon_" + dir
	$Animations/ToolBase.visible=true

func _handle_placing(hotbar, active_item_slot, pos, tilemap):
	var valid = active_item_slot in hotbar
	if valid:
		var area = get_area()
		var item_name = hotbar[active_item_slot][0]
		for local in area:
			if local == pos and tilemap.get_cellv(pos) == -1:
				if item_name == "Ladder":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_ladder", pos)
				if item_name == "Dirt":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_dirt", pos)
				elif item_name == "Wood Wall":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_wood_wall", pos)
				elif item_name == "Birch Wall":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_birch_wall", pos)
				elif item_name == "Plum Wall":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_plum_wall", pos)
				elif item_name == "Eucalyptus Wall":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_eucalyptus_wall", pos)
				elif item_name == "Brazier Wall":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_brazier_wall", pos)
				elif item_name == "Stone":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_stone", pos)
				elif item_name == "Sand":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_sand", pos)
				elif item_name == "Torch":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_torch", pos)
				elif item_name == "Table":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.get_node("item").clear()
					stage.rpc("update_stage_terrain", "put_table", pos)
				elif item_name == "Chest":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.get_node("item").clear()
					stage.rpc("update_stage_terrain", "put_chest", pos)
				elif item_name == "Furnace":
					tilemap.rpc("put_block",item_name,pos,name)
					stage.get_node("item").clear()
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_furnace", pos)
				elif item_name == "Anvil":
					tilemap.rpc("put_block",item_name,pos,name)
					stage.get_node("item").clear()
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_anvil", pos)
				elif item_name == "Wood Door":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_wood_door", pos)
				elif item_name == "Birch Door":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_birch_door", pos)
				elif item_name == "Plum Door":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_plum_door", pos)
				elif item_name == "Eucalyptus Door":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_eucalyptus_door", pos)
				elif item_name == "Brazier Door":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_brazier_door", pos)
				elif item_name == "Vase":
					tilemap.rpc("put_block",item_name,pos,name)
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("update_stage_terrain", "put_vase", pos)
				elif item_name == "Wood Seed" and tilemap.get_cellv(pos)==-1 and tilemap.get_cellv(Vector2(pos.x-2,pos.y+2))==32:
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					var item = Wood.instance()
					stage.get_node("Props/Trees").add_child(item)
					item.pos=pos
					item.plant()
					item.position=tilemap.map_to_world(Vector2(pos.x,pos.y-1))
					tilemap.set_cellv(pos,29)
				elif item_name == "Birch Seed" and tilemap.get_cellv(pos)==-1 and tilemap.get_cellv(Vector2(pos.x-2,pos.y+2))==32:
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					var item = Birch.instance()
					stage.get_node("Props/Trees").add_child(item)
					item.pos=pos
					item.plant()
					item.position=tilemap.map_to_world(Vector2(pos.x,pos.y-1))
					tilemap.set_cellv(pos,29)
				elif item_name == "Plum Seed" and tilemap.get_cellv(pos)==-1 and tilemap.get_cellv(Vector2(pos.x-2,pos.y+2))==32:
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					var item = Plum.instance()
					item.plant()
					stage.get_node("Props/Trees").add_child(item)
					item.position=tilemap.map_to_world(Vector2(pos.x,pos.y-1))
					tilemap.set_cellv(pos,29)
				elif item_name == "Eucalyptus Seed"and tilemap.get_cellv(pos)==-1 and tilemap.get_cellv(Vector2(pos.x-2,pos.y+2))==32:
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					var item = Eucalyptus.instance()
					stage.get_node("Props/Trees").add_child(item)
					item.pos=pos
					item.plant()
					item.position=tilemap.map_to_world(Vector2(pos.x,pos.y-1))
					tilemap.set_cellv(pos,29)
				elif item_name == "Brazier Seed" and tilemap.get_cellv(pos)==-1 and tilemap.get_cellv(Vector2(pos.x-2,pos.y+2))==32:
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					var item = Brazier.instance()
					stage.get_node("Props/Trees").add_child(item)
					item.pos=pos
					item.plant()
					item.position=tilemap.map_to_world(Vector2(pos.x,pos.y-1))
					tilemap.set_cellv(pos,29)
				elif item_name == "Carrot Seed" and tilemap.get_cellv(pos)==-1 and tilemap.get_cellv(Vector2(pos.x-2,pos.y+2))==32:
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					var item = Carrot.instance()
					stage.get_node("Props/Plants").add_child(item)
					item.pos=pos
					item.plant()
					item.position=tilemap.map_to_world(Vector2(pos.x,pos.y+1))
					tilemap.set_cellv(pos,29)
				elif item_name == "Onion Seed" and tilemap.get_cellv(pos)==-1 and tilemap.get_cellv(Vector2(pos.x-2,pos.y+2))==32:
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					var item = Onion.instance()
					stage.get_node("Props/Plants").add_child(item)
					item.pos=pos
					item.plant()
					item.position=tilemap.map_to_world(Vector2(pos.x,pos.y+1))
					tilemap.set_cellv(pos,29)
				elif item_name == "Beet Seed" and tilemap.get_cellv(pos)==-1 and tilemap.get_cellv(Vector2(pos.x-2,pos.y+2))==32:
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					var item = Beet.instance()
					stage.get_node("Props/Plants").add_child(item)
					item.pos=pos
					item.plant()
					item.position=tilemap.map_to_world(Vector2(pos.x,pos.y+1))
					tilemap.set_cellv(pos,29)
				elif item_name == "Lettuce Seed" and tilemap.get_cellv(pos)==-1 and tilemap.get_cellv(Vector2(pos.x-2,pos.y+2))==32:
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					var item = Lettuce.instance()
					stage.get_node("Props/Plants").add_child(item)
					item.pos=pos
					item.plant()
					item.position=tilemap.map_to_world(Vector2(pos.x,pos.y+1))
					tilemap.set_cellv(pos,29)
				elif item_name == "Pepper Seed" and tilemap.get_cellv(pos)==-1 and tilemap.get_cellv(Vector2(pos.x-2,pos.y+2))==32:
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					var item = Pepper.instance()
					stage.get_node("Props/Plants").add_child(item)
					item.pos=pos
					item.plant()
					item.position=tilemap.map_to_world(Vector2(pos.x,pos.y+1))
					tilemap.set_cellv(pos,29)
				elif item_name=="Copper Bomb" and $Bomb.is_stopped():
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("copper_bomb",name,position)
					$Bomb.start()
				elif item_name=="Iron Bomb" and $Bomb.is_stopped():
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("iron_bomb",name,position)
					$Bomb.start()
				elif item_name=="Mythril Bomb" and $Bomb.is_stopped():
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("mythril_bomb",name,position)
					$Bomb.start()
				elif item_name=="Adamant Bomb" and $Bomb.is_stopped():
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("adamant_bomb",name,position)
					$Bomb.start()
				elif item_name=="Dragonite Bomb" and $Bomb.is_stopped():
					PlayerInventory.add_item_quantity(PlayerInventory.slots[active_item_slot], -1)
					stage.rpc("dragonite_bomb",name,position)
					$Bomb.start()

func pickup(body):
	$pick.play()
	var stage = get_tree().get_current_scene().get_node("/root/stage")
	stage.rpc("update_stage_item","delete",body.name,position)

func get_area():
	var tilemap = get_tree().get_current_scene().get_node("/root/stage/tile_map")
	var tile = 16
	var area = [
	]
	var i=-3
	var j=-3
	while i<=3:
		while j<=3:
			area.append(tilemap.world_to_map(Vector2(position.x+i*tile,position.y+j*tile)))
			j+=1
		j=-3
		i+=1

	return area
	
func _on_Hurtbox_area_entered(area):
	if area.damage!=0 and area.player!=name:
		blink()
		$Damage.play()
		$Hurtbox.start_invincibility(1)
		$Hurtbox.create_hit_effect()
		stage.rpc("set_health",area.damage*-1,name)
		if name =="player1":
			if stage.health_p1<=0:
				rpc("flags",name)
				rpc("spawn",name)
				stage.rpc("set_health",stage.max_health_p1,name)
				stage.kills2+=1
		if name =="player2":
			if stage.health_p2<=0:
				rpc("flags",name)
				rpc("spawn",name)
				stage.rpc("set_health",stage.max_health_p2,name)
				stage.kills1+=1
				
sync func spawn(player):
	if  player =="player1":
		position=Vector2(-4023,988)
	elif player =="player2":
		position=Vector2(4045,1067)
	
sync func flags(player):
	if player=="player1" and flag==true:
		flag=false
		$Flag.visible=false
	elif  player=="player2" and flag==true:
		flag=false
		$Flag.visible=false
	
func _on_Weapon_timer_timeout():
	$Axe/CollisionShape2D.disabled=true
	$Pickaxe/CollisionShape2D.disabled=true
	$Sword/CollisionShape2D.disabled=true
	$Animations/ToolBase.visible=false
	$Animations/Sword.visible=false

func _on_Habilityq_timeout():
	if name=="player1":
		skills=stage.skills_p1
	else:
		skills=stage.skills_p2
	if skills[9]=="warrior":
		dash=false

func _on_Habilitye_timeout():
	if name=="player1":
		skills=stage.skills_p1
	else:
		skills=stage.skills_p2
	if skills[10]=="hunter":
		stage.rpc("delete_summon",summon.name,name)	

func _on_Habilityr_timeout():
	if name=="player1":
		skills=stage.skills_p1
	else:
		skills=stage.skills_p2
	if skills[11]=="animalist":
		$Animations/WalkBase.texture=normalWalk
	
func _on_Explosion_animation_finished():
	$Animations/Explosion.playing=false
	$Animations/Explosion.visible=false

func _on_Weapon_body_entered(body):
	if body.name!=name and "player" in body.name and dash==true:
		$Weapon/CollisionShape2D.disabled=true
		dash=false
		$Animations/Explosion.visible=true
		$Animations/Explosion.play("default")
		rpc("explosion")

func receive(slot):
	if slot.item!=null:
		PlayerInventory.add_item(slot.item.item_name, 1)

func thief(num):
	if num in PlayerInventory.hotbar:
		PlayerInventory.add_item_quantity(PlayerInventory.slots[num], -1)

func _on_ShieldDetect_body_entered(body):
	zone=true
	
func _on_ShieldDetect_body_exited(body):
	zone=false

func _on_Thief_body_entered(body):
	if body.name!=name:
		thiefbody=body

func _on_Thief_body_exited(body):
	if body.name!=name:
		thiefbody=null

func _on_HpRegen_timeout():
	stage.rpc("set_health",1,name)
	if PlayerInventory.player=="player1":
		$HpRegen.wait_time=10-stage.hpregen1+hpregenPot
	else:
		$HpRegen.wait_time=10-stage.hpregen2+hpregenPot
	$HpRegen.start()

func _on_SpRegen_timeout():
	stage.rpc("set_star",1,name)
	if PlayerInventory.player=="player1":
		$SpRegen.wait_time=10-stage.spregen1+energyregenPot
	else:
		$SpRegen.wait_time=10-stage.spregen2+energyregenPot
	$SpRegen.start()

func _on_Attack_timeout():
	stage.rpc("set_sword",-4,name)

func _on_Defense_timeout():
	stage.rpc("set_shield",-4,name)

func _on_Speed_timeout():
	stage.rpc("set_speed",-1,name)

func _on_Critical_timeout():
	stage.rpc("set_critical",-1,name)

func _on_HpRegenPot_timeout():
	stage.rpc("set_hpregen",-1,name)

func _on_SpRegenPot_timeout():
	stage.rpc("set_spregen",-1,name)
