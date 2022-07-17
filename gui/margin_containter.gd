extends MarginContainer


func SetStaminas(timeStamina: float, moveStamina: float, powerStamina: float):
	$"hbox/stamina bars/TimeBar".value = timeStamina * 835
	$"hbox/stamina bars/MoveBar".value = moveStamina * 835
	$"hbox/stamina bars/PowerBar".value = powerStamina * 835


func SetLevel(experience: float):
	$"hbox/MarginContainer/cons and XP/coins and level (vbox)/HBoxContainer2/level".value = \
		experience * 835 / 1000
