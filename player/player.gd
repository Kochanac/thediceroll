extends Node2D

signal action(dice, action)
# signal action(dice: Dice, action: Action)

var action_start: Vector2 = Vector2(0, 0)


const MOUSE_SCALE: float = 2.0

var is_aiming: bool = false
var focused_dice: Dice = null

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB"):
		is_aiming = true
		self.action_start = get_global_mouse_position()
		self.focused_dice = $DiceGroup/Dice
		self.connect("action", focused_dice, "PerformAction")
		
	if event.is_action_released("LMB"):
		is_aiming = false
		var action_end = get_global_mouse_position()
		var act: Action = Move.new(
			min(
				action_start.distance_to(action_end) * MOUSE_SCALE,
				Action.MAX_FORCE),
			action_start.direction_to(action_end))
		
		emit_signal("action", act)
		self.disconnect("action", focused_dice, "PerformAction")
		
	if event.is_action_pressed("RMB"):
		var action_start = get_global_mouse_position()

func _process(_delta: float) -> void:
	if focused_dice == null:
		return
	if is_aiming:
		var mousePosition = get_global_mouse_position()
		focused_dice.Aiming(
			action_start.direction_to(mousePosition),
			min(action_start.distance_to(mousePosition) * MOUSE_SCALE,
				Action.MAX_FORCE))
	else:
		focused_dice.StopAiming()
