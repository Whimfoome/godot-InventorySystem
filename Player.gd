extends Node


var health := 100


func _input(event):
	if event.is_action_pressed("ui_accept"):
		$InventoryComponent.toggle_window("InventoryWindow", "res://Inventory/UI/InventoryWindow.tscn")


func _on_item_interacted(sender, item, amount):
	if $InventoryComponent.add_to_inventory(item, amount):
		sender.queue_free()
