extends RigidBody2D

var teleports: Array

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if teleports.size() > 0:
		var teleport = teleports.front()
		print(state.transform.origin)
		state.transform.origin += teleport
		teleports.pop_front()

func AddTeleport(vec: Vector2):
	teleports.append(vec)
