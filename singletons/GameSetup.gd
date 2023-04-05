extends Node

func load_map_by_resource(map_file: QuakeMapFile):
	load_scene("World")
	GameWorld.set_map(map_file.get_file_path())
	GameWorld.build_map()
	Console.write_line("Successfully changed map")

func load_map(map_name: String = ''):
	load_scene("World")
	Console.write_line('Loading map ' + map_name)
	if !find_and_set_map(map_name):
		Console.write_line('Failed to find ' + map_name +'\nIs it even in the maps folder?')
		return
	GameWorld.build_map()
	Console.write_line("Successfully changed map to " + map_name)
	

# This returns bool. If it's true, the GameWorld's path has been set
func find_and_set_map(map_name = '')-> bool:
	var file = File.new()
	var error = file.open("res://maps/"+map_name+".map", File.READ)
	GameWorld.set_map(file.get_path_absolute())
	file.close()
	if error != OK:
		return false
	return true

func setting(setting_name="", new_setting = .0):
	if Settings.get(setting_name) == null:
		Console.write_line("No setting named "+setting_name)
		return
	Settings.set(setting_name, new_setting)

func load_scene(scene_name=""):
	GameWorld.delete_map()
	var file = File.new()
	if file.file_exists("res://scenes/"+scene_name+".tscn"):
		var level = get_tree().root.get_node("Everything/ReplaceMe")
		var newScene = load("res://scenes/"+scene_name+".tscn")
		for child in level.get_children():
			child.queue_free()
		level.add_child(newScene.instance())
		
		Console.write_line("Loaded scene "+scene_name)
	else:
		Console.write_line(scene_name+" doesn't exist!")

func noclip():
	if GlobalVariables.currentPlayer == null:
		Console.write_line("No player existing! Can't noclip!")
		return
	GlobalVariables.currentPlayer.toggle_noclip()

func noclip_speed(speed: float):
	if GlobalVariables.currentPlayer == null:
		Console.write_line("No player existing! Can't noclip!")
		return
	GlobalVariables.currentPlayer.noclip_speed = speed

func _ready():
	Console.add_command("load_scene", self, "load_scene")\
			.set_description("Loads a valid scene under the directory /entities/scenes/")\
			.add_argument("scene_name", TYPE_STRING)\
			.register()

	Console.add_command("load_map", self, 'load_map')\
			.set_description("Loads a valid .map file in the maps directory")\
			.add_argument("map_name", TYPE_STRING)\
			.register()

	Console.add_command("setting", self, "setting")\
			.set_description("Sets a game setting")\
			.add_argument("setting_name", TYPE_STRING)\
			.add_argument("new_setting", TYPE_REAL)\
			.register()
	
	Console.add_command("noclip_speed", self, "noclip_speed")\
			.set_description("Set noclip speed")\
			.add_argument("speed", TYPE_REAL)\
			.register()
	
	Console.add_command("noclip", self, "noclip")\
			.set_description("Toggles noclip")\
			.register()
	
