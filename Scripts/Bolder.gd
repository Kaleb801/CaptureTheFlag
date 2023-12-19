extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 100
export var FRICTION = 124
var velocity = Vector2.ZERO
var destiny
var stop = false

func _ready():
	$AnimatedSprite.play("default")
	$Timer.start()

func _physics_process(delta):
	if stop==true:
		velocity = velocity.move_toward((Vector2(destiny) - global_position).normalized()  * MAX_SPEED, ACCELERATION * delta)
		velocity = move_and_slide_with_snap(velocity,Vector2.DOWN,Vector2.UP)
		destiny+=velocity

func _on_Area2D_body_entered(body):
	if body.name!=$Hitbox.player:
		queue_free()

func _on_Timer_timeout():
	queue_free()

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation=="default":
		$AnimatedSprite.play("idle")
		stop = true
