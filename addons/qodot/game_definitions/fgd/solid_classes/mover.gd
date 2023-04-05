extends KinematicBody

export(Dictionary) var properties setget set_properties

var base_transform: Transform
var offset_transform: Transform
var target_transform: Transform
var previous_transform: Transform

var speed := 1.0
var adjust
var tween: Tween

func set_properties(new_properties: Dictionary) -> void:
	if properties != new_properties:
		properties = new_properties
		update_properties()

func update_properties() -> void:
	base_transform = transform
	target_transform = base_transform
	if 'translation' in properties:
		offset_transform.origin = properties.translation

	if 'rotation' in properties:
		offset_transform.basis = offset_transform.basis.rotated(Vector3.RIGHT, properties.rotation.x)
		offset_transform.basis = offset_transform.basis.rotated(Vector3.UP, properties.rotation.y)
		offset_transform.basis = offset_transform.basis.rotated(Vector3.FORWARD, properties.rotation.z)

	if 'scale' in properties:
		offset_transform.basis = offset_transform.basis.scaled(properties.scale)

	if 'speed' in properties:
		speed = properties.speed

func _process(delta):
	#transform.interpolate_with(target_transform, speed*delta)
	adjust = global_transform.origin - previous_transform.origin
	previous_transform = global_transform

func _init() -> void:
	tween = Tween.new()
	add_child(tween)
	update_properties()

func use() -> void:
	play_motion()

func play_motion() -> void:
	target_transform = base_transform * offset_transform
	var time = transform.origin.distance_to(target_transform.origin)/speed
	tween.interpolate_property(self, "transform",
				transform, target_transform, time, Tween.TRANS_LINEAR)
	tween.start()

func reverse_motion() -> void:
	target_transform = base_transform
	var time = transform.origin.distance_to(target_transform.origin)/speed
	tween.interpolate_property(self, "transform",
				transform, target_transform, time, Tween.TRANS_LINEAR)
	tween.start()
