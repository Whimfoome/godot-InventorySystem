extends Control


func _on_Button_pressed():
	var player = get_tree().get_nodes_in_group("Player")[0]
	$InventoryComponent.toggle_window(player)
