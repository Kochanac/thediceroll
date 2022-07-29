extends Control


var game
	

func start():
	game = load("res://tower/tower.tscn").instantiate()
	get_parent().add_child(game)
	self.position = Vector2(-10000000, -10000000)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		stop()
		start()

func stop():
	get_parent().remove_child(game)


func _on_Button_pressed() -> void:
	start()
