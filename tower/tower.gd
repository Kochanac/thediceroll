extends Node2D
class_name Tower


func get_all_children(in_node, arr:=[]) -> Array[Node]:
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr


func _ready():
	for ch in get_all_children(self):
		register(ch)

func register(enemy):
	if enemy is Enemy:
		enemy.connect("died", $Player._on_Enemy_died)
	if enemy is Coin:
		enemy.connect("gained", $Player._on_Coin_gained)


func _on_hurtbox_area_entered(area):
	pass # Replace with function body.
