extends Node2D

const SCALE_FACTOR = 100

const MOUSE_SCALE: float = 2.0

var is_aiming: bool = false
var focused_dice: Dice = null

signal action(dice, action)
# signal action(dice: Dice, action: Action)

var action_start: Vector2 = Vector2(0, 0)

func scale(velocity, factor=SCALE_FACTOR) -> int:
	return factor / (velocity + factor + 1)
	

func slow_time() -> void:
	var current_velocity = $DiceGroup/Dice.GetLinearVelocity().length()
	Engine.time_scale = scale(current_velocity)
	

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB"):
		slow_time()
		is_aiming = true
		self.action_start = get_global_mouse_position()
		self.focused_dice = $DiceGroup/Dice
		self.connect("action", focused_dice, "PerformAction")
		
	if event.is_action_released("LMB"):
		Engine.time_scale = 1
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

	

	if event.is_action_pressed("ui_slow_time"):
		slow_time()
	if event.is_action_released("ui_slow_time"):
		Engine.time_scale = 1


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
