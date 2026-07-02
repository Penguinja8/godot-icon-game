extends Node

var cleared_levels = []


func restart_level():
	get_tree().call_deferred("change_scene_to_file", get_tree().root.get_child(-1).scene_file_path)
