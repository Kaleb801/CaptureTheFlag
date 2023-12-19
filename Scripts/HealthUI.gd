extends Control

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty
onready var starUIFull = $StarUIFull
onready var starUIEmpty = $StarUIEmpty

func set_shield(value,player):
	if player == PlayerInventory.player:
		$Sprite/Label.text=str(value)

func set_sword(value,player):
	if player == PlayerInventory.player:
		$Sprite2/Label.text=str(value)


func set_hearts(value,player):
	if player == PlayerInventory.player:
		if heartUIFull != null:
			heartUIFull.rect_size.x = value * 32

func set_max_hearts(value,player):
	if player == PlayerInventory.player:
		if heartUIEmpty != null:
			heartUIEmpty.rect_size.x = value * 32

func set_stars(value,player):
	if player == PlayerInventory.player:
		if starUIFull != null:
			 starUIFull.rect_size.x = value * 32

func set_max_stars(value,player):
	if player == PlayerInventory.player:
		if starUIEmpty != null:
			starUIEmpty.rect_size.x = value * 32
	
func set_critical(value,player):
	if player == PlayerInventory.player:
		$Sprite3/Label.text=str(value)
		
func set_speed(value,player):
	if player == PlayerInventory.player:
		$Sprite4/Label.text=str(value)

func set_hpregen(value,player):
	if player == PlayerInventory.player:
		$Sprite5/Label.text=str(value)

func set_spregen(value,player):
	if player == PlayerInventory.player:
		$Sprite6/Label.text=str(value)
	
func _ready():
	var stage= get_tree().get_current_scene().get_node("/root/stage")
	stage.connect("health_changed",self,"set_hearts")
	stage.connect("max_health_changed",self,"set_max_hearts")
	stage.connect("star_changed",self,"set_stars")
	stage.connect("shield_changed",self,"set_shield")
	stage.connect("sword_changed",self,"set_sword")
	stage.connect("critical_changed",self,"set_critical")
	stage.connect("speed_changed",self,"set_speed")
	stage.connect("hpregen_changed",self,"set_hpregen")
	stage.connect("spregen_changed",self,"set_spregen")
	stage.connect("max_star_changed",self,"set_max_stars")
