extends Node2D

const SCALE_FACTOR = 400
const MOUSE_SCALE: float = 2.0

const ACTION_MAX_LENGTH: float = Action.MAX_FORCE


# is movement enabled. If false, does not registers actions
var is_disabled = false


var is_aiming = false
var is_slowing = false
var mouse_offset = Vector2(0, 0)

var current_attack = AttackSwipe

var focused_dice: Dice

signal on_action_commanded(action: Action)


func is_time_tampered() -> bool:
	return is_aiming || is_slowing

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	connect("on_action_commanded", $"..".on_action_commanded)

func scale(velocity, factor=SCALE_FACTOR) -> float:
	return max(
		factor / (velocity + factor + 1) - 0.2,
		0.1
	)

func slow_time() -> void:
	var current_velocity = $"../DiceGroup/Dice".linear_velocity.length()
	Engine.time_scale = scale(current_velocity)

func start_time() -> void:
	Engine.time_scale = 1

func start_aim() -> void:
	slow_time()
	is_aiming = true
	self.mouse_offset = Vector2(0, 0)


var aimWg: Waitgroup = Waitgroup.new()
func stop_aim():
	is_aiming = false

	if not is_slowing and aimWg.TryZero():
		start_time()
	
	if $"../DiceGroup/Dice".linear_velocity.length() / 100 < 25:
		return
	
	aimWg.Add(1)
	await get_tree().create_timer(0.1).timeout
	aimWg.Sub(1)
	if not is_slowing and aimWg.TryZero():
		start_time()



func focus_dice() -> Dice:
	return $"../DiceGroup/Dice"


func _input(event: InputEvent) -> void:
	if is_disabled:
		return
	
	if event is InputEventMouseMotion:
		self.mouse_offset += event.relative

	if event.is_action_pressed("LMB") or event.is_action_pressed("RMB"):
		self.focused_dice = $"../DiceGroup/Dice"
		start_aim()
		
	if event.is_action_released("LMB"):
		var force: float = min(mouse_offset.length() * MOUSE_SCALE, ACTION_MAX_LENGTH)
		stop_aim()
		var act: Action = Move.new(mouse_offset, force)
		emit_signal("on_action_commanded", act)
		
		
	if event.is_action_released("RMB"):
		var force: float = min(mouse_offset.length() * MOUSE_SCALE, ACTION_MAX_LENGTH)
		stop_aim()
		var act: Action = current_attack.new(mouse_offset, force)
		
		emit_signal("on_action_commanded", act)

	if event.is_action_pressed("ui_slow_time"):
		slow_time()
		is_slowing = true
	if event.is_action_released("ui_slow_time"):
		start_time()
		is_slowing = false


func invinc(time: float) -> void:
	stop_aim()
	start_time()
	is_disabled = true
	$"../DiceGroup/Dice".Disable()
	
	var invinc: SceneTreeTimer = get_tree().create_timer(time)
	invinc.connect("timeout", self.invinc_end)

func invinc_end() -> void:
	is_disabled = false
	$"../DiceGroup/Dice".Enable()

func _process(_delta: float) -> void:
	if focused_dice == null:
		return

	if is_aiming:
		focused_dice.Aiming(
			mouse_offset,
			min(mouse_offset.length() * MOUSE_SCALE, ACTION_MAX_LENGTH))
	else:
		focused_dice.StopAiming()

