extends Node3D
@onready var doom_soundtrack = $DoomSoundtrack
@onready var doom_soundtrack_2 = $DoomSoundtrack2

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	


func _on_ready():
	Global.kills = 0
	Global.enemy_move_speed = 1.5
	var music_selector = rng.randi_range(1.0, 2.0)
	if music_selector == 1.0:
		doom_soundtrack.play()
	elif  music_selector == 2.0:
		doom_soundtrack_2.play()
	print(music_selector)
