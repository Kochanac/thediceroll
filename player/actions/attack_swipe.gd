extends Action

class_name AttackSwipe

const SWIPE_K = 1
const SWIPE_VELOCITY_ADD = 500


func _init(direction: Vector2, force: float):
	super._init(direction, force)
	self.force *= SWIPE_K
	
func get_current_damage(dice):
	return 1

# d: Dice
func Act(d) -> void:
	assert(d is Dice)
	var dice: Dice = d
	var start_pos = dice.GetDicePosition()
	var end_pos = start_pos + direction * force
	
	var hitbox: Area2D = preload("res://player/actions/attack.tscn").instantiate()
	
	hitbox.rotation = direction.angle()
	hitbox.position = start_pos
	var rec: RectangleShape2D = hitbox.get_node("CollisionShape2D").shape
	
	hitbox.scale = Vector2((force / SWIPE_K / Action.MAX_FORCE), 1)
	
	hitbox.damage = get_current_damage(dice)
	
	dice.add_child(hitbox)

	
	dice.TeleportWithVector(direction * force)
	
	dice.linear_velocity = \
		(SWIPE_VELOCITY_ADD + dice.linear_velocity.length()) * direction

func get_min_stamina():
	return Action.MAX_FORCE * 2 / 3
