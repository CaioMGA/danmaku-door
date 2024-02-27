extends Control

@export var foo: Curve

func _ready():
	setup_ui()
	update_bullet_rank_ui()
	update_enemy_rank_ui()
	
func setup_ui() -> void:
	# Enemy Rank
	$"Canvas/MarginContainer/Rank UI/VBoxContainer/Enemy Rank/Minus".connect("pressed", enemy_rank_down)
	$"Canvas/MarginContainer/Rank UI/VBoxContainer/Enemy Rank/Plus".connect("pressed", enemy_rank_up)
	$"Canvas/MarginContainer/Rank UI/VBoxContainer/Enemy Rank/Minus".connect("pressed", update_enemy_rank_ui)
	$"Canvas/MarginContainer/Rank UI/VBoxContainer/Enemy Rank/Plus".connect("pressed", update_enemy_rank_ui)
		
	# Bullet Rank
	$"Canvas/MarginContainer/Rank UI/VBoxContainer/Bullet Rank/Minus".connect("pressed", bullet_rank_down)
	$"Canvas/MarginContainer/Rank UI/VBoxContainer/Bullet Rank/Plus".connect("pressed", bullet_rank_up)
	$"Canvas/MarginContainer/Rank UI/VBoxContainer/Bullet Rank/Minus".connect("pressed", update_bullet_rank_ui)
	$"Canvas/MarginContainer/Rank UI/VBoxContainer/Bullet Rank/Plus".connect("pressed", update_bullet_rank_ui)


func enemy_rank_up() -> void:
	Globals.rank_up(Utils.RANK_TYPE.ENEMY)
func enemy_rank_down() -> void:
	Globals.rank_down(Utils.RANK_TYPE.ENEMY)
func enemy_rank_reset() -> void:
	Globals.rank_reset(Utils.RANK_TYPE.ENEMY)
	
func bullet_rank_up() -> void:
	Globals.rank_up(Utils.RANK_TYPE.BULLET)
func bullet_rank_down() -> void:
	Globals.rank_down(Utils.RANK_TYPE.BULLET)
func bullet_rank_reset() -> void:
	Globals.rank_reset(Utils.RANK_TYPE.BULLET)

func update_enemy_rank_ui() -> void:
	var rank_label = $"Canvas/MarginContainer/Rank UI/VBoxContainer/Enemy Rank/Value"
	rank_label.text = "%d" % [Globals.get_enemy_rank()]	

func update_bullet_rank_ui() -> void:
	var rank_label = $"Canvas/MarginContainer/Rank UI/VBoxContainer/Bullet Rank/Value"
	rank_label.text = "%d" % [Globals.get_bullet_rank()]	



