extends Control

func _ready():
	$Time.text = str(snappedf(GameState.get_level_timer(), 0.01))
