extends MarginContainer


var slot_index := 0
var item_struct: IItem
var stack_amount := 0

onready var inv_comp = get_node("../../../").inv_comp
onready var ui_stackamount: Label = get_node("Background/Overlay/StackAmount")
onready var ui_image: TextureRect = get_node("Background/Overlay/Image")


func _ready():
	refresh_slot()


func refresh_slot():
	item_struct = inv_comp.inv_struct_list[slot_index]
	stack_amount = inv_comp.inv_amount_list[slot_index]
	
	if item_struct != null:
		ui_image.texture = item_struct.i_image
		ui_stackamount.text = str(stack_amount)
	else:
		stack_amount = 0
		inv_comp.inv_amount_list[slot_index] = 0
	
	if stack_amount <= 0:
		stack_amount = 0
		inv_comp.inv_amount_list[slot_index] = stack_amount
		
		ui_image.visible = false
		ui_stackamount.visible = false
		
		if item_struct != null:
			item_struct.queue_free()
	else:
		ui_image.visible = true
		ui_stackamount.visible = true


func _on_gui_input_signal(event):
	if event is InputEventMouseButton:
		# not event.pressed means released
		if event.button_index == BUTTON_RIGHT and not event.pressed:
			if inv_comp.inv_struct_list[slot_index] != null:
				var interactor_inv_comp = inv_comp.interactor.get_node("InventoryComponent")
				
				if inv_comp == interactor_inv_comp:
					inv_comp.use_item_at_slot(slot_index)
				# If right clicking item from a Container, don't use it, but add it
				elif interactor_inv_comp.add_to_inventory(item_struct, stack_amount):
					inv_comp.inv_struct_list[slot_index] = null
					inv_comp.inv_amount_list[slot_index] = 0
					refresh_slot()
			else:
				refresh_slot()
