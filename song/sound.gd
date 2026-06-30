extends AudioStreamPlayer

var playback: AudioStreamPlayback


func play_sound(dur: float = 0.2):
	set_stream(load("uid://dbuxt1ud34xs4"))
	play()
	playback = get_stream_playback()
	var img_data = []
	var img: Image = load("res://icon.svg").get_image()
	for x in range(img.get_width()):
		for y in range(img.get_height()):
			var pixel: Color = img.get_pixel(x,y)
			img_data.append(pixel.b + pixel.g + pixel.r)
	for i in range(playback.get_frames_available()):
		if i >= len(img_data):
			break
		playback.push_frame(Vector2.ONE*img_data[i])
	await get_tree().create_timer(dur).timeout
	stop()
