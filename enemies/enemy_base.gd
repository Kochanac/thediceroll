class_name Enemy

extends Area2D

var health = 2

#signal died(enemy: Enemy)
signal died(enemy)

func die():
	emit_signal("died", self)
	queue_free()
	
	
func _on_hurtbox_area_entered(hitbox):
	if hitbox is Hitbox:
		health -= hitbox.damage
		if health <= 0:
			self.die()

func GetDamage() -> int:
	return 0
