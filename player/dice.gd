class_name Dice

extends RigidBody2D

const STOP_VELOCITY: int = 25


func _physics_process(delta: float) -> void:
	#if self.linear_velocity.length() < STOP_VELOCITY:
	#	self.linear_velocity = Vector2(0, 0)
	pass

func PerformAction(a: Action) -> void:
	a.Act(self)
