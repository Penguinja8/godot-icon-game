extends CanvasLayer

func _process(_delta):
	var speed = snapped(abs(get_parent().velocity.x), 0.01)
	$VBoxContainer/Speed.text = "Speed: " + ("%.2f" % speed) + " px/s"
	$VBoxContainer/Stopwatch.text = "Time: " + ("%.2f" % snapped(GameState.level_timer, 0.01)) + " seconds"
