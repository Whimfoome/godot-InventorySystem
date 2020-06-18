extends MarginContainer


const ItemSlot = preload("res://Inventory/UI/ItemSlot.tscn")


func _ready():
	for i in range(get_parent().inv_slots):
		var slot_child = get_parent().ItemSlotClass.instance()
		slot_child.slot_index = i
		slot_child.item_struct = get_parent().inv_slotstruct[i]
		slot_child.stack_amount = get_parent().inv_slotstack[i]
		$Background/InventoryGrid.add_child(slot_child)
	$Background/UpperOverlay/InventoryName.text = get_parent().inv_name


func _on_CloseButton_pressed():
	queue_free()
