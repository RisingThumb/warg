extends Node

signal trigger()

func _ready():
	self.collision_layer = 3
	self.collision_mask = 3
	get_child(0).used_in_baked_light = true
