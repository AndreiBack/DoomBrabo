extends Label

func _process(delta):
	self.text =( "Kills:" + str(Global.kills))
