extends Area2D
@onready var sprite_2d = $Sprite2D

var speed:float
var base_speed:float
var minimum_speed:float
var minimum_speed_percent:float
var deacceleration:float

func set_speed(spd, min_spd_percent = 0.2, deacc = 0.1):
	base_speed = spd
	speed = spd
	minimum_speed_percent = min_spd_percent
	minimum_speed = base_speed * min_spd_percent
	deacceleration = deacc

func set_size(size):
	$Sprite2D.scale = Vector2(size, size)

func _process(delta):
	position += transform.x * speed * delta
	
	if speed > minimum_speed:
		speed *= 1.0 - deacceleration
		if speed < minimum_speed:
			speed = minimum_speed
