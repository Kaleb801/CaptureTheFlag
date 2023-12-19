extends Node2D

func explosion():
	$image.visible=false
	$AnimatedSprite.visible=true
	$AnimatedSprite.play("default")
	var tilemap = get_tree().get_current_scene().get_node("/root/stage/tile_map")
	var stage= get_tree().get_current_scene().get_node("/root/stage")
	var pos = tilemap.world_to_map(position)
	var i =-2
	var j =-2
	while i<3:
		while j<3:
			tilemap.set_cell_hp(5,Vector2(pos.x+i,pos.y+j))
			j+=1
		j=-2
		i+=1

func _on_AnimatedSprite_animation_finished():
	var stage= get_tree().get_current_scene().get_node("/root/stage")
	queue_free()
