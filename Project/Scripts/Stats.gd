extends Node

export(int) var max_health_p1 = 1
export(int) var max_health_p2 = 1
export var life_p1 = 0
export var life_p2 = 0
var health_p1 = max_health_p1
var health_p2 = max_health_p2
var score_p1 = 0 
var score_p2 = 0

signal no_health(player)
signal score_changed(value,player)
signal health_changed(value,player)
signal max_health_changed(value,player)
signal life_changed(value,player)

func _ready():
	self.health_p1 = max_health_p1
	self.health_p2= max_health_p2

func set_life(value,player):
	if player=="p1":
		if value!=0:
			life_p1+=value
		else:
			life_p1=value
		emit_signal("life_changed",life_p1,player)
	else:
		if value!=0:
			life_p2+=value
		else:
			life_p2=value
		emit_signal("life_changed",life_p2,player)
		

func set_max_health(value,player):
	if player=="p1":
		max_health_p1 = value
		self.health_p1 = min(health_p1, max_health_p1)
		emit_signal("max_health_changed",max_health_p1,player)
	else:
		max_health_p2 = value
		self.health_p2 = min(health_p2, max_health_p2)
		emit_signal("max_health_changed",max_health_p2,player)

func set_score(value,player):
	if player=="p1":
		if value!=0:
			score_p1+=value
		else:
			score_p1=value
		emit_signal("score_changed",score_p1,player)
	else:
		if value!=0:
			score_p2+=value
		else:
			score_p2=value
		emit_signal("score_changed",score_p2,player)

func set_health(value,player):
	if player=="p1":
		health_p1 = value
		emit_signal("health_changed",health_p1,player)
		if health_p1 <= 0:
			health_p1=0
			emit_signal("no_health",player)
	else:
		health_p2 = value
		emit_signal("health_changed",health_p2,player)
		if health_p2 <= 0:
			health_p2=0
			emit_signal("no_health",player)
