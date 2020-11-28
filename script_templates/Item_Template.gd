extends IItem


func _init():
	self.i_name = ""
	self.i_image = load("res://path/to/image.png")
	self.i_description = ""
	self.i_consumable = true
	self.i_stackable = true
	self.i_maxstack = 5 # Optional (Use if i_stackable = true)


func i_use(player):
	# Add what happens when using the item.
	.i_use(player)