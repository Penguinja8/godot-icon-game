extends Control


@export var level_path: String
@export var level_name: String

func _ready():
	$VBox/LevelName.text = level_name
	if level_name in GameState.best_times.keys():
		$VBox/BestTime.text = "Best Time: " + str(snapped(GameState.best_times[level_name],0.01))
	else:
		$VBox/BestTime.text = "No time set"
	

func _on_show_panel_pressed() -> void:
	$ShowPanel.visible = false
	$Panel.visible = true
