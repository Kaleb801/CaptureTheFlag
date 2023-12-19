extends Node2D

export var color = ""

func _ready():
	if color=="red":
		$AnimatedSprite.play("red")
	else:
		$AnimatedSprite.play("blue")

func _on_Area2D_body_entered(body):
	var stage= get_tree().get_current_scene().get_node("/root/stage")
	if body.name=="player1" and $AnimatedSprite.animation=="red":
		body.flag=true
		body.get_node("Flag").visible=true
		visible=false
		$Area2D.set_collision_mask_bit(1,false)
	elif body.name=="player2" and $AnimatedSprite.animation=="blue":
		body.flag=true
		body.get_node("Flag").visible=true
		visible=false
		$Area2D.set_collision_mask_bit(1,false)
	elif body.name=="player1" and $AnimatedSprite.animation=="blue":
		if body.flag==true:
			var string = get_tree().get_current_scene().get_node("/root/stage/UserInterface/Score/Timer2/RichTextLabel2")
			stage.flag1+=1
			string.text=str(stage.flag1)
			body.get_node("Flag").visible=false
			body.flag=false
			stage.get_node("Props/Flags/Flag").enable()
	elif body.name=="player2" and $AnimatedSprite.animation=="red":
		if body.flag==true:
			var string = get_tree().get_current_scene().get_node("/root/stage/UserInterface/Score/Timer2/RichTextLabel")
			stage.flag2+=1
			body.get_node("Flag").visible=false
			string.text=str(stage.flag2)
			body.flag=false
			stage.get_node("Props/Flags/Flag2").enable()
			
			
		
func enable():
	$Area2D.set_collision_mask_bit(1,true)
	visible=true
