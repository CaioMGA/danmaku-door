extends Area2D

func _on_area_entered(area) -> void:
	if area.is_in_group("enemy_bullets"):
		area.queue_free()
	
	if area.is_in_group("player_bullets"):
		area.queue_free()
