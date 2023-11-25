extends Node3D
@onready var doom_soundtrack = $DoomSoundtrack
@onready var doom_soundtrack_2 = $DoomSoundtrack2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	


func _on_ready():
		if Global.mode == 1.0:
			doom_soundtrack.play()
		elif  Global.mode == 2.0:
			doom_soundtrack_2.play()


