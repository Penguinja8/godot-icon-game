extends Control

func _ready():
	get_tree().paused = true

#func _process(_delta):
#	if Input.is_action_just_pressed("pause"):
#		_on_resume_pressed()

func _on_resume_pressed() -> void:
	get_tree().paused = false
	queue_free()


func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main/level_select.tscn")
