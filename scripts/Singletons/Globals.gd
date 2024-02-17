extends Node

@export var bullet_rank = 0
@export var enemy_rank = 0
@export var intro_done = false

var min_rank = -10
var max_rank = 10

var selected_door: int = 0
var stages_data = {
	"1": {"gal":"fitness", "score": 0, "done":false},
	"2": {"gal":"nerd", "score": 0, "done":false},
	"3": {"gal":"punk", "score": 0, "done":false},
}

func select_door(door_num: int):
	selected_door = door_num

func get_selected_door():
	return selected_door

func start_selected_dialogue():
	if selected_door == 1:
		print("Fitness gal Dialogue")
		var diag = load("res://dialogues/fitness-gal.dialogue")
		DialogueManager.show_dialogue_balloon(diag, "start")
	if selected_door == 2:
		print("Nerd gal Dialogue")
		var diag = load("res://dialogues/nerd-gal.dialogue")
		DialogueManager.show_dialogue_balloon(diag, "start")
	if selected_door == 3:
		print("Punk gal Dialogue")
		var diag = load("res://dialogues/punk-gal.dialogue")
		DialogueManager.show_dialogue_balloon(diag, "start")
			
func get_enemy_rank_percent():
	return Utils.inverse_lerp(enemy_rank, min_rank, max_rank)

func get_bullet_rank_percent():
	return Utils.inverse_lerp(bullet_rank, min_rank, max_rank)
