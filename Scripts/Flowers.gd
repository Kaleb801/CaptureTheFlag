extends Node2D

var hp = 3
export var type = ""
var player
var pos
var delete
var destroy=false

func _ready():
	var stage = get_tree().get_current_scene().get_node("/root/stage")
	stage.itens.append(self)

func _on_Hurtbox_area_entered(area):
	if area.damage!=0 and area.name=="Axe":
		$Audio.play()
		if PlayerInventory.player=="player1":
			player=get_tree().get_current_scene().get_node("/root/stage/player1")
		else:
			player=get_tree().get_current_scene().get_node("/root/stage/player2")
		hp-=area.damage
		if player.position.x>=position.x:
			rotation_degrees=-2
		else:
			rotation_degrees=2
		$Timer.start()
		if hp<=0:
			generate()

func generate():
	var stage = get_tree().get_current_scene().get_node("/root/stage")
	if type=="Carrot":
		stage.rpc("update_stage_item","generate","Carrot",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Carrot",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Carrot",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Carrot Seed",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Carrot Seed",Vector2(position.x,position.y))
		stage.rpc("set_exp",0.4,PlayerInventory.player)
	if type=="Onion":
		stage.rpc("update_stage_item","generate","Onion",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Onion",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Onion",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Onion Seed",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Onion Seed",Vector2(position.x,position.y))
		stage.rpc("set_exp",0.6,PlayerInventory.player)
	if type=="Beet":
		stage.rpc("update_stage_item","generate","Beet",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Beet",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Beet",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Beet Seed",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Beet Seed",Vector2(position.x,position.y))
		stage.rpc("set_exp",0.8,PlayerInventory.player)
	if type=="Lettuce":
		stage.rpc("update_stage_item","generate","Lettuce",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Lettuce",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Lettuce",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Lettuce Seed",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Lettuce Seed",Vector2(position.x,position.y))
		stage.rpc("set_exp",1,PlayerInventory.player)
	if type=="Pepper":
		stage.rpc("update_stage_item","generate","Pepper",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Pepper",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Pepper",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Pepper Seed",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Pepper Seed",Vector2(position.x,position.y))
		stage.rpc("set_exp",1.2,PlayerInventory.player)
	if type=="OrangePlant":
		stage.rpc("update_stage_item","generate","Orange Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Orange Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Orange Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Orange Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Orange Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Orange Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Orange Fiber",Vector2(position.x,position.y))
		stage.rpc("set_exp",0.4,PlayerInventory.player)
	if type=="GrayPlant":
		stage.rpc("update_stage_item","generate","Gray Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Gray Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Gray Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Gray Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Gray Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Gray Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Gray Fiber",Vector2(position.x,position.y))
		stage.rpc("set_exp",0.6,PlayerInventory.player)
	if type=="BluePlant":
		stage.rpc("update_stage_item","generate","Blue Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Blue Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Blue Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Blue Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Blue Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Blue Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Blue Fiber",Vector2(position.x,position.y))
		stage.rpc("set_exp",0.8,PlayerInventory.player)
	if type=="GreenPlant":
		stage.rpc("update_stage_item","generate","Green Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Green Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Green Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Green Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Green Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Green Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Green Fiber",Vector2(position.x,position.y))
		stage.rpc("set_exp",1,PlayerInventory.player)
	if type=="RedPlant":
		stage.rpc("update_stage_item","generate","Red Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Red Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Red Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Red Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Red Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Red Fiber",Vector2(position.x,position.y))
		stage.rpc("update_stage_item","generate","Red Fiber",Vector2(position.x,position.y))
		stage.rpc("set_exp",1.2,PlayerInventory.player)
	$Hurtbox.set_collision_layer_bit(4,false)
	visible=false
	delete=true


func _on_Timer_timeout():
	rotation_degrees=0

func plant():
	$Hurtbox.set_collision_layer_bit(4,false)
	visible=false
	if type=="Carrot":
		$Grow.wait_time=120
	if type=="Onion":
		$Grow.wait_time=180
	if type=="Beet":
		$Grow.wait_time=240
	if type=="Lettuce":
		$Grow.wait_time=300
	if type=="Pepper":
		$Grow.wait_time=360
	$Grow.start()
		
func _on_Grow_timeout():
	var tilemap = get_tree().get_current_scene().get_node("/root/stage/tile_map")
	tilemap.set_cellv(pos,-1)
	$Hurtbox.set_collision_layer_bit(4,true)
	visible=true

func _on_Audio_finished():
	if delete==true:
		var stage = get_tree().get_current_scene().get_node("/root/stage")
		stage.rpc("update_stage_item","delete",name,position)
