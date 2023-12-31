extends MarginContainer

const world = preload("res://world.tscn")
const first_scene = preload("res://FirstScene.tscn")

@onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
@onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
@onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector
@onready var sens_value = $Difficult/sens_value
@onready var mouse_slider = $Difficult/mouseSlider

var current_selection = 0

func _ready():
	set_current_selection(0)

func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection < 2:
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)

func handle_selection(_current_selection):
	if _current_selection == 0:
		$Difficult.show()
		#get_tree().change_scene_to_file("res://world.tscn")
		#queue_free()
	elif _current_selection == 1:
		get_tree().change_scene_to_file("res://FirstScene.tscn")
		queue_free()
	elif _current_selection == 2:
		get_tree().quit()

func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	if _current_selection == 0:
		selector_one.text = ">"
	elif _current_selection == 1:
		selector_two.text = ">"
	elif _current_selection == 2:
		selector_three.text = ">"


func _on_mouse_slider_value_changed(value):
	Global.MOUSE_SENS=value
	sens_value.text = str(value)



func _on_normal_button_down():
	Global.mode = 1
	get_tree().change_scene_to_file("res://world.tscn")
	queue_free()


func _on_hell_button_down():
	Global.mode = 2
	get_tree().change_scene_to_file("res://world.tscn")
	queue_free()
