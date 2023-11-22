extends Label

func _process(delta):
	self.text =( "Highest kill count:" + str(Global.highest_kills))
