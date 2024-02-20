extends Node

@export var intro_done = false

var rank = {
	Utils.RANK_TYPE.ENEMY: 0.0,
	Utils.RANK_TYPE.BULLET: 0.0,
}

var rank_min:float = -10
var rank_max:float = 10

var selected_door: int = 0
var stages_data = {
	"1": {"gal":"fitness", "score": 0, "done":false},
	"2": {"gal":"nerd", "score": 0, "done":false},
	"3": {"gal":"punk", "score": 0, "done":false},
}

func select_door(door_num: int) -> void:
	selected_door = door_num

func get_selected_door() -> int:
	return selected_door

func start_selected_dialogue() -> void:
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

func get_rank_percent(type: Utils.RANK_TYPE) -> float:
	return Utils.inverse_lerp( rank[type], rank_min, rank_max)
	
func get_rank_enemy_percent() -> float:
	return get_rank_percent(Utils.RANK_TYPE.ENEMY)
	
func get_rank_bullet_percent() -> float:
	return get_rank_percent(Utils.RANK_TYPE.BULLET)

func rank_up(type: Utils.RANK_TYPE, amount:int = 1) -> void:
	rank[type] += amount
	if rank[type] > rank_max:
		rank[type] = rank_max

func rank_down(type: Utils.RANK_TYPE, amount:int = 1) -> void:
	rank[type] -= amount
	if rank[type] < rank_min:
		rank[type] = rank_min

func rank_reset(type: Utils.RANK_TYPE) -> void:
	rank[type] = 0

func get_bullet_rank() -> float:
	return rank[Utils.RANK_TYPE.BULLET]

func get_enemy_rank() -> float:
	return rank[Utils.RANK_TYPE.ENEMY]
