extends CenterContainer


func _ready():
	for button in $PanelContainer/BoxContainer.get_children():
		button.get_node("Panel/VBox/StartButton").pressed.connect(_go_to_scene.bind(button.level_path, button.level_name))

func _go_to_scene(path, level_name):
	GameState.current_level_name = level_name
	get_tree().change_scene_to_file(path)
