extends Node
var kills1 = 0
var kills2 =0
var flag1 = 0
var flag2 = 0
var rounds = 0
var sound = 0 
var battle=false
var music
var critical1=0
var critical2=0
var speed1=0
var speed2=0
var hpregen1=0
var hpregen2=0
var spregen1=0
var spregen2=0
var shield1 = 0
var shield2 = 0
var sword1 = 0
var sword2 = 0
var max_health_p1 = 5
var max_health_p2 = 5
var max_star_p1 = 5
var max_star_p2 = 5
var health_p1 = 5
var health_p2 = 5
var star_p1 = 5
var star_p2 = 5
var class_p1 = 0
var class_p2 = 0
var skills_p1 = ["","","","","","","","","","","","",""]
var skills_p2 = ["","","","","","","","","","","","",""]
var Bird = preload("res://Scenes/Bird.tscn")
onready var Fireball = preload("res://Scenes/FireBall.tscn")
onready var portal = preload("res://Scenes/Portal.tscn")
onready var healing = preload("res://Scenes/HeallingSpell.tscn")
onready var c4 = preload("res://Scenes/C4Bomb.tscn")
onready var drone = preload("res://Scenes/Drone.tscn")
onready var Tornado = preload("res://Scenes/Tornado.tscn")
onready var Chest = preload("res://Scenes/Chest.tscn")
onready var copperbomb = preload("res://Scenes/CopperBomb.tscn")
onready var ironbomb = preload("res://Scenes/IronBomb.tscn")
onready var mythrilbomb = preload("res://Scenes/MythrilBomb.tscn")
onready var adamantbomb = preload("res://Scenes/AdamantBomb.tscn")
onready var dragonitebomb = preload("res://Scenes/DragoniteBomb.tscn")
var camera
var itens = []

signal health_changed(value,player)
signal max_health_changed(value,player)
signal star_changed(value,player)
signal max_star_changed(value,player)
signal exp_changed(value,stat,player)
signal shield_changed(value,stat,player)
signal sword_changed(value,stat,player)
signal critical_changed(value,stat,player)
signal speed_changed(value,stat,player)
signal hpregen_changed(value,stat,player)
signal spregen_changed(value,stat,player)


onready var Item = preload("res://Scenes/ItemDrop.tscn")

sync func set_spregen(value,player):
	if player=="player1":
		spregen1+= value
		emit_signal("hpregen_changed",spregen1,player)
	else:
		spregen2+= value
		emit_signal("hpregen_changed",spregen2,player)

sync func set_hpregen(value,player):
	if player=="player1":
		hpregen1+= value
		emit_signal("hpregen_changed",hpregen1,player)
	else:
		hpregen2+= value
		emit_signal("hpregen_changed",hpregen2,player)

sync func set_speed(value,player):
	if player=="player1":
		speed1+= value
		emit_signal("speed_changed",speed1,player)
	else:
		speed2+= value
		emit_signal("speed_changed",speed2,player)

sync func set_critical(value,player):
	if player=="player1":
		critical1+= value
		emit_signal("critical_changed",critical1,player)
	else:
		critical2+= value
		emit_signal("critical_changed",critical2,player)

sync func update_score(action):
	if action =="start":
		$UserInterface/Score.start()

sync func explosion_c4(bomb):
	get_node(bomb).explosion()
	
sync func create_drone(player,pos):
	var item = drone.instance()
	add_child(item)
	if player=="player1":
		item.player=player
		item.position=get_node("player1").position
		item.target=get_node("player1")
	elif player=="player2":
		item.player=player
		item.position=get_node("player2").position
		item.target=get_node("player2")
	item.position=pos
	
sync func copper_bomb(player,pos):
	var item = copperbomb.instance()
	add_child(item)
	if player=="player1":
		item.position=get_node("player1").position
	elif player=="player2":
		item.position=get_node("player2").position
	print(item.position)

sync func dragonite_bomb(player,pos):
	var item = dragonitebomb.instance()
	add_child(item)
	if player=="player1":
		item.position=get_node("player1").position
	elif player=="player2":
		item.position=get_node("player2").position


