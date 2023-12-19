extends KinematicBody2D

onready var Item = preload("res://Scenes/ItemDrop.tscn")

const GRAVITY_VEC = Vector2(0, 900)
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 25.0
const MIN_ONAIR_TIME = 0.1
const WALK_SPEED = 250 # pixels/sec
const JUMP_SPEED = 480
const SIDING_CHANGE_SPEED = 10
const BULLET_VELOCITY = 1000
const SHOOT_TIME_SHOW_WEAPON = 0.2

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
var tools= false

#cache the sprite here for fast access (we will set scale to flip it often)
onready var sprite = $sprite
#This updates the position on the other end, along with linear velocity for animation calculations.
slave func set_pos_and_motion(p_pos,p_motion,new_tool,_anim):
	tools=new_tool
	new_anim=_anim
	position=p_pos
	linear_vel=p_motion
	if tools == true:
		switch_sprite()
#This function shoots bullets from the player on its own screen and on the other player's screen.
func _ready():
	stage= get_tree().get_current_scene().get_node("/root/stage")
	$UserInterface/HealthUI.player_name = name
	$UserInterface/HealthUI.set_max_hearts(5,name)
	$UserInterface/HealthUI.set_hearts(5,name)
	$Axe.player=self.name

func _physics_process(delta):
	
	#increment counters

	onair_time += delta
	shoot_time += delta

	### MOVEMENT ###

	# Apply Gravity
	linear_vel += delta * GRAVITY_VEC
	# Move and Slide
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	# Detect Floor
	if is_on_floor():
		onair_time = 0

	on_floor = onair_time < MIN_ONAIR_TIME

	### CONTROL ###
	if (is_network_master()):	
	# Horizontal Movement
		var target_speed = 0
		if Input.is_action_pressed("ui_left"):
			target_speed += -1
		if Input.is_action_pressed("ui_right"):
			target_speed +=  1
	
		target_speed *= WALK_SPEED
		linear_vel.x = lerp(linear_vel.x, target_speed, 0.1)

		# Jumping
		if on_floor and Input.is_action_just_pressed("jump"):
			linear_vel.y = -JUMP_SPEED
			
		if $PickupZone.items_in_range.size() > 0:
			var pickup_item = $PickupZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickupZone.items_in_range.erase(pickup_item)
		
		if Input.is_action_just_pressed("ui_accept"):
			var tilemap = get_tree().get_current_scene().get_node("/root/stage/tile_map")
			var pos = tilemap.world_to_map(get_global_mouse_position())
			if PlayerInventory.active_item_slot <= PlayerInventory.hotbar.size()-1:
				if PlayerInventory.hotbar[PlayerInventory.active_item_slot][0].find("pickaxe")!=-1:
					if position.x-get_global_mouse_position().x>=0:
						dir ="left"
					else:
						dir ="right"
					new_anim="player_pickaxe_"+dir
					switch_sprite()
					var area = get_area()
					for local in area:
						if local==pos:
							if tilemap.get_cellv(pos)==0:
								tools=true
								stage.rpc("update_stage_terrain","delete_dirt",pos)
				elif PlayerInventory.hotbar[PlayerInventory.active_item_slot][0].find("axe")!=-1:
					if position.x-get_global_mouse_position().x>=0:
						dir ="left"
					else:
						dir ="right"
					new_anim="player_axe_"+dir
					$Axe/CollisionShape2D.disabled=false
					$Axe/CollisionShape2D2.disabled=false
					switch_sprite()
					tools=true
				
		elif Input.is_action_pressed("ui_select") and !PlayerInventory.hotbar.empty() and PlayerInventory.hotbar.has(PlayerInventory.active_item_slot):
			if PlayerInventory.hotbar[PlayerInventory.active_item_slot][0]=="Dirt" and PlayerInventory.hotbar[PlayerInventory.active_item_slot][1]>=1:
				var tilemap = get_tree().get_current_scene().get_node("/root/stage/tile_map")
				var pos = tilemap.world_to_map(get_global_mouse_position())
				if tilemap.get_cellv(pos)==-1:
					PlayerInventory.add_item_quantity(PlayerInventory.slots[PlayerInventory.active_item_slot], -1)
					stage.rpc("update_stage_terrain","put",pos)

	### ANIMATION ###
	
	if tools==false:
		new_anim="player_idle_"+dir
		if on_floor:
			if linear_vel.x < -SIDING_CHANGE_SPEED:
				new_anim = "player_walk_left"
				dir = "left"
				
			if linear_vel.x > SIDING_CHANGE_SPEED:
				dir = "right"
				new_anim = "player_walk_right"
	if new_anim != anim:
		anim = new_anim
		get_node("anim").play(anim)
	rpc("set_pos_and_motion",position,linear_vel,tools,anim)

func pickup(body):
	var stage = get_tree().get_current_scene().get_node("/root/stage")
	stage.rpc("update_stage_item","delete",body.name,position)

func switch_sprite():
	$sprite.visible=false
	$sprite2.visible=true
	tools=true

func tool():
	$Axe/CollisionShape2D.disabled=true
	$Axe/CollisionShape2D2.disabled=true
	$sprite.visible=true
	$sprite2.visible=false
	tools=false
	
func get_area():
	var tilemap = get_tree().get_current_scene().get_node("/root/stage/tile_map")
	var tile = 16
	var area = [
	]
	var i=-2
	var j=-2
	while i<=2:
		while j<=2:
			area.append(tilemap.world_to_map(Vector2(position.x+i*tile,position.y+j*tile)))
			j+=1
		j=-2
		i+=1
	return area
	
func _on_Hurtbox_area_entered(area):
	if area.damage!=0:
		stage.rpc("set_health",area.damage*-1,name)
		$Hurtbox.start_invincibility(1)
		$Hurtbox.create_hit_effect()
