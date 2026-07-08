extends Area2D
class_name Teleporter

## make it orange, else make it blue
@export var orange: bool = false
@export var destination_teleporter: Teleporter
@onready var cooldown = $ExitCooldown
@export var normal_dir: Vector2 = Vector2(1,0)
@export var velocity_mult: float = 1.0

func _ready():
	if orange:
		$Sprite2D.material.shader = load("res://components/teleporter_orange.gdshader")

func _on_body_entered(body: Node2D) -> void:
	if cooldown.is_stopped():
		destination_teleporter.cooldown.start()
		body.teleported((destination_teleporter.global_position-global_position).length(), destination_teleporter)
		body.global_position = destination_teleporter.global_position + (body.global_position - global_position).slide(normal_dir) + (body.global_position - global_position).project(normal_dir).length() * destination_teleporter.normal_dir
		body.velocity = velocity_mult * Vector2(body.velocity.x*normal_dir.x, body.velocity.y*normal_dir.y).length() * destination_teleporter.normal_dir + body.velocity.slide(normal_dir).length() * body.velocity.slide(destination_teleporter.normal_dir).normalized()
