extends MarginContainer


var slot_index := 0
var item_struct: IItem
var stack_amount := 0

onready var inventory_comp = get_node("../../../../")
onready var ui_stackamount: Label = get_node("Background/Overlay/StackAmount")
onready var ui_image: TextureRect = get_node("Background/Overlay/Image")


func _ready():
	refresh_slot()


func refresh_slot():
	item_struct = inventory_comp.inv_slotstruct[slot_index]
	stack_amount = inventory_comp.inv_slotstack[slot_index]
	
	if item_struct != null:
		ui_image.texture = item_struct.i_image
		ui_stackamount.text = str(stack_amount)
	else:
		stack_amount = 0
		inventory_comp.inv_slotstack[slot_index] = 0
	
	if stack_amount <= 0:
		stack_amount = 0
		inventory_comp.inv_slotstack[slot_index] = stack_amount
		
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
		if event.button_index == BUTTON_LEFT and not event.pressed:
			pass
		elif event.button_index == BUTTON_RIGHT and not event.pressed:
			if inventory_comp.inv_slotstruct[slot_index] != null:
				var interactor_inventory_comp = inventory_comp.interactor.get_node("InventoryComponent")
				
				if inventory_comp == interactor_inventory_comp:
					inventory_comp.use_item_at_slot(slot_index)
				elif interactor_inventory_comp.add_to_inventory(item_struct, stack_amount):
					inventory_comp.inv_slotstruct[slot_index] = null
					inventory_comp.inv_slotstack[slot_index] = 0
					print("hellooooo")
					refresh_slot()
			else:
				refresh_slot()
