extends Area2D
class_name Coin

signal gained(coin)

func _ready(): 
# Tower/CoinGroup/
# говнокод
	print(self.get_parent().get_parent())
	var tower = self.get_parent().get_parent()
	tower.register(self)


func _on_hurtbox_area_entered(hitbox):
	if hitbox is Hitbox:
		emit_signal("gained", self)
		queue_free()
