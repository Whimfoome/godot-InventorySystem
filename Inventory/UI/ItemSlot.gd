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
	if inventory_comp.inv_slotstruct[slot_index] == null:
		inventory_comp.inv_slotstruct[slot_index] = IItem.new()
	
	item_struct = inventory_comp.inv_slotstruct[slot_index]
	stack_amount = inventory_comp.inv_slotstack[slot_index]
	
	if stack_amount <= 0:
		stack_amount = 0
		inventory_comp.inv_slotstack[slot_index] = stack_amount
		
		ui_image.visible = false
		ui_stackamount.visible = false
	else:
		ui_image.visible = true
		ui_stackamount.visible = true
	
	ui_image.texture = item_struct.i_image
	ui_stackamount.text = str(stack_amount)


func _on_Button_gui_input(event):
	if event is InputEventMouseButton:
		# not event.pressed means released
		if event.button_index == BUTTON_LEFT and not event.pressed:
			pass
		elif event.button_index == BUTTON_RIGHT and not event.pressed:
			if inventory_comp.inv_slotstack[slot_index] > 0:
				var interactor_inventory_comp = inventory_comp.interactor.get_node("InventoryComponent")
				
				if inventory_comp == interactor_inventory_comp:
					item_struct.i_use(inventory_comp.interactor)
					if item_struct.i_consumable:
						inventory_comp.inv_slotstack[slot_index] -= 1
						refresh_slot()
				else:
					if interactor_inventory_comp.add_to_inventory(item_struct, stack_amount):
						inventory_comp.inv_slotstack[slot_index] = 0
						refresh_slot()
