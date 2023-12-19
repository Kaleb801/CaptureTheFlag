extends Node2D

func set_exp(value,stat,player):
	var stage = get_tree().get_current_scene().get_node("/root/stage")
	if player==PlayerInventory.player:
		if stat == "Collect":
			$Label/Collect/UIFull.rect_size.x = value * 32
			if $Label/Collect/UIFull.rect_size.x>=320:
				$Level/Collect.text = str(int($Level/Collect.text) + 1)
				value=0
				if player=="player1":
					stage.colect_p1=0
				else:
					stage.colect_p2=0
				$Label/Collect/UIFull.rect_size.x = value * 32
		if stat == "Combat":
			$Label/Combat/UIFull.rect_size.x = value * 32
			if $Label/Combat/UIFull.rect_size.x>=320:
				$Level/Combat.text = str(int($Level/Colect.text) + 1)
				value=0
				if player=="player1":
					stage.combat_p1=0
				else:
					stage.combat_p2=0
				$Label/Combat/UIFull.rect_size.x = value * 32
		if stat == "Craft":
			$Label/Craft/UIFull.rect_size.x = value * 32
			if $Label/Craft/UIFull.rect_size.x>=320:
				$Level/Craft.text = str(int($Level/Craft.text) + 1)
				value=0
				if player=="player1":
					stage.craft_p1=0
				else:
					stage.craft_p2=0
				$Label/Craft/UIFull.rect_size.x = value * 32
		if stat == "Class":
			$Label/Class/UIFull.rect_size.x = value * 32
			if $Label/Class/UIFull.rect_size.x>=320:
				$Level/Class.text = str(int($Level/Class.text) + 1)
				value=0
				if player=="player1":
					stage.class_p1=0
				else:
					stage.class_p2=0
				$Label/Class/UIFull.rect_size.x = value * 32
	

func _ready():
	var stage= get_tree().get_current_scene().get_node("/root/stage")
	stage.connect("exp_changed",self,"set_exp")
