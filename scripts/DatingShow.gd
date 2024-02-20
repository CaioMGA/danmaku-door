extends Node2D

func _ready() -> void:
	if !Globals.intro_done:
		var diag = load("res://dialogues/dating-show.dialogue")
		DialogueManager.show_dialogue_balloon(diag, "start")
		Globals.intro_done = true
		#get_tree().reload_current_scene()
