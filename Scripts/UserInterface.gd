extends CanvasLayer
var holding_item = null
var end =false

func _input(event):
	if event.is_action_pressed("inventory") and end==false:
		$Craft.images.clear()
		$Inventory/Bag.disabled=true
		$Inventory/Class.disabled=false
		$Inventory/GridContainer.visible=true
		$Inventory/EquipSlots.visible=true
		$Inventory/Skills.visible=false
		$Inventory.visible = !$Inventory.visible
		$Craft.visible = !$Craft.visible
		$Inventory.initialize_inventory()
		if $Craft.visible==true:
			$Craft._update()
			$Craft.stop=false
		else:
			$Craft.stop=true
			$Craft.delete()
	
	if event.is_action_pressed("1") or event.is_action_pressed("2") or event.is_action_pressed("3") or event.is_action_pressed("4") or event.is_action_pressed("5") or event.is_action_pressed("6") or event.is_action_pressed("7") or event.is_action_pressed("8"):
		PlayerInventory.active_item_scroll()

func visual():
	$Inventory.visible = !$Inventory.visible
	$Craft.visible = !$Craft.visible
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_join_pressed():
	get_tree().quit()
