class_name Move

extends Action

var MOVE_K = 2

# d: Dice
func Act(_d) -> void:
	var d: Dice = _d
	d.linear_velocity += direction.normalized() * force


func _init(direction: Vector2, force: float).(direction, force):
	self.force *= MOVE_K
