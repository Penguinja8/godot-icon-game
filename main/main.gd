extends CenterContainer


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main/level_select.tscn")
