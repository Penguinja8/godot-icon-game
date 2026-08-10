extends CenterContainer

func _ready():
	var comp_screen = load("uid://d2chu33rufgae").instantiate()
	comp_screen.disable = true
	add_child(comp_screen)
	comp_screen.call_deferred("queue_free")
	GameState.load_game()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main/level_select.tscn")
