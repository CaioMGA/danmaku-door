extends Shooter
@onready var shoot_timer = $Timer
@export var target: Node
@export var bullet_scene = preload("res://scenes/bullets/spike.tscn")

var min_bul_size:float = 0.5
var max_bul_size:float = 1.5

var min_bul_speed:float = 100.0
var max_bul_speed:float = 250.0

var min_stream_count:int = 1
var max_stream_count:int = 6

var min_bul_interval:float = 0.1
var max_bul_interval:float = 1.0

var bullet_size = 0.5
var bullet_speed = 1.5
var stream_count:int = 1
@export var bullet_interval = 0.1
var stream_spacing = 32

var shooting = false

var targets = []

func process_rank():
	stream_count = clampi(lerp(min_stream_count, max_stream_count, Globals.get_enemy_rank_percent()), min_stream_count, max_stream_count)
	bullet_speed = lerp(max_bul_speed, min_bul_speed, Globals.get_bullet_rank_percent())
	bullet_size = lerp(min_bul_size, max_bul_size, Globals.get_bullet_rank_percent())
	bullet_interval = lerp(min_bul_interval, max_bul_interval, Globals.get_bullet_rank_percent())

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
	process_rank()
	if shoot_timer.wait_time != bullet_interval:
		shoot_timer.stop()
		shoot_timer.wait_time = bullet_interval
		shoot_timer.start()
	
	for i in range (0, stream_count):
		var bullet = bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position
		bullet.rotation = rotation
		bullet.set_size(bullet_size)
		bullet.set_speed(bullet_speed, 1, 0.0)
		var max_pos = (stream_count - 1.0) / 2.0
		print("%f" % [-max_pos + i+1])
		bullet.position.y += (-max_pos + i) * stream_spacing * bullet_size
#
#func _process(delta):
	#rotate(delta)

