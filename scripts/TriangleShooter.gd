extends Shooter

@export var target: Node
@export var bullet_scene = preload("res://scenes/bullets/spike.tscn")
@onready var aim = $Aim
@onready var moving_aim = $Aim/MovingAim

@export var h_spacing = 16.0
@export var v_spacing = 16.0
@export var shape_size = 4
@export var bullet_base_speed = 100.0


var targets = []

func _draw() -> void:
	draw_arc(aim.position, 8.0, 0, 360, 16, Color.YELLOW)
	draw_circle(moving_aim.position, 7, Color.RED)

func generate_targets():
	targets = []
	var i = 0
	while (i < shape_size):
		var j = -i/2.0
		while(j <= i/2.0):
			var t = {}
			t.x = aim.position.x + -i * v_spacing
			t.y = aim.position.y + j * h_spacing
			targets.append(t)
			j += 1.0
		i += 1.0
	print("targets generated: %d" % [targets.size()])

func _ready():
	generate_targets()

func shoot():
	var base_aim = aim.global_position.distance_to(global_position)
	for t in targets:
		var bullet = bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position
		moving_aim.position = Vector2.ZERO
		moving_aim.position.x = t.x
		moving_aim.position.y = t.y
		bullet.look_at(moving_aim.global_position)
		bullet.set_speed(bullet_base_speed * bullet.global_position.distance_to(moving_aim.global_position) / base_aim, 0.1, 0.01)
		#bullet.global_position = moving_aim.global_position
		
	# lead bullet
	#var bullet = bullet_scene.instantiate()
	#get_tree().root.add_child(bullet)
	#bullet.global_position = global_position
	#bullet.speed = (aim.global_position.distance_to(global_position)) / 60 * bullet_base_speed
	#bullet.rotation = rotation
	
func _process(delta):
	rotate(delta)
	pass
