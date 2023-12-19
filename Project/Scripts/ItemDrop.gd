extends KinematicBody2D

const ACCELERATION = 800
const MAX_SPEED = 550
var velocity = Vector2.ZERO
var item_name = ""
var player = null
var being_picked_up = false
var dirt = preload("res://Images/Dirt.png")
var logs = preload("res://Images/Log.png")

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

func pick_up_item(body):
	player = body
	being_picked_up = true
	
func update():
	if item_name=="Dirt":
		$Sprite.texture=dirt
	elif item_name=="Log":
		$Sprite.texture=logs
