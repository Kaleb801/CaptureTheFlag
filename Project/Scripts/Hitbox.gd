extends Area2D

export var damage = 1
export var duration = 0.5

var player = ""


func _on_Axe_area_entered(area):
	print(area.name)
