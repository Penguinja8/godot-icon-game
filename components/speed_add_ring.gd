extends Area2D

@export var speed_add = 100
@export var size_scalar: Vector2 = Vector2(1,1)

func _ready():
	scale = size_scalar

func _on_body_entered(body: Node2D) -> void:
	body.velocity.x += speed_add * signf(body.velocity.x)
