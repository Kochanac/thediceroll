class_name Coin
extends Node2D

signal gained(coin)

enum CoinType {
	none,
	stamina_buff,
	time_reset
}


func _on_hurtbox_area_entered(hitbox):
	if hitbox is Hitbox:
		emit_signal("gained", self)
		queue_free()


func get_type():
	return CoinType.none