sync func adamant_bomb(player,pos):
	var item = adamantbomb.instance()
	add_child(item)
	if player=="player1":
		item.position=get_node("player1").position
	elif player=="player2":
		item.position=get_node("player2").position

sync func mythril_bomb(player,pos):
	var item = mythrilbomb.instance()
	add_child(item)
	if player=="player1":
		item.position=get_node("player1").position
	elif player=="player2":
		item.position=get_node("player2").position

sync func iron_bomb(player,pos):
	var item = ironbomb.instance()
	add_child(item)
	if player=="player1":
		item.position=get_node("player1").position
	elif player=="player2":
		item.position=get_node("player2").position

sync func create_c4(player,pos):
	var item = c4.instance()
	add_child(item)
	if player=="player1":
		item.position=get_node("player1").position
		get_node("player1").c4=item.name
	elif player=="player2":
		item.position=get_node("player2").position
		get_node("player2").c4=item.name

sync func create_healing(player,pos):
	var item = healing.instance()
	add_child(item)
	if player=="player1":
		item.position=get_node("player1").position
	elif player=="player2":
		item.position=get_node("player2").position
	item.player=player

sync func create_portal(player,pos):
	var item = portal.instance()
	add_child(item)
	if player=="player1":
		item.position=get_node("player1").position
	elif player=="player2":
		item.position=get_node("player2").position
	if player=="player1":
		get_node("player1").teleportPoint=item.name
	else:
		get_node("player2").teleportPoint=item.name


sync func create_tornado(player,pos):
	var item = Tornado.instance()
	item.get_node("Hitbox").player=player
	item.destiny = pos
	randomize()
	var crit = 1
	var critical
	var attack
	if name=="player1":
		critical=critical1
		attack=sword1
	else:
		critical=critical2
		attack=sword2
	var rand = randi() % (10 - critical) + critical
	if rand == 0:
		crit=1.5
	item.get_node("Hitbox").damage=attack*crit
	add_child(item)
	if player=="player1":
		item.position=get_node("player1").position
	elif player=="player2":
		item.position=get_node("player2").position

sync func create_firebal(player,pos):
	var item = Fireball.instance()
	item.get_node("Hitbox").player=player
	item.destiny = pos
	randomize()
	var crit = 1
	var critical
	var attack
	if name=="player1":
		critical=critical1
		attack=sword1
	else:
		critical=critical2
		attack=sword2
	var rand = randi() % (10 - critical) + critical
	if rand == 0:
		crit=1.5
	item.get_node("Hitbox").damage=attack*crit
	add_child(item)
	if player=="player1":
		item.position=get_node("player1").position
	elif player=="player2":
		item.position=get_node("player2").position
	item.rotation = item.get_angle_to(pos)

sync func delete_summon(node,player):
	if player=="player1":
		get_node("player1").bird=false
	else:
		get_node("player2").bird=false
	get_node(node).queue_free()

sync func move_summon(node,velocity):
	get_node(node).move(velocity)

sync func set_exp(value,player):
	if player=="player1":
		class_p1+=value
		emit_signal("exp_changed",class_p1,player)
	if player=="player2":
		class_p2+=value
		emit_signal("exp_changed",class_p2,player)

sync func set_sword(value,player):
	if player=="player1":
		sword1+= value
		emit_signal("sword_changed",sword1,player)
	else:
		sword2+= value
		emit_signal("sword_changed",sword2,player)

sync func set_shield(value,player):
	if player=="player1":
		shield1+= value
		emit_signal("shield_changed",shield1,player)
	else:
		shield2+= value
		emit_signal("shield_changed",shield2,player)

sync func set_health(value,player):
	if player=="player1":
		if health_p1+value<=max_health_p1:
			health_p1+= value
			emit_signal("health_changed",health_p1,player)
	else:
		if health_p2+value<=max_health_p2:
			health_p2+= value
			emit_signal("health_changed",health_p2,player)

sync func set_star(value,player):
	if player=="player1":
		if star_p1+value<=max_star_p1:
			star_p1+= value
			emit_signal("star_changed",star_p1,player)
	else:
		if star_p2+value<=max_star_p2:
			star_p2+= value
			emit_signal("star_changed",star_p2,player)

