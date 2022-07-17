class_name Dice

extends Node2D

const STOP_VELOCITY: int = 25

const EXP_FOR_LEVEL: int = 1000
var level = 1
var boost = 0
# every EXP_FOR_LEVEL exp is a new level
var experience = 0

func _physics_process(delta: float) -> void:
	$hurtbox.position = $Dice.position

func PerformAction(a: Action) -> void:
	a.Act(self)


func Disable():
	$Dice/Sprite.modulate = Color(1, 1, 1, 0.8)
	$Dice/circle_shape.set_deferred("disabled", true)
	$hurtbox.set_deferred("monitoring", false)
	
	$Dice.linear_velocity = Vector2(0, 10)

func Enable():
	$Dice/Sprite.modulate = Color(1, 1, 1, 1)
	$Dice/circle_shape.set_deferred("disabled", false)
	$hurtbox.set_deferred("monitoring", true)
	
	$Dice.linear_velocity = Vector2(0, 0)


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

func _on_hurtbox_area_entered(node: Node) -> void:
	if node is Enemy:
		var pl = $"../.."
		#assert(pl is Player)
		pl._on_damage_taken(node.GetDamage())
