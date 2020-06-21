extends Node


var health := 100


func _input(event):
	if event.is_action_pressed("ui_accept"):
		$InventoryComponent.toggle_window(self, "InventoryWindow", "res://Inventory/UI/InventoryWindow.tscn")
	
	if event.is_action_pressed("ui_cancel"):
		var item_query = load("res://Inventory/Items/Item_Apple.gd").new()
		if $InventoryComponent.inv_query(item_query.get_class(), 2):
			print("it has 2 apples or more")
		else:
			print("doesn't have 2 apples")


func _on_item_interacted(sender, item, amount):
	if $InventoryComponent.add_to_inventory(item, amount):
		sender.queue_free()
