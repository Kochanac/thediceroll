extends MarginContainer


func SetStaminas(timeStamina: float, moveStamina: float, powerStamina: float):
	$"hbox/stamina bars/TimeBar".value = timeStamina * 1000
	$"hbox/stamina bars/MoveBar".value = moveStamina * 1000
	$"hbox/stamina bars/PowerBar".value = powerStamina * 1000
