class_name Action

var direction: Vector2
var force: float

const MAX_FORCE: float = 500.0

# _dice: Dice
func Act(_dice) -> void:
	return


func _init(direction: Vector2, force: float):
	self.direction = direction
	self.force = force
