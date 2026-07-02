extends Node

var best_times = {}
var level_timer = 0.0

func _process(delta):
	level_timer += delta

func start_level_timer():
	level_timer = 0.0

func get_level_timer():
	return level_timer

func restart_level():
	get_tree().call_deferred("change_scene_to_file", get_tree().root.get_child(-1).scene_file_path)

func level_complete():
	get_tree().call_deferred("change_scene_to_file", "res://main/level_complete_screen.tscn")
