extends Control

func _ready():
	setup_ui()
	
func setup_ui():
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


func enemy_rank_up():
	Globals.enemy_rank += 1
	print("enemy rank up | enemy rank: %d" % [Globals.enemy_rank])
	pass
func enemy_rank_down():
	Globals.enemy_rank -= 1
	print("enemy rank down | enemy rank: %d" % [Globals.enemy_rank])
	pass
func enemy_rank_reset():
	Globals.enemy_rank  = 0
	print("enemy rank reset | enemy rank: %d" % [Globals.enemy_rank])
	pass

func update_enemy_rank_ui():
	$"Canvas/MarginContainer/Rank UI/VBoxContainer/Enemy Rank/Value".text = "%d" % [Globals.enemy_rank]	

func update_bullet_rank_ui():
	$"Canvas/MarginContainer/Rank UI/VBoxContainer/Bullet Rank/Value".text = "%d" % [Globals.bullet_rank]	

func bullet_rank_up():
	Globals.bullet_rank += 1
	print("bullet rank up | bullet rank: %d" % [Globals.bullet_rank])
func bullet_rank_down():
	Globals.bullet_rank -= 1
	print("bullet rank down | bullet rank: %d" % [Globals.bullet_rank])
func bullet_rank_reset():
	Globals.bullet_rank  = 0
	print("bullet rank reset | bullet rank: %d" % [Globals.bullet_rank])


