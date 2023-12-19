extends AnimatedSprite

var player
var bodyinside

func _ready():
	$Timer.start()
	$Timer2.start()

func _on_Area2D_body_entered(body):
	var stage= get_tree().get_current_scene().get_node("/root/stage")
	if body.name==player and player=="player1":
		bodyinside=body
		stage.rpc("set_health",1,body.name)
		$Timer.start()
	if body.name==player and player=="player2":
		bodyinside=body
		stage.rpc("set_health",1,body.name)
		$Timer.start()

func _on_Timer2_timeout():
	queue_free()

func _on_Timer_timeout():
	$Area2D.set_collision_mask_bit(1,false)
	$Area2D.set_collision_mask_bit(1,true)
