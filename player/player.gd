class_name Player

extends Node2D

var money = 0

var is_invinc: bool = false

const TIME_COST: float = 1500.0


var focused_dice: Dice = null

const EXPERIENCE: int = 400

const STAMINA_BUFF: int = 100

signal action(dice, action)
# signal action(dice: Dice, action: Action)

var current_attack = AttackSwipe

#onready var player = get_node("DiceGroup/Dice/AnimationPlayer")


func _on_Enemy_died(enemy):
	print('enemy died')
	var dice = $DiceGroup/Dice
	if enemy is Enemy:
		dice.experience += EXPERIENCE
		
		$Stamina.reset_power_stamina()
		
		if dice.experience >= dice.EXP_FOR_LEVEL:
			dice.experience %= 1000
			dice.level += 1
			
			var ActiveCamera = get_node("DiceGroup/Dice/Dice/Camera2D")
			print(ActiveCamera.is_current())
			var sprite_name = str(dice.level) + ".png"
			var sprite = $DiceGroup/Dice/Dice/Sprite
			sprite.texture = load("res://images/dice/" + sprite_name)
			print("dice gained a new level")
		
		
func _on_Coin_gained(coin):
	print("coin gained")
	#max_time_stamina += STAMINA_BUFF
	#max_move_stamina += STAMINA_BUFF
	#max_power_stamina += STAMINA_BUFF
	money += 1


func _ready() -> void:
	var animation = $DiceGroup/Dice/Dice/Sprite
#	player.add_animation("new_level", animation)
	

func on_action_commanded(action: Action):
	if $Stamina.spend_action_stamina(action):
		emit_signal("action", action)
	
	self.disconnect("action", focused_dice.PerformAction)


func _input(event: InputEvent) -> void:
	if is_invinc:
		return

	if event.is_action_pressed("LMB") or event.is_action_pressed("RMB"):
		focused_dice = $Movement.focus_dice()
		self.connect("action", focused_dice.PerformAction)


func _physics_process(delta: float) -> void:
	if $Movement.is_time_tampered():
		if not $Stamina.spend_time_stamina(TIME_COST * delta):
			$Movement.start_time()


func _on_damage_taken(damage: int) -> void:
	$Movement.invinc(1.0)


func _process(_delta: float) -> void:
	var dice = $DiceGroup/Dice
	$"DiceGroup/Dice/Dice/Camera2D/CanvasLayer/GUI (margin)".SetLevel(dice.experience)

