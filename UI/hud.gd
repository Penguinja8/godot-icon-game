extends CanvasLayer

func _process(_delta):
	$TestSpeed.text = str(get_parent().velocity.x)
	$Stopwatch.text = str(snapped(GameState.level_timer, 0.01))
	$TestFPS.text = str(Engine.get_frames_per_second())
