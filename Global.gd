extends Node

var kills = 0
var highest_kills = 0
var enemy_move_speed = 1.5
var MOUSE_SENS = 0.5
var mode = 0
var full = false
func _process(delta):
	fullscreen()

	

func fullscreen():

	if Input.is_action_just_pressed("fullscreen"):
		if full == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			full = true
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			full = false
