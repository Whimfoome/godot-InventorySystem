class_name IItem
extends Node


var i_name := "None"
var i_image: StreamTexture = load("res://icon.png")
var i_stackable := true
var i_maxstack := 5

onready var player = get_tree().get_nodes_in_group("Player")


func i_use():
	print("I was used ", self.i_name)


func get_class():
	return "IItem " + i_name
