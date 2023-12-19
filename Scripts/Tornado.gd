extends KinematicBody2D

var destiny

func _ready():
	$Timer.start()

func _on_Area2D_body_entered(body):
	pass

func _on_Timer_timeout():
	queue_free()
