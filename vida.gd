extends Label

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

func _process(delta):
	self.text =( "Life:" + str(player.playerLife))
