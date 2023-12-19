extends Node2D

var hp = 6
export var type = "Tree"
var player
var pos
var delete=false
var destroy=false

func generate():
	var audioStream=preload("res://Sounds/crack05.mp3.wav")
	$Hit.set_stream(audioStream)
	$Hit.play()
	var stage = get_tree().get_current_scene().get_node("/root/stage")
	if type=="Tree":
		stage.rpc("update_stage_item","generate","Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Sap",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Sap",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Wood Seed",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Wood Seed",Vector2(position.x,position.y+30))
		stage.rpc("set_exp",0.4,PlayerInventory.player)
	if type=="Birch":
		stage.rpc("update_stage_item","generate","Birch Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Birch Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Birch Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Sap",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Sap",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Birch Seed",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Birch Seed",Vector2(position.x,position.y+30))
		stage.rpc("set_exp",0.6,PlayerInventory.player)
	if type=="Plum":
		stage.rpc("update_stage_item","generate","Plum Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Plum Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Plum Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Sap",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Sap",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Plum Seed",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Plum Seed",Vector2(position.x,position.y+30))
		stage.rpc("set_exp",0.8,PlayerInventory.player)
	if type=="Eucalyptus":
		stage.rpc("update_stage_item","generate","Eucalyptus Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Eucalyptus Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Eucalyptus Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Sap",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Sap",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Eucalyptus Seed",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Eucalyptus Seed",Vector2(position.x,position.y+30))
		stage.rpc("set_exp",1,PlayerInventory.player)
	if type=="Brazier":
		stage.rpc("update_stage_item","generate","Brazier Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Brazier Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Brazier Log",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Sap",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Sap",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Brazier Seed",Vector2(position.x,position.y+30))
		stage.rpc("update_stage_item","generate","Brazier Seed",Vector2(position.x,position.y+30))
		stage.rpc("set_exp",1.2,PlayerInventory.player)
	$Hurtbox.set_collision_layer_bit(4,false)
	visible=false
	delete=true

func _ready():
	var stage = get_tree().get_current_scene().get_node("/root/stage")
	var tilemap = get_tree().get_current_scene().get_node("/root/stage/tile_map")
	var pos = tilemap.world_to_map(position)
	stage.itens.append(self)
	if type=="Tree":
		hp=12
	if type=="Birch":
		hp=16
	if type=="Plum":
		hp=20
	if type=="Eucalyptus":
		hp=24
	if type=="Brazier":
		hp=28

func _on_Hurtbox_area_entered(area):
	if area.damage!=0 and area.name=="Axe":
		if PlayerInventory.player=="player1":
			player=get_tree().get_current_scene().get_node("/root/stage/player1")
		else:
			player=get_tree().get_current_scene().get_node("/root/stage/player2")
		hp-=area.damage
		if player.position.x>=position.x:
			$Sprite.rotation_degrees=-2
		else:
			$Sprite.rotation_degrees=2
		$Timer.start()
		if hp<=0:
			generate()
		else:
			$Hit.play()

func _on_Timer_timeout():
	$Sprite.rotation_degrees=0

func plant():
	$Hurtbox.set_collision_layer_bit(4,false)
	visible=false
	if type=="Tree":
		$Grow.wait_time=120
	if type=="Birch":
		$Grow.wait_time=180
	if type=="Plum":
		$Grow.wait_time=240
	if type=="Eucalyptus":
		$Grow.wait_time=300
	if type=="Brazier":
		$Grow.wait_time=360
	$Grow.start()
	
func _on_Grow_timeout():
	var tilemap = get_tree().get_current_scene().get_node("/root/stage/tile_map")
	tilemap.set_cellv(pos,-1)
	$Hurtbox.set_collision_layer_bit(4,true)
	visible=true

func _on_Hit_finished():
	if delete==true:
		var stage = get_tree().get_current_scene().get_node("/root/stage")
		stage.rpc("update_stage_item","delete",name,position)
