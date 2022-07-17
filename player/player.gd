extends Node2D

const SCALE_FACTOR = 400

const ACTION_COST: float = 500.0
const TIME_COST: float = 500.0

var max_time_stamina: float = 1000.0
var max_move_stamina: float = 1000.0
var max_power_stamina: float = 1000.0

var time_stamina: float = max_time_stamina
var move_stamina: float = max_move_stamina
var power_stamina: float = max_power_stamina

var time_regen: float = 200
var move_regen: float = 200
var power_regen: float = 200

const MOUSE_SCALE: float = 2.0

var is_aiming: bool = false
var is_slowing: bool = false
var focused_dice: Dice = null

signal action(dice, action)
# signal action(dice: Dice, action: Action)

var action_start: Vector2 = Vector2(0, 0)

var current_attack = AttackSwipe

func scale(velocity, factor=SCALE_FACTOR) -> float:
	return max(
		factor / (velocity + factor + 1) - 0.2,
		0.1
	)

func slow_time() -> void:
	var current_velocity = $DiceGroup/Dice.GetLinearVelocity().length()
	Engine.time_scale = scale(current_velocity)

func start_time() -> void:
	Engine.time_scale = 1

func start_aim() -> void:
	slow_time()
	is_aiming = true
	self.action_start = get_viewport().get_mouse_position()
	self.focused_dice = $DiceGroup/Dice
	self.connect("action", focused_dice, "PerformAction")

func stop_aim() -> Vector2:
	if not is_slowing:
		start_time()
	is_aiming = false
	return get_viewport().get_mouse_position()

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("LMB") or event.is_action_pressed("RMB"):
		start_aim()
		
	if event.is_action_released("LMB"):
		var action_end = stop_aim()
		var force = min(min(action_start.distance_to(action_end) * MOUSE_SCALE,
			Action.MAX_FORCE),
			move_stamina / ACTION_COST * Action.MAX_FORCE)

		var act: Action = Move.new(
			action_start.direction_to(action_end), force)
		
		move_stamina -= ACTION_COST * (force / Action.MAX_FORCE)
		emit_signal("action", act)
		self.disconnect("action", focused_dice, "PerformAction")
		
	if event.is_action_released("RMB"):
		
		var action_end = stop_aim()
		var force = min(min(action_start.distance_to(action_end) * MOUSE_SCALE,
			Action.MAX_FORCE),
			power_stamina / ACTION_COST * Action.MAX_FORCE)
		var act: Action = current_attack.new(
			action_start.direction_to(action_end), force)
		
		if power_stamina >= ACTION_COST * (1.0/2):
			power_stamina -= ACTION_COST * (force / Action.MAX_FORCE)
			emit_signal("action", act)
		self.disconnect("action", focused_dice, "PerformAction")

	if event.is_action_pressed("ui_slow_time"):
		slow_time()
		is_slowing = true
	if event.is_action_released("ui_slow_time"):
		start_time()
		is_slowing = false


func _physics_process(delta: float) -> void:
	time_stamina += time_regen * delta
	time_stamina = min(max_time_stamina, time_stamina)
	move_stamina += move_regen * delta
	move_stamina = min(max_move_stamina, move_stamina)
	power_stamina += time_regen * delta
	power_stamina = min(max_power_stamina, power_stamina)
	
	if is_aiming or is_slowing:
		time_stamina -= TIME_COST * delta
		if time_stamina < 0:
			start_time()
	
	time_stamina = max(0, time_stamina)


func _process(_delta: float) -> void:
	$"DiceGroup/Dice/Dice/Camera2D/CanvasLayer/GUI (margin)".SetStaminas(
		time_stamina / max_time_stamina,
		move_stamina / max_move_stamina,
		power_stamina / max_power_stamina
	)
	if focused_dice == null:
		return

	if is_aiming:
		var mousePosition = get_viewport().get_mouse_position()
		focused_dice.Aiming(
			action_start.direction_to(mousePosition),
			min(action_start.distance_to(mousePosition) * MOUSE_SCALE,
				Action.MAX_FORCE))
	else:
		focused_dice.StopAiming()
