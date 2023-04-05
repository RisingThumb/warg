extends Node

var current_shrink = 2
var hsensitivity = 0.3;
var vsensitivity = 0.3;
var master_vol = 0
var music_vol = 0
var sfx_vol = 0
var fov = 90
var camera_tilt = true;
var gravity = -100

func _ready():
	OS.vsync_enabled = true
	Engine.target_fps = 60