sync func set_max_star(value,player):
	if player=="player1":
		max_star_p1 = value
		self.star_p1 = min(star_p1, max_star_p1)
		emit_signal("max_star_changed",max_star_p1,player)
	else:
		max_star_p2 = value
		self.star_p2 = min(star_p2, max_star_p2)
		emit_signal("max_health_changed",max_star_p2,player)

sync func set_max_health(value,player):
	if player=="player1":
		max_health_p1 = value
		self.health_p1 = min(health_p1, max_health_p1)
		emit_signal("max_health_changed",max_health_p1,player)
	else:
		max_health_p2 = value
		self.health_p2 = min(health_p2, max_health_p2)
		emit_signal("max_health_changed",max_health_p2,player)

sync func update_stage_summon(nam,player_name,pos):
	if nam == "bird":
		var item = Bird.instance()
		add_child(item)
		item.position=pos
		if player_name=="player1":
			get_node("player1").summon=item
			get_node("player1").bird=true
		else:
			get_node("player2").summon=item
			get_node("player2").bird=true
	
sync func update_stage_item(action,item_name,position):
	if action=="delete":
		for item in itens:
			if item.name==item_name:
				itens.erase(item)
				item.queue_free()
				break
	if action == "generate":
		var tilemap = $tile_map
		var item = Item.instance()
		add_child(item)
		item.position=position
		item.item_name=item_name
		item.update()

sync func timer():
	$Phase.start()

