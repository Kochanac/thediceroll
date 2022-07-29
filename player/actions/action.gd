class_name Action
extends Node2D

var direction: Vector2
var force: float

const MAX_FORCE: float = 340.0

# _dice: Dice
func Act(_dice) -> void:
	return


func _init(direction: Vector2, force: float):
	self.direction = direction.normalized()
	self.force = force
