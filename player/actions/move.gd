class_name Move

extends Action

var force: float

func Act(d: Dice) -> void:
	d.linear_velocity += direction.normalized() * force
