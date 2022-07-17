class_name Move

extends Action


var MOVE_K = 4
var MOVE_K_IMPULSE = 100 # for apply_impulse

enum MOVING_SYSTEMS {linear_velocity, apply_impulse}
const MOVING_SYSTEM = MOVING_SYSTEMS.apply_impulse

# d: Dice
func Act(_d) -> void:
	var d: Dice = _d
	
	if MOVING_SYSTEM == MOVING_SYSTEMS.linear_velocity:
		d.linear_velocity += direction.normalized() * force
	if MOVING_SYSTEM == MOVING_SYSTEMS.apply_impulse:
		d.ApplyImpulse(direction.normalized() * force * MOVE_K_IMPULSE)
	


func _init(direction: Vector2, force: float).(direction, force):
	self.force *= MOVE_K
