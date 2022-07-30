extends Label

var player

var speed: int = 0

func _process(_delta):
	self.text = "SPEED: " + str(speed)
