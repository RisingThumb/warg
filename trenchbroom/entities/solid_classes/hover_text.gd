extends Area

signal pressed()

export(Dictionary) var properties setget set_properties

var hover_text:String = 'text';
var interactable: int = 0;
var interact_text = 'interact_text';
var delete_on_interact: int = 0;

func set_properties(new_properties: Dictionary) -> void:
	if properties != new_properties:
		properties = new_properties
		update_properties()

func update_properties() -> void:
	if 'hover_text' in properties:
		hover_text = properties.hover_text;
	if 'interactable' in properties:
		interactable = properties.interactable;
	if 'interact_text' in properties:
		interact_text = properties.interact_text;
	if 'delete_on_interact' in properties:
		delete_on_interact = properties.delete_on_interact

func raycastedByPlayer() -> void:
	if delete_on_interact != 0:
		queue_free();
	emit_pressed()

func emit_pressed() -> void:
	emit_signal("pressed")
