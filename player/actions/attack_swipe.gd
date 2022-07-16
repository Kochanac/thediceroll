extends Action

class_name AttackSwipe

const SWIPE_K = 1
const SWIPE_VELOCITY_ADD = 700

func _init(direction: Vector2, force: float).(direction, force):
	self.force *= SWIPE_K

# d: Dice
func Act(d) -> void:
	assert(d is Dice)
	var dice: Dice = d
	dice.TeleportWithVector(direction * force)
	dice.linear_velocity = \
		(SWIPE_VELOCITY_ADD + dice.linear_velocity.length()) * direction
	
