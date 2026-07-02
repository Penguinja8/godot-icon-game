extends Area2D
class_name Teleporter

@export var destination_teleporter: Teleporter


func _on_body_entered(body: Node2D) -> void:
	body.global_position = destination_teleporter.global_position
