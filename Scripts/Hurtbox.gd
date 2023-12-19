extends Area2D

const HitEffect = preload("res://Scenes/HitEffect.tscn")

var invincible = false setget set_invincible
var enemy=false
var player = false

onready var timer = $Timer

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position


func _on_Timer_timeout():
	self.invincible = false


func _on_Hurtbox_invincibility_started():
	if get_collision_layer_bit(2)==true:
		player=true
		set_collision_layer_bit(2,false)
	if get_collision_layer_bit(3)==true:
		enemy=true
		set_collision_layer_bit(3,false)

func _on_Hurtbox_invincibility_ended():
	if player==true:
		set_collision_layer_bit(2,true)
		player=false
	if enemy==true:
		set_collision_layer_bit(3,true)
		enemy=false
