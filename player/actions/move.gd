class_name Move

extends Action

# var MOVE_K = 300 for ApplyImpulse
var MOVE_K = 4

# d: Dice
func Act(_d) -> void:
	var d: Dice = _d
	#d.ApplyImpulse(direction.normalized() * force)
	d.linear_velocity += direction.normalized() * force


func _init(direction: Vector2, force: float).(direction, force):
	self.force *= MOVE_K
