extends Control
class_name LevelSelectButton

@export var level_path: String
@export var level_name: String
@export var level_clear_requirement: int = 0
@export var prerequisite_level: LevelSelectButton

func _ready():
	if GameState.debug_force_show_all_levels:
		pass
	else:
		if len(GameState.best_times.keys()) < level_clear_requirement:
			queue_free()
		if prerequisite_level:
			if not prerequisite_level.level_name in GameState.best_times.keys():
				queue_free()
	$VBox/LevelName.text = level_name
	if level_name in GameState.best_times.keys():
		$VBox/BestTime.text = "Best Time: " + str(snapped(GameState.best_times[level_name],0.01))
	else:
		if level_name == "Sandbox":
			$VBox/BestTime.text = ""
		else:
			$VBox/BestTime.text = "No time set"
	if level_name not in GameState.best_times:
		if level_name == "Sandbox":
			$VBox/StartButton.material.set_shader_parameter("base_color", GameState.colors[0])
		else:
			$VBox/StartButton.material = null
		return
	var time_index = 4
	var clear_time = GameState.best_times[level_name]
	var medal_times = GameState.MEDAL_TIMES[level_name]
	for i in range(len(medal_times)):
		if clear_time <= medal_times[i]:
			time_index = i
			break
	if time_index == 4:
		$VBox/StartButton.material = null
	else:
		var chosen_color = GameState.colors[time_index]
		$VBox/StartButton.material.set_shader_parameter("base_color", chosen_color)
	

func _on_show_panel_pressed() -> void:
	$ShowPanel.visible = false
	$Panel.visible = true
