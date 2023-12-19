extends Node2D

var hp = 6

func _ready():
	var stage = get_tree().get_current_scene().get_node("/root/stage")
	stage.itens.append(self)

func _on_Hurtbox_area_entered(area):
	if area.damage!=0:
		hp-=area.damage
		if hp<=0:
			var stage = get_tree().get_current_scene().get_node("/root/stage")
			stage.rpc("update_stage_item","generate","Log",position)
			stage.rpc("update_stage_item","delete",name,position)
