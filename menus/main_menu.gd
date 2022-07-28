extends Control


var game
	

func start():
	game = load("res://tower/tower_denis.tscn").instance()
	print(game)
	add_child(game)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		stop()
		start()

func stop():
	remove_child(game)


func _on_Button_pressed() -> void:
	start()
