class_name Inventory_Component
extends Node


const ItemSlotClass = preload("res://Inventory/UI/ItemSlot.tscn")

export(String) var inv_name = "Name"
export(int) var inv_slots = 5
export(Array, String, FILE, "*.gd") var start_items
export(Array, int) var start_items_amount

var inv_slotstruct := Array()
var inv_slotstack := Array()
var interacter


func _ready():
	prepare_inventory()
	if (start_items.size() == start_items_amount.size()) and (start_items.size() > 0):
		add_starting_items()


func prepare_inventory():
	for _i in range(inv_slots):
		var new_slot = ItemSlotClass.instance()
		inv_slotstruct.append(new_slot.item_struct)
		inv_slotstack.append(new_slot.stack_amount)


func add_to_inventory(struct:IItem, amount:int):
	var _succ := false
	if struct.i_stackable:
		var returned_stack = has_partial_stack(struct)
		if returned_stack[0]:
			_succ = add_to_stack(struct, amount, returned_stack[1])
		else:
			_succ = create_stack(struct, amount)
	else:
		_succ = create_stack(struct, amount)
	return _succ


func create_stack(struct:IItem, amount:int) -> bool:
	var has_space := false
	for i in range(inv_slotstack.size()):
		if inv_slotstack[i] <= 0:
			has_space = true
			break
	if has_space:
		var index = inv_slotstack.find(0)
		if (amount > struct.i_maxstack):
			inv_slotstack[index] = struct.i_maxstack
			add_to_inventory(struct, amount - struct.i_maxstack)
		elif amount > 1 and not struct.i_stackable:
			inv_slotstack[index] = 1
			add_to_inventory(struct, amount - 1)
		else:
			inv_slotstack[index] = amount
		inv_slotstruct[index] = struct
		refresh_slots(index)
		return true
	else:
		return false


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
		if add_to_inventory(struct, _calc):
			refresh_slots(index)
	else:
		inv_slotstack[index] += amount
		refresh_slots(index)
	return true


func add_starting_items():
	for i in start_items.size():
		var _succ = add_to_inventory(load(start_items[i]).new(), start_items_amount[i])


func refresh_slots(index: int):
	if get_children() != []:
		get_children()[0].slot_list[index].refresh_slot()


func inv_query(item_class: String, item_amount: int) -> bool:
	var total: int = 0
	for i in range(inv_slotstruct.size()):
		if inv_slotstruct[i].get_class() == item_class:
			total += inv_slotstack[i]
	return total >= item_amount


func toggle_window(player, window_name: String, window_path: String):
	if not has_node(window_name):
		interacter = player
		add_child(load(window_path).instance())
	else:
		interacter = null
		get_child(0).queue_free()
