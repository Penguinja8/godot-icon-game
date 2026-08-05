extends StaticBody2D

@export var required_keys: int = 1

func _process(_delta):
	if GameState.keys_collected >= required_keys:
		call_deferred("queue_free")
