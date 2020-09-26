extends ColorRect
# Uses Drag And Drop Built-In Function
#
# Implemented Tooltip here (Built-In Function)
# to work 'hint_tooltip' (in Hint property) should not be empty
#
# Ctrl Click the functions for more information


onready var slot = get_parent()


func get_drag_data(_pos):
	if slot.item_struct != null:
		var preview = TextureRect.new()
		preview.texture = slot.item_struct.i_image
		preview.expand = true
		preview.rect_size = Vector2(80, 80)
		set_drag_preview(preview)
		return slot
	else:
		return null


func can_drop_data(_pos, data) -> bool:
	if data != null:
		if data.item_struct is IItem:
			return true
		else:
			return false
	else:
		return false


func drop_data(_pos, data):
	if slot.item_struct != null:
		if not slot.item_struct.i_stackable or not data.item_struct.i_stackable or slot.item_struct != data.item_struct:
			slot.inv_comp.inv_amount_list[slot.slot_index] = data.stack_amount
			data.inv_comp.inv_amount_list[data.slot_index] = slot.stack_amount
		else:
			if data.stack_amount + slot.stack_amount > slot.item_struct.i_maxstack:
				slot.inv_comp.inv_amount_list[slot.slot_index] = slot.item_struct.i_maxstack
			else:
				slot.inv_comp.inv_amount_list[slot.slot_index] = slot.stack_amount + data.stack_amount
			
			(data.inv_comp.inv_amount_list[data.slot_index] -= 
					slot.inv_comp.inv_amount_list[slot.slot_index] - slot.stack_amount)
	else:
		slot.inv_comp.inv_amount_list[slot.slot_index] = data.stack_amount
		data.inv_comp.inv_amount_list[data.slot_index] = slot.stack_amount
	
	slot.inv_comp.inv_struct_list[slot.slot_index] = data.item_struct
	data.inv_comp.inv_struct_list[data.slot_index] = slot.item_struct
	slot.refresh_slot()
	data.refresh_slot()


func _make_custom_tooltip(_textt):
	var label = Label.new()
	if slot.item_struct != null:
		label.text = slot.item_struct.i_description
	else:
		label.text = ""
	return label
