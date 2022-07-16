extends RigidBody2D

var teleports: Array
var moves: Array

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	while teleports.size() > 0:
		var teleport = teleports.front()
		state.transform.origin += teleport
		teleports.pop_front()
	while moves.size() > 0:
		var move = moves.front()
		state.apply_impulse(self.transform.origin, move)
		moves.pop_front()

func AddTeleport(vec: Vector2):
	teleports.append(vec)

func AddMove(vec: Vector2):
	moves.append(vec)
