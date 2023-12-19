extends KinematicBody2D

var target
var player
var stage
var bodyinside
var linear_vel = Vector2.ZERO
var max_speed = 250  # Ajuste a velocidade máxima do drone aqui
var teleport_distance = 150  # Ajuste a distância máxima para teleportar o drone aqui

func _ready():
	$Timer.start()
	$Timer2.start()
	stage = get_tree().get_current_scene().get_node("/root/stage")

func _physics_process(delta):
	if target:
		# Obter a posição atual do drone e do alvo
		var current_position = global_transform.origin
		var target_position = target.global_transform.origin

		# Calcular a direção e distância até o alvo
		var direction = (target_position - current_position).normalized()
		var distance = current_position.distance_to(target_position)

		# Verificar se o drone está muito longe do alvo e teleportá-lo se necessário
		if distance > teleport_distance:
			# Teleportar o drone para cima do alvo
			global_transform.origin = target_position
		else:
			# Calcular a velocidade linear do drone usando a direção e a velocidade máxima
			linear_vel = direction * max_speed

		# Definir a altura do drone acima do alvo (por exemplo, 50 unidades acima da cabeça do alvo)
		var height_above_target = 50.0
		global_transform.origin.y = target_position.y - height_above_target

	# Mover o drone usando move_and_slide
	move_and_slide(linear_vel)

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
