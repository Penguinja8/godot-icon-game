extends Area2D

## y component necessary, x component optional
@export var shift_dir: Vector2 = Vector2(0,0)



func _on_body_entered(body: Node2D) -> void:
	if shift_dir:
		body.get_node("Camera2D").position = Vector2(shift_dir.x*500, shift_dir.y * 380)
	else:
		body.get_node("Camera2D").position.y = 0
