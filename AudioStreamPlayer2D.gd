extends AudioStreamPlayer2D

@onready var doom_soundtrack = $"."

func _on_finished():
	doom_soundtrack.play()
