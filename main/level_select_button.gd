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
		$VBox/BestTime.text = "No time set"
	

func _on_show_panel_pressed() -> void:
	$ShowPanel.visible = false
	$Panel.visible = true
