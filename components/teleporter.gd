extends Area2D
class_name Teleporter

## make it orange, else make it blue
@export var orange: bool = false
@export var destination_teleporter: Teleporter
@onready var cooldown = $ExitCooldown

func _ready():
	if orange:
		$Sprite2D.material.shader = load("res://components/teleporter_orange.gdshader")

func _on_body_entered(body: Node2D) -> void:
	if cooldown.is_stopped():
		destination_teleporter.cooldown.start()
		body.global_position = destination_teleporter.global_position
