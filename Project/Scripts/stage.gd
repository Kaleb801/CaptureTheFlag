extends Node
var max_health_p1 = 5
var max_health_p2 = 5
export var life_p1 = 0
export var life_p2 = 0
var health_p1 = 5
var health_p2 = 5
var score_p1 = 0 
var score_p2 = 0
var camera
var itens = []
onready var Item = preload("res://Scenes/ItemDrop.tscn")

signal no_health(player)
signal score_changed(value,player)
signal health_changed(value,player)
signal max_health_changed(value,player)
signal life_changed(value,player)

sync func set_life(value,player):
	if player=="player1":
		if value!=0:
			life_p1+=value
		else:
			life_p1=value
		emit_signal("life_changed",life_p1,player)
	elif player=="player2":
		if value!=0:
			life_p2+=value
		else:
			life_p2=value
		emit_signal("life_changed",life_p2,player)
		

sync func set_max_health(value,player):
	if player=="player1":
		max_health_p1 = value
		self.health_p1 = min(health_p1, max_health_p1)
		emit_signal("max_health_changed",max_health_p1,player)
	elif player=="player2":
		max_health_p2 = value
		self.health_p2 = min(health_p2, max_health_p2)
		emit_signal("max_health_changed",max_health_p2,player)

sync func set_score(value,player):
	if player=="player1":
		if value!=0:
			score_p1+=value
		else:
			score_p1=value
		emit_signal("score_changed",score_p1,player)
	elif player=="player2":
		if value!=0:
			score_p2+=value
		else:
			score_p2=value
		emit_signal("score_changed",score_p2,player)

sync func set_health(value,player):
	if player=="player1":
		health_p1 += value
		emit_signal("health_changed",health_p1,"player1")
		if health_p1 <= 0:
			health_p1=0
			emit_signal("no_health",player)
	elif player=="player2":
		health_p2 += value
		emit_signal("health_changed",health_p2,"player2")
		if health_p2 <= 0:
			health_p2=0
			emit_signal("no_health",player)


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
			
sync func update_stage_terrain(action,mouse):
	var tilemap = $tile_map
	if action=="delete_dirt":
		tilemap.set_cellv(mouse,-1)
		tilemap.update_bitmask_area(mouse)
		var item = Item.instance()
		add_child(item)
		item.item_name="Dirt"
		item.update()
		item.position = tilemap.map_to_world(mouse)
	elif action=="put":
		tilemap.set_cellv(mouse,0)
		tilemap.update_bitmask_area(mouse)
	elif action=="generate_logs":
		var item = Item.instance()
		add_child(item)
		item.item_name="Logs"
		item.update()
		item.position = tilemap.map_to_world(mouse)

func _ready():
	if (get_tree().is_network_server()):		
		#If in the server, get control of player 2 to the other peer.
		#This function is tree recursive by default.
		get_node("player2").set_network_master(get_tree().get_network_connected_peers()[0])
		camera = get_node("player1/camera1")
		camera._set_current(true)
	else:
		#If in the client, give control of player 2 to itself. 
		#This function is tree recursive by default.
		get_node("player2").set_network_master(get_tree().get_network_unique_id())
		camera = get_node("player2/camera2")
		camera._set_current(true)
	print("unique id: ",get_tree().get_network_unique_id())
