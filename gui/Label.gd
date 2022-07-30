extends Label

var player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	player = self
	for i in range(12):
		player = player.get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "x" + str(player.money)
