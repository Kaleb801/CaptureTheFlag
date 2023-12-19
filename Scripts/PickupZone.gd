extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func space():
	for slot in PlayerInventory.slots2:
		if slot.item==null:
			return true
	return false
var items_in_range = {}

func _on_PickupZone_body_entered(body):
	if space():
		items_in_range[body] = body


func _on_PickupZone_body_exited(body):
	if items_in_range.has(body):
		items_in_range.erase(body)
