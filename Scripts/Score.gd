extends Control

var phase = 0
var start = false
var battle = false
var build = "phase 01.\nCollect resources and build your base!"
var textBattle = "phase 02.\nProtect your flag and steal the enemy's!"

onready var timer = $Timer
onready var timerLabel = $Timer2/Label

func _ready():
	$Panel/Label.text=build

func _physics_process(delta):
	var stage= get_tree().get_current_scene().get_node("/root/stage")
	$Timer2/Label.text=str(int(stage.get_node("Phase").time_left))

func start():
	$Tween.interpolate_property($Panel, "rect_position", $Panel.rect_position, Vector2($Panel.rect_position.x, 0), 1.00, Tween.EASE_IN)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	var stage= get_tree().get_current_scene().get_node("/root/stage")
	if phase==-1:
		start()
		phase=0
	elif phase==0:
		$Transition.start()
	elif phase==1:
		$Tween.interpolate_property($Timer2, "rect_position", $Timer2.rect_position, Vector2($Timer2.rect_position.x, 0), 1.00, Tween.EASE_IN)
		$Tween.start()
		stage.rpc("timer")
		phase=2

func _on_Transition_timeout():
	$Tween.interpolate_property($Panel, "rect_position", $Panel.rect_position, Vector2($Panel.rect_position.x, -121), 1.00, Tween.EASE_IN)
	$Tween.start()
	phase=1

func _on_Phase_timeout():
	var stage= get_tree().get_current_scene().get_node("/root/stage")
	phase = -1
	if $Panel/Label.text==textBattle:
		stage.get_node("Phase").wait_time=900
		stage.rounds+=1
		if stage.rounds>3:
			if stage.flag1>stage.flag2 and PlayerInventory.player=="player1":
				stage.get_node("UserInterface/End/Win").visible=true
			elif stage.flag1<stage.flag2 and PlayerInventory.player=="player1":
				stage.get_node("UserInterface/End/Lose").visible=true
			elif stage.flag1>stage.flag2 and PlayerInventory.player=="player2":
				stage.get_node("UserInterface/End/Win").visible=true
			elif stage.flag1<stage.flag2 and PlayerInventory.player=="player2":
				stage.get_node("UserInterface/End/Lose").visible=true
			elif stage.flag1==stage.flag2:
				stage.get_node("UserInterface/End/Draw").visible=true
			stage.get_node("UserInterface/End").visible=true
			if PlayerInventory.player=="player1":
				stage.get_node("UserInterface/End/flags/Score").text=str(stage.flag1)
				stage.get_node("UserInterface/End/lostflags/Score").text=str(stage.flag2)
				stage.get_node("UserInterface/End/Kills/Score").text=str(stage.kills1)
				stage.get_node("UserInterface/End/Deaths/Score").text=str(stage.kills2)
			else:
				stage.get_node("UserInterface/End/flags/Score").text=str(stage.flag2)
				stage.get_node("UserInterface/End/lostflags/Score").text=str(stage.flag1)
				stage.get_node("UserInterface/End/Kills/Score").text=str(stage.kills2)
				stage.get_node("UserInterface/End/Deaths/Score").text=str(stage.kills1)
			stage.get_node("UserInterface/Inventory").visible=false
			stage.get_node("UserInterface/Hotbar").visible=false
			stage.get_node("UserInterface/Craft").visible=false
			stage.get_node("UserInterface/HealthUI").visible=false
			stage.get_node("UserInterface/Score").visible=false
			stage.get_node("UserInterface").end=true
			return
		stage.get_node("Border/Midle").disabled=false
		stage.get_node("camera1").limit_right=0
		stage.get_node("camera2").limit_left=0
		stage.battle=false
		$Panel/Label.text=build 
		stage.music(stage.sound,PlayerInventory.player)
		stage.get_node("player1").rpc("spawn","player1")
		stage.get_node("player2").rpc("spawn","player2")
		stage.get_node("player1").rpc("flags","player1")
		stage.get_node("player2").rpc("flags","player2")
	else:
		stage.get_node("Border/Midle").disabled=true
		stage.get_node("camera1").limit_right=4300
		stage.get_node("camera2").limit_left=-4300
		stage.battle=true
		$Panel/Label.text=textBattle
		stage.music(stage.sound,PlayerInventory.player)
		stage.get_node("Phase").wait_time=450
	$Tween.interpolate_property($Timer2, "rect_position", $Timer2.rect_position, Vector2($Timer2.rect_position.x, -82), 1.00, Tween.EASE_IN)
	$Tween.start()
