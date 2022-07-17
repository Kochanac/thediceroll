class_name Dice

extends Node2D

const STOP_VELOCITY: int = 25

const EXP_FOR_LEVEL: int = 2
var level = 1
var boost = 0
# every EXP_FOR_LEVEL exp is a new level
var experience = 0



func _physics_process(delta: float) -> void:
	#if self.linear_velocity.length() < STOP_VELOCITY:
	#	self.linear_velocity = Vector2(0, 0)
	pass

func PerformAction(a: Action) -> void:
	a.Act(self)

func Aiming(direction: Vector2, lenght: float):
	$Arrow.position = $Dice.position
	$Arrow.visible = true
	$Arrow.rotation = direction.angle()
	$Arrow.scale = Vector2(lenght / $Arrow.texture.get_width(), 1)

func StopAiming():
	$Arrow.visible = false

func GetLinearVelocity() -> Vector2:
	return $Dice.linear_velocity

func SetLinearVelocity(vel: Vector2):
	$Dice.linear_velocity = vel

func GetDicePosition() -> Vector2:
	return $Dice.position


var linear_velocity setget SetLinearVelocity, GetLinearVelocity

func TeleportWithVector(vec: Vector2):
	$Dice.AddTeleport(vec)

func ApplyImpulse(vec: Vector2):
	$Dice.AddMove(vec)
