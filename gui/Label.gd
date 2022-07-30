extends Label

var player

var money: int = 0

func _process(delta):
	self.text = "x" + str(money)
