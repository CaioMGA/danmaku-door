extends Shooter
@onready var shoot_timer = $Timer
@export var target: Node
@export var bullet_scene = preload("res://scenes/bullets/spike.tscn")
@export var rotate_paralel_streams: bool = false

var min_bul_size:float = 0.5
var max_bul_size:float = 1.5

var min_bul_speed:float = 180.0
var max_bul_speed:float = 360.0

var min_stream_count:int = 1
var max_stream_count:int = 5

var min_bul_interval:float = 0.1
var max_bul_interval:float = 0.4

var bullet_size:float = 0.5
var bullet_speed:float = 1.5
var stream_count:int = 1
var bullet_interval:float = 0.1
var stream_spacing:float = 32
var stream_base_rotation:float = 5.0

var shooting:bool = false

func process_rank() -> void:
	stream_count = clampi(lerp(min_stream_count,max_stream_count,Globals.get_rank_enemy_percent()), min_stream_count, max_stream_count)
	bullet_speed = lerp(max_bul_speed, min_bul_speed, Globals.get_rank_bullet_percent())
	bullet_size = lerp(min_bul_size, max_bul_size, Globals.get_rank_bullet_percent())
	bullet_interval = lerp(min_bul_interval, max_bul_interval, Globals.get_rank_bullet_percent())

func toggle_shooting() -> void:
	if shooting:
		cease_fire()
		return

	enable_shooting()
	
func enable_shooting() -> void:
	shoot_timer.wait_time = bullet_interval
	shoot_timer.start()
	shoot_timer.timeout.connect(shoot)
	shooting = true

func cease_fire() -> void:
	shoot_timer.stop()
	shoot_timer.timeout.disconnect(shoot)
	shooting = false

func shoot() -> void:
	process_rank()
	if shoot_timer.wait_time != bullet_interval:
		shoot_timer.stop()
		shoot_timer.wait_time = bullet_interval
		shoot_timer.start()
	
	for i in range (0, stream_count):
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.global_rotation = global_rotation
		bullet.set_size(bullet_size)
		bullet.set_speed(bullet_speed, 1, 0.0)
		var max_slot = (stream_count - 1.0) / 2.0
		if !rotate_paralel_streams:
			bullet.global_position = global_position
			bullet.position.y += (-max_slot + i) * stream_spacing * bullet_size
		else:
			bullet.global_position = global_position
			bullet.rotation = deg_to_rad((-max_slot + i) * stream_base_rotation)
		bullet.reparent(get_tree().current_scene)
		#get_tree().current_scene.add_child(bullet)
#
func _process(delta):
	rotate(delta / 2.0)
