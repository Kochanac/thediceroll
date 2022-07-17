class_name Enemy

extends KinematicBody2D

var health = 2

#signal died(enemy: Enemy)
signal died(enemy)

func _ready(): 
#	self.connect("died", $Player, "_on_Enemy_died")
# Tower/EnemyGroup/
# говнокод
	print(self.get_parent().get_parent())
	var tower: Tower = self.get_parent().get_parent()
	tower.register(self)

func die():
	emit_signal("died", self)
	queue_free()
	
	
func _on_hurtbox_area_entered(hitbox):
#	print("body entered")
	if hitbox is Hitbox:
		health -= hitbox.damage
		if health <= 0:
			self.die()
#	print(hitbox)



	


