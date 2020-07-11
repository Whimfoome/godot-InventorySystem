extends Node


export(NodePath) var gui_path = "GUI"
var health := 100
onready var gui = get_node(gui_path)


func _input(event):
	if event.is_action_pressed("ui_accept"):
		$InventoryComponent.toggle_window(self, "InventoryWindow", "res://Inventory/UI/InventoryWindow.tscn")
	
	# Query test by hitting 'Esc' for Apple
	if event.is_action_pressed("ui_cancel"):
		if $InventoryComponent.inv_query("Apple", 2):
			print("it has 2 apples or more")
		else:
			print("doesn't have 2 apples")


func _on_item_interacted(sender, item, amount):
	if $InventoryComponent.add_to_inventory(item, amount):
		sender.queue_free()
