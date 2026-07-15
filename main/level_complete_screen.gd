extends Control

@export var colors: Array[Color]

func _ready():
	var clear_time = GameState.get_level_timer()
	if GameState.current_level_name not in GameState.best_times.keys():
		GameState.best_times[GameState.current_level_name] = clear_time
	else:
		if clear_time < GameState.best_times[GameState.current_level_name]:
			GameState.best_times[GameState.current_level_name] = clear_time
	$Time.text = "Clear time: " + str(snappedf(clear_time, 0.01))
	if GameState.current_level_name not in GameState.MEDAL_TIMES:
		return
	var time_index = 4
	var medal_times = GameState.MEDAL_TIMES[GameState.current_level_name]
	for i in range(len(medal_times)):
		if clear_time <= medal_times[i]:
			time_index = i
			break
	$Medal.material.set_shader_parameter("base_color", colors[time_index])

func _on_to_level_select_pressed() -> void:
	get_tree().change_scene_to_file("res://main/level_select.tscn")


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file(GameState.level_path)
