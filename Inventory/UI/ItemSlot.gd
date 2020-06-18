extends MarginContainer


var slot_index := 0
var item_struct: IItem = IItem.new()
var stack_amount := 0

onready var ui_stackamount: Label = get_node("Background/Overlay/StackAmount")
onready var ui_image: TextureRect = get_node("Background/Overlay/Image")


func _ready():
	ui_stackamount.text = str(stack_amount)
	
	ui_image.texture = item_struct.i_image
	
	if stack_amount > 0:
		ui_image.visible = true
		ui_stackamount.visible = true
	else:
		ui_image.visible = false
		ui_stackamount.visible = false
