class_name Hitbox

extends Area2D

var damage = 1

const START_TTL: float = 256
var ttl: float = START_TTL

func _ready():
	var timer = Timer.new()
	timer.connect("timeout", self.tick)
	add_child(timer)
	timer.start(0.01)

func tick():
	ttl -= 1
	$Sprite.modulate.a = ttl / START_TTL
	if (ttl / START_TTL) < 0.01:
		queue_free()
