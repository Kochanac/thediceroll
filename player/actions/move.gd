class_name Move

extends Action

var force: float

func Act(d: Dice) -> void:
	d.linear_velocity += direction.normalized() * force


func _init(force: float, direction: Vector2):
	self.direction = direction
	self.force = force
