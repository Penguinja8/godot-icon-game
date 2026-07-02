extends Control

func _ready():
	var clear_time = GameState.get_level_timer()
	$Time.text = str(snappedf(clear_time, 0.01))
