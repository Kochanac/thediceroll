class_name Move

extends Action

var MOVE_K = 2

var force: float

# d: Dice
func Act(d) -> void:
	d.linear_velocity += direction.normalized() * force


func _init(force: float, direction: Vector2):
	self.direction = direction
	self.force = force * MOVE_K
