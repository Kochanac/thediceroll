extends Action

class_name AttackSwipe

const SWIPE_K = 1
const SWIPE_VELOCITY_ADD = 700


func _init(direction: Vector2, force: float).(direction, force):
	self.force *= SWIPE_K
	
func get_current_damage(dice):
	return dice.level + dice.boost

# d: Dice
func Act(d) -> void:
	assert(d is Dice)
	var dice: Dice = d
	var start_pos = dice.GetDicePosition()
	var end_pos = start_pos + direction * force
	
#	print(dice.get_tree())
#	print(dice.get_tree().get_current_scene())
#	var rootnode = dice.get_tree().get_root()
#	print(rootnode)
#	print(start_pos, end_pos)
#	var space = dice.get_world_2d().direct_space_state
#	var exclude = [dice.get_node("Dice")]
#	var hit_enemy = space.intersect_ray(start_pos, end_pos, exclude)
#	print(hit_enemy)
#	if hit_enemy && hit_enemy["collider"] is Enemy:
#		print("Hooray!")
#		var damage = get_current_damage(dice)
#		hit_enemy["collider"].hurt(damage)
	
	var hitbox: Area2D = preload("res://player/actions/attack.tscn").instance()
	
	hitbox.rotation = direction.angle()
	hitbox.position = start_pos
	var rec: RectangleShape2D = hitbox.get_node("CollisionShape2D").shape
	
	hitbox.scale = Vector2((force / SWIPE_K / Action.MAX_FORCE), 1)
	
	hitbox.damage = get_current_damage(dice)
	
	dice.add_child(hitbox)

	
	dice.TeleportWithVector(direction * force)
	dice.linear_velocity = \
		(SWIPE_VELOCITY_ADD + dice.linear_velocity.length()) * direction
	
	
