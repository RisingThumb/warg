extends Node


onready var gw: QodotMap = $GameWorld
var toDeleteOnNext = null

func _ready():
	print("GameWorld readied")

func _on_GameWorld_build_complete():
	pass

func _on_GameWorld_unwrap_uv2_complete():
	pass

func delete_map():
	for child in gw.get_children():
		child.queue_free()

func set_map(mapName:String):
	gw.map_file = mapName

func build_map():
	gw.verify_and_build()
