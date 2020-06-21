extends IItem


func _init():
	self.i_name = "Mushroom"
	self.i_image = load("res://Inventory/Items/Image_Mushroom.png")
	self.i_stackable = false


func i_use(player):
	player.health -= 10
	.i_use(player)
