extends Node

var best_times = {}
var level_timer = 0.0
var current_level_name: String
var level_path: String

const MEDAL_TIMES = {
"Introduction": [12.90, 14.50, 17.00, 24.00],
"Spiky": [21.11, 24.00, 26.00, 29.50],
"Raised Stakes": [13.73, 14.50, 17.50, 21.20],
"Leap of Faith": [7.33, 7.50, 8.00, 9.00],
"Accelerator": [12.54, 14.70, 18.00, 23.5],
"Overspeed": [9.0, 14.50, 17.00, 20.5],
"Hadron": [2.81, 3.50, 4.25, 4.99], # need to adjust level still
"Portal": [21.59, 22.10, 25.00, 29.50],
"Lift": [23.05, 34.50, 38.00, 42.00],
"Rails": [16.55, 21.80, 23.30, 25.00],
"Roller Coaster": [17.56, 23.77, 24.50, 26.45]
}

## debug option to have all levels show in the level select, always
var debug_force_show_all_levels = true

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
