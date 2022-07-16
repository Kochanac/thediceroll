extends Node2D

signal action(dice, action)
# signal action(dice: Dice, action: Action)

var action_start: Vector2 = Vector2(0, 0)

func _ready() -> void:
	var dice = $DiceGroup/Dice
	self.connect("action", $DiceGroup/Dice, "PerformAction")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB"):
		self.action_start = get_global_mouse_position()
		
	if event.is_action_released("LMB"):
		var action_end = get_global_mouse_position()
		var act: Action = Move.new(
			action_start.distance_to(action_end),
			action_start.direction_to(action_end))
		
		emit_signal("action", act)
		
	if event.is_action_pressed("RMB"):
		var action_start = get_global_mouse_position()
