extends Control

var hearts = 0
var max_hearts = 0
var stage
var player_name 

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty

func set_hearts(value,player):
	if player_name==player:
		hearts = clamp(value,0,max_hearts)
		if heartUIFull != null:
			heartUIFull.rect_size.x = hearts * 32

func set_max_hearts(value,player):
	if player_name==player:
		max_hearts = max(value,1)
		self.hearts = min(hearts, max_hearts)
		if heartUIEmpty != null:
			heartUIEmpty.rect_size.x = max_hearts * 32

func _ready():
	stage = get_tree().get_current_scene().get_node("/root/stage")
	stage.connect("health_changed",self,"set_hearts")
	stage.connect("max_health_changed",self,"set_max_hearts")
