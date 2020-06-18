class_name Inventory_Component
extends Node


const ItemSlotClass = preload("res://Inventory/UI/ItemSlot.tscn")

export(String) var inv_name = "Name"
export(int) var inv_slots = 5
export(Array, String, FILE, "*.gd") var start_items
export(Array, int) var start_items_amount

var inv_slotstruct := Array()
var inv_slotstack := Array()


func _ready():
	prepare_inventory()
	if (start_items.size() == start_items_amount.size()) and (start_items.size() > 0):
		add_starting_items()


func prepare_inventory():
	for _i in range(inv_slots):
		var new_slot = ItemSlotClass.instance()
		inv_slotstruct.append(new_slot.item_struct)
		inv_slotstack.append(new_slot.stack_amount)


func add_to_inventory(struct:IItem, amount:int) -> bool:
	if struct.i_stackable:
		var returned_stack = has_partial_stack(struct)
		if returned_stack[0]:
			add_to_stack(struct, amount, returned_stack[1])
			return true
		else:
			create_stack(struct, amount)
			return true
	else:
		create_stack(struct, amount)
		return true


func create_stack(struct:IItem, amount:int):
	var index = inv_slotstack.find(0)
	inv_slotstruct[index] = struct
	inv_slotstack[index] = amount


func has_partial_stack(struct:IItem) -> Array:
	var loc_i: int = -1
	var loc_b: bool = false
	for i in range(inv_slotstack.size()):
		if (inv_slotstruct[i].get_class() == struct.get_class()) and (inv_slotstack[i] < struct.i_maxstack):
			loc_i = i
			loc_b = true
			break
	return [loc_b, loc_i]


func add_to_stack(struct:IItem, amount:int, index:int):
	var current_amount = inv_slotstack[index]
	if (current_amount + amount) > inv_slotstruct[index].i_maxstack:
		inv_slotstruct[index] = struct
		inv_slotstack[index] = struct.i_maxstack
		var _calc = amount - (struct.i_maxstack - current_amount)
		var _success = add_to_inventory(struct, _calc)
	else:
		inv_slotstack[index] += amount


func add_starting_items():
	for i in start_items.size():
		var _succ = add_to_inventory(load(start_items[i]).new(), start_items_amount[i])


func toggle_window(window_name: String, window_path: String):
	if not has_node(window_name):
		add_child(load(window_path).instance())
	else:
		get_child(0).queue_free()
