extends Spatial

export(Dictionary) var properties setget set_properties
export(PackedScene) var player

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
	var _unused = get_parent().connect("build_complete", self, "create_player")

func create_player():
	update_properties()
	var p = player.instance()
	get_parent().add_child(p)
	p.global_transform = global_transform
	p.body.rotate(Vector3.UP, deg2rad(180+angle))
	
	queue_free()
