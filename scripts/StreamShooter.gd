extends Shooter
@onready var shoot_timer = $Timer
@export var target: Node
@export var bullet_scene = preload("res://scenes/bullets/spike.tscn")
@export var bullet_base_speed = 300.0
@export var bullet_interval = 0.1
var shooting = false

var targets = []

func toggle_shooting():
	if shooting:
		cease_fire()
		return

	enable_shooting()
	
func enable_shooting():
	shoot_timer.wait_time = bullet_interval
	shoot_timer.start()
	shoot_timer.timeout.connect(shoot)
	shooting = true

func cease_fire():
	shoot_timer.stop()
	shoot_timer.timeout.disconnect(shoot)
	shooting = false
	
func shoot():
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	bullet.rotation = rotation
	bullet.set_speed(bullet_base_speed, 0.1, 0.0)

func _process(delta):
	rotate(delta)
