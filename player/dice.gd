class_name Dice

extends RigidBody2D

const STOP_VELOCITY: int = 25


func _physics_process(delta: float) -> void:
	print(self.linear_velocity.length())
	if self.linear_velocity.length() < STOP_VELOCITY:
		self.linear_velocity = Vector2(0, 0)

