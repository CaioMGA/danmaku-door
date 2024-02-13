extends Node2D

var diag = load("res://dialogues/fitness-gal.dialogue")

func _ready():
	DialogueManager.show_dialogue_balloon(diag, "start")
