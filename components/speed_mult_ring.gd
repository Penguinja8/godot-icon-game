extends Area2D

@export var speed_mult = 1.7


func _on_body_entered(body: Node2D) -> void:
	body.velocity.x *= speed_mult