sync func update_stage_terrain(action,mouse):
	var tilemap = $tile_map
	if action=="delete_vase":
		tilemap.set_cellv(mouse,-1)
		tilemap.set_cellv(Vector2(mouse.x-1,mouse.y),-1)
		tilemap.set_cellv(Vector2(mouse.x-2,mouse.y),-1)
		tilemap.set_cellv(Vector2(mouse.x-3,mouse.y),-1)
		tilemap.set_cellv(Vector2(mouse.x-4,mouse.y),-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Vase"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_table":
		tilemap.set_cellv(mouse,-1)
		tilemap.set_cellv(Vector2(mouse.x-1,mouse.y),-1)
		tilemap.set_cellv(Vector2(mouse.x,mouse.y-1),-1)
		tilemap.set_cellv(Vector2(mouse.x-1,mouse.y-1),-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Table"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_chest":
		tilemap.set_cellv(mouse,-1)
		tilemap.set_cellv(Vector2(mouse.x-1,mouse.y),-1)
		tilemap.set_cellv(Vector2(mouse.x,mouse.y-1),-1)
		tilemap.set_cellv(Vector2(mouse.x-1,mouse.y-1),-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Chest"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_furnace":
		tilemap.set_cellv(mouse,-1)
		tilemap.set_cellv(Vector2(mouse.x-1,mouse.y),-1)
		tilemap.set_cellv(Vector2(mouse.x,mouse.y-1),-1)
		tilemap.set_cellv(Vector2(mouse.x-1,mouse.y-1),-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Furnace"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_dirt":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Dirt"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_sand":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Sand"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_stone":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Stone"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_copper":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Copper Stone"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_iron":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Iron Stone"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_mythril":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Mythril Stone"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_adamant":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Adamant Stone"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_draconite":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Dragonite Stone"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_wood_wall":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Wood Wall"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_birch_wall":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Birch Wall"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_plum_wall":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Plum Wall"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_eucalyptus_wall":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Eucalyptus Wall"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_brazier_wall":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Brazier Wall"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_wood_door":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Wood Door"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_birch_door":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Birch Door"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_plum_door":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Plum Door"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_eucalyptus_door":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Eucalyptus Door"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	if action=="delete_brazier_door":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Brazier Door"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	elif action=="put_dirt":
		tilemap.set_cellv(mouse,0)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_ladder":
		tilemap.set_cellv(mouse,33)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_torch":
		tilemap.set_cellv(mouse,18)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_vase":
		tilemap.set_cellv(mouse,32)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_chest":
		var item = Chest.instance()
		item.pos=mouse
		$UserInterface.add_child(item)
		tilemap.set_cellv(mouse,34)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_stone":
		tilemap.set_cellv(mouse,1)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_wood_wall":
		tilemap.set_cellv(mouse,2)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_birch_wall":
		tilemap.set_cellv(mouse,10)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_plum_wall":
		tilemap.set_cellv(mouse,11)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_eucalyptus_wall":
		tilemap.set_cellv(mouse,12)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_brazier_wall":
		tilemap.set_cellv(mouse,13)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_table":
		tilemap.set_cellv(mouse,30)
	elif action=="put_anvil":
		tilemap.set_cellv(mouse,35)
	elif action=="put_furnace":
		tilemap.set_cellv(mouse,31)
	elif action=="put_wood_door":
		tilemap.set_cellv(mouse,16)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_birch_door":
		tilemap.set_cellv(mouse,20)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_plum_door":
		tilemap.set_cellv(mouse,22)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_sand":
		tilemap.set_cellv(mouse,36)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_eucalyptus_door":
		tilemap.set_cellv(mouse,24)
		tilemap.update_bitmask_area(mouse)
	elif action=="put_brazier_door":
		tilemap.set_cellv(mouse,26)
		tilemap.update_bitmask_area(mouse)
	elif action=="generate_logs":
		var item = Item.instance()
		add_child(item)
		item.item_name="Logs"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	elif action=="generate_Birch Logs":
		var item = Item.instance()
		add_child(item)
		item.item_name="Logs"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	elif action=="generate_plumLogs":
		var item = Item.instance()
		add_child(item)
		item.item_name="Logs"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	elif action=="generate_eucalyptusLogs":
		var item = Item.instance()
		add_child(item)
		item.item_name="Logs"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	elif action=="generate_	brazierLogs":
		var item = Item.instance()
		add_child(item)
		item.item_name="Logs"
		item.update()
		item.position = tilemap.map_to_world(mouse)

func _ready():
	music(1,PlayerInventory.player)
	rpc("update_score","start")
	if (get_tree().is_network_server()):		
		#If in the server, get control of player 2 to the other peer.
		#This function is tree recursive by default.
		get_node("player2").set_network_master(get_tree().get_network_connected_peers()[0])
		PlayerInventory.player="player1"
		camera =$camera1
		camera._set_current(true)
	else:
		#If in the client, give control of player 2 to itself. 
		#This function is tree recursive by default.
		get_node("player2").set_network_master(get_tree().get_network_unique_id())
		PlayerInventory.player="player2"
		camera = $camera2
		camera._set_current(true)
	$UserInterface/HealthUI.heartUIEmpty.rect_size.x = max_health_p1 * 32
	$UserInterface/HealthUI.heartUIFull.rect_size.x = health_p1 * 32
	$UserInterface/HealthUI.starUIEmpty.rect_size.x = max_health_p1 * 32
	$UserInterface/HealthUI.starUIFull.rect_size.x = health_p1 * 32


func music(num,player):
	if player==PlayerInventory.player:
		sound=num
		$Tween.interpolate_property(music,"volume_db", 0, -80, 1.00, 1, Tween.EASE_IN, 0)
		$Tween.start()

func _on_Tween_tween_completed(object, key):
	var audioStream
	randomize()
	if sound ==1:
		var rand = randi()%2
		if battle==false:
			if rand ==0:
				audioStream=preload("res://Sounds/napping_on_a_cloud.ogg")
			else:
				audioStream=preload("res://Sounds/DayAndNight.wav")
		else:
			if rand ==0:
				audioStream=preload("res://Sounds/tiny_swords_duel.ogg")
			else:
				audioStream=preload("res://Sounds/Gran Batalla.mp3")
		music.volume_db=0
	elif sound ==2:
		var rand = randi()%2
		if battle==false:
			if rand ==0:
				audioStream=preload("res://Sounds/twentyone_tranquil.ogg")
				music.volume_db=10
			else:
				audioStream=preload("res://Sounds/artblock.ogg")
				music.volume_db=0
		else:
			if rand ==0:
				audioStream=preload("res://Sounds/FragileCeiling.ogg")
				music.volume_db=10
			else:
				audioStream=preload("res://Sounds/Evil 03.ogg")
				music.volume_db=0
	music.set_stream(audioStream)
	music.play()

