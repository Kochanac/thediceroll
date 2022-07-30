extends Node

var max_time_stamina: float = 1000.0
var max_move_stamina: float = 1000.0
var max_power_stamina: float = 1000.0

var time_stamina: float = max_time_stamina
var move_stamina: float = max_move_stamina
var power_stamina: float = max_power_stamina

var time_regen: float = 200
var move_regen: float = 200
var power_regen: float = 200

func spend_time_stamina(val: float) -> float:
	var spending = min(val, time_stamina)
	
	time_stamina -= spending
	return spending

func spend_move_stamina(val: float) -> float:
	var spending = min(val, move_stamina)
	
	move_stamina -= val
	return spending

func spend_power_stamina(val: float) -> float:
	var spending = min(val, power_stamina)
	
	power_stamina -= val
	return spending


func spend_action_stamina(action: Action) -> bool:
	var required_stamina = action.get_proposed_stamina()
	var spent: float
	
	if action is Move and move_stamina > action.get_min_stamina():
		spent = spend_move_stamina(action.get_proposed_stamina())
		return true

	if (not action is Move) and power_stamina > action.get_min_stamina():
		spent = spend_power_stamina(action.get_proposed_stamina())
		return true
	
	return false


func reset_power_stamina() -> void:
	power_stamina = max_power_stamina


func _physics_process(delta: float) -> void:
	time_stamina += time_regen * delta
	time_stamina = min(max_time_stamina, time_stamina)
	move_stamina += move_regen * delta
	move_stamina = min(max_move_stamina, move_stamina)
	power_stamina += time_regen * delta
	power_stamina = min(max_power_stamina, power_stamina)
	
	
	time_stamina = max(0, time_stamina)


func _process(_delta: float) -> void:
	$"../DiceGroup/Dice/Dice/Camera2D/CanvasLayer/GUI (margin)".SetStaminas(
		time_stamina / max_time_stamina,
		move_stamina / max_move_stamina,
		power_stamina / max_power_stamina
	)

