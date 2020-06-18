extends Control


func _on_Button_pressed():
	$InventoryComponent.toggle_window("ContainerWindow", "res://Inventory/Other/ContainerWindow.tscn")
