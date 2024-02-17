extends Area2D

class_name Player

signal on_player_hurt
signal on_player_loses_life

@export var normal_speed = 200
@export var focus_speed = 100

@export var regular_shoot_timer:Timer
@export var focus_shoot_timer:Timer

@export var collision_shape:CollisionShape2D
#@onready var audio_stream_player = $AudioStreamPlayer

var speed
var screen_size
var is_moving_slow = false
var is_focus_shooting = true
@export var life = 3

var can_shoot = false

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play("idle")
	$AnimatedSprite2D/AnimatedCore.play("idle")
	#regular_shoot_timer.stop()
	#focus_shoot_timer.stop()

func _process(delta):
	var velocity = Vector2.ZERO
	
	is_moving_slow = Input.is_action_pressed("focus_shot")
	
	if is_moving_slow:
		speed = focus_speed
		if !is_focus_shooting:
			is_focus_shooting = true
	else:
		speed = normal_speed
		if is_focus_shooting:
			is_focus_shooting = false
			
	if can_shoot :
		if is_focus_shooting:
			if focus_shoot_timer.is_stopped():
				regular_shoot_timer.stop()
				focus_shoot_timer.start()
		else:
			if regular_shoot_timer.is_stopped():
				regular_shoot_timer.start()
				focus_shoot_timer.stop()

	if Input.is_action_pressed("move_right"):
		velocity.x += 1;
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1;
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1;
	if Input.is_action_pressed("move_down"):
		velocity.y += 1;
	
	if velocity.x > 0:
		$AnimatedSprite2D.play("bank_right")
	elif velocity.x < 0:
		$AnimatedSprite2D.play("bank_left")
	else:
		$AnimatedSprite2D.play("idle")
		
	if velocity.length() > 0: # should move
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func play_hurt_animation():
	$AnimatedSprite2D.modulate.a = 0.5
	#$CollisionShape2D.set_disabled(true)

func play_normal_animation():
	$AnimatedSprite2D.modulate.a = 1.0
	#$CollisionShape2D.set_disabled(false)

func hurt():
	on_player_hurt.emit()

func _on_area_entered(area):
	if area.is_in_group("bullets"):
		hurt()

func cease_fire():
	can_shoot = false
	regular_shoot_timer.stop()
	focus_shoot_timer.stop()
	#audio_stream_player.stop()

func enable_shooting():
	can_shoot = true
	#audio_stream_player.play()

func _on_game_controller_enable_shooting():
	enable_shooting()

func _on_game_controller_cease_fire():
	pass # Replace with function body.
