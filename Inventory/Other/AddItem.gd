extends Control


signal interacted(sender, item, amount)

export(String, FILE, "*.gd") var directory = ""
export(int) var amount = 1
export(String) var group = "Player"

var item


func _ready():
	var groupnodes = get_tree().get_nodes_in_group(group)
	var _succ = connect("interacted", groupnodes[0], "_on_item_interacted")
	
	if not directory == "":
		item = load(directory).new()
		$Button/TextureRect.texture = item.i_image


func _on_pressed():
	if not directory == "":
		emit_signal("interacted", self, item, amount)
