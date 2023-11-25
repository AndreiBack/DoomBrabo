extends Node

var is_paused: bool =false

func _input(event):
	if event.is_action_pressed("pause"):
		if Input.is_action_just_pressed("pause"):
			is_paused = not is_paused
		if is_paused:
			get_tree().paused = true
		else:
			get_tree().paused = false
