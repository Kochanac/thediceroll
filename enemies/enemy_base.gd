class_name Enemy

extends KinematicBody2D

# потом надо будет поменять? мб в конструкторе рандомно генерить каждый раз
var health = 2

signal died

func die():
	emit_signal("died")
	queue_free()
	
	
func _on_hurtbox_area_entered(hitbox):
	print("body entered")
	health -= hitbox.damage
	if health <= 0:
		self.die()
	print(hitbox)


