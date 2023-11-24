extends AudioStreamPlayer2D

@onready var doom_soundtrack = $"../DoomSoundtrack"

func _on_finished():
	doom_soundtrack.play()
