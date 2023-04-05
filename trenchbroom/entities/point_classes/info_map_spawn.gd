extends Spatial

export(Dictionary) var properties setget set_properties

var angle = 0

func set_properties(new_properties: Dictionary) -> void:
	if properties != new_properties:
		properties = new_properties
		update_properties()

func update_properties() -> void:
	if 'angle' in properties:
		angle = properties.angle

func _ready():
	rotate(Vector3.UP, deg2rad(angle))
	get_parent().connect("build_complete", self, "verify_and_build")
	#var _unused = get_parent().connect("build_complete", self, "create_player")
