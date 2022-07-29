extends Node2D
class_name Tower


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func register(enemy):
	if enemy is Enemy:
		enemy.connect("died", $Player._on_Enemy_died)
	if enemy is Coin:
		enemy.connect("gained", $Player._on_Coin_gained)


func _on_hurtbox_area_entered(area):
	pass # Replace with function body.
