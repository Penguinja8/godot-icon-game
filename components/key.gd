extends Area2D


func _on_body_entered(_body: Node2D) -> void:
	GameState.keys_collected += 1
	queue_free()
