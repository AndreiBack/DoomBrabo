extends AudioStreamPlayer2D

@onready var doom_soundtrack_2 = $"../DoomSoundtrack2"
func _on_finished():
	doom_soundtrack_2.play()
