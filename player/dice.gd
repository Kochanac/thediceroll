class_name Dice

extends Node2D

const STOP_VELOCITY: int = 25


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

var linear_velocity setget SetLinearVelocity, GetLinearVelocity

func TeleportWithVector(vec: Vector2):
	$Dice.AddTeleport(vec)
