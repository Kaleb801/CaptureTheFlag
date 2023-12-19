extends KinematicBody2D

export var type = ""
var gravity = Vector2(0,700)

func _physics_process(delta):
	move_and_slide(gravity)

func _ready():
	$AnimatedSprite.play("default")

func explosion():
	$AnimatedSprite.visible=false
	var tilemap = get_tree().get_current_scene().get_node("/root/stage/tile_map")
	var stage= get_tree().get_current_scene().get_node("/root/stage")
	var pos = tilemap.world_to_map(position)
	var i =-2
	var j =-2
	while i<3:
		while j<3:
			var force = 0
			if type=="Copper":
				force=3
			if type=="Iron":
				force=4
			if type=="Mythril":
				force=5
			if type=="Adamant":
				force=6
			if type=="Dragonite":
				force=7
			tilemap.set_cell_hp(force,Vector2(pos.x+i,pos.y+j))
			j+=1
		j=-2
		i+=1
	queue_free()

func _on_AnimatedSprite_animation_finished():
	explosion()
