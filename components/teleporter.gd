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
	if cooldown.is_stopped() and destination_teleporter:
		destination_teleporter.cooldown.start()
		body.global_position = destination_teleporter.global_position + ((body.global_position - global_position)/scale).slide(normal_dir).length() * destination_teleporter.normal_dir.orthogonal() + ((body.global_position - global_position)/scale).project(normal_dir).length() * destination_teleporter.normal_dir
		body.teleported((destination_teleporter.global_position-global_position).length(), destination_teleporter)
		body.velocity = destination_teleporter.velocity_mult * body.velocity.project(normal_dir).length() * destination_teleporter.normal_dir + body.velocity.slide(normal_dir).length() * destination_teleporter.normal_dir.orthogonal()#body.velocity.slide(destination_teleporter.normal_dir).normalized()
