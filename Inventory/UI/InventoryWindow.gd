extends MarginContainer


var slot_list = Array()


func _ready():
	for i in range(get_parent().inv_slots):
		var slot_child = get_parent().ItemSlotClass.instance()
		slot_child.slot_index = i
		$Background/InventoryGrid.add_child(slot_child)
		slot_list.append(slot_child)
	$Background/UpperOverlay/InventoryName.text = get_parent().inv_name


func _on_CloseButton_pressed():
	queue_free()
